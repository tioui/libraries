/*
	Eiffel Net C interfacing --- 	.../library/net/Clib/storable.c
*/


#include "eif_config.h"
#include "eif_portable.h" 	/* required for VMS, recommended for others */

#include "eif_except.h"		/* eraise */
#include "eif_store.h"
#include "eif_retrieve.h"
#include "rt_compress.h"
#include "eif_error.h"    	/* for eio() */
#include "eif_traverse.h"
#include "eif_lmalloc.h"

#ifdef EIF_WIN32
#include "winsock.h"
#define GET_SOCKET_ERROR WSAGetLastError()
#define EWOULDBLOCK WSAEWOULDBLOCK
#else
#include <sys/types.h>		/* select */
#include <sys/time.h>		/* select */
#define SOCKET_ERROR -1
#define GET_SOCKET_ERROR errno
#endif

#define SOCKET_UNAVAILABLE_FOR_WRITING "Socket unavailable for writing"
#define SOCKET_UNAVAILABLE_FOR_READING "Socket unavailable for reading"

#define EIF_BUFFER_SIZE EIF_CMPS_IN_SIZE

rt_private int socket_fides;
extern void idr_flush (void);

/* Returns nonzero if the socket is ready for, zero otherwise */
/* read = 0, check the socket to be rrready for writing */
/* read = 1, check the socket to be ready for reading */ 
int net_socket_ready (int read)
{
	struct timeval tm;
	fd_set fdset;
	int num_active;

	/* Maximum time we should wait for the socket to be ready */
	tm.tv_sec = 60;
	tm.tv_usec = 0;

	
	/* If the select call is interrupted (GET_SOCKET_ERROR =
           EINTR), we have to do the select again */
	for (;;)
	{
		FD_ZERO (&fdset);
		FD_SET (socket_fides, &fdset);

		if (read) {
			/* Wait until the socket is ready for reading*/
			num_active = select (socket_fides + 1, &fdset, NULL, NULL,
					     &tm);
		} else {
				/* Wait until the socket is ready for writing*/
			num_active = select (socket_fides + 1, NULL, &fdset, NULL,
					     &tm);
		}
		
		if (num_active != SOCKET_ERROR) {
			break;
		} else if (GET_SOCKET_ERROR != EINTR)  {
			eio();
		}
	} 

	return (FD_ISSET (socket_fides, &fdset));
}

int net_char_read(char *pointer, int size)
{
	GTCX
	int i;

retry:
#ifdef EIF_WIN32
	i = recv(socket_fides, pointer, size, 0);
#else
	i = read(socket_fides, pointer, size);
#endif
	if (i == SOCKET_ERROR && GET_SOCKET_ERROR == EWOULDBLOCK)
	{
		if (!net_socket_ready(1))
		{
			/* The desired socket is not ready. Raise an
			   exception. */
			eraise(SOCKET_UNAVAILABLE_FOR_READING, EN_RETR);
		} else {	
			/* Should not issue a recursive call here as this may
			   potentially lead to an unbounded number of recursive
			   calls, thus causing stack overflow should the
			   socket issue this error many times in succession. */
			goto retry;
		}
	}
	else if (i > 0 && i < size)
	{
		int prev = i;

		/* A recursive call here is bounded because the remaining
		   number of bytes is guaranteed to decrease each call. */
		i = net_char_read(pointer + i, size - i);
		if (i > 0)
			i += prev;
	}
	return i;
	EDCX
}

int net_char_write(char *pointer, int size)
{
	int i;
retry:
#ifdef EIF_WIN32
	i = send(socket_fides, pointer, size, 0);
#else
	i = write(socket_fides, pointer, size);
#endif
	if (i == SOCKET_ERROR  &&  GET_SOCKET_ERROR == EWOULDBLOCK)
	{
		if (!net_socket_ready(0))
		{
			/* The desired socket is not ready. Raise an
			   exception. */
			eraise(SOCKET_UNAVAILABLE_FOR_WRITING, EN_RETR);
		} else {
			/* Should not issue a recursive call here as this may
			   potentially lead to an unbounded number of recursive
			   calls, thus causing stack overflow should the
			   socket issue this error many times in succession. */
			goto retry;
		}
	}
	else if (i > 0 && i < size)
	{
		const int prev = i;

		/* A recursive call here is bounded because the remaining
		   number of bytes is guaranteed to decrease each call. */
		i = net_char_write(pointer + i, size - i);
		if (i > 0)
			i += prev;
	}
	return i;
}

void net_store_write(void)
{
	char* cmps_in_ptr = (char *)0;
	char* cmps_out_ptr = (char *)0;
	int cmps_in_size = 0;
	int cmps_out_size = 0;
	register char * ptr = (char *)0;
	register int number_left = 0;
	int number_writen = 0;

	cmps_in_ptr = general_buffer;
	cmps_in_size = current_position;
	cmps_out_ptr = cmps_general_buffer;
 
	eif_compress ((unsigned char*)cmps_in_ptr,
					(unsigned long)cmps_in_size,
					(unsigned char*)cmps_out_ptr,
					(unsigned long*)&cmps_out_size);
 
	ptr = cmps_general_buffer;
	number_left = cmps_out_size + EIF_CMPS_HEAD_SIZE;

	while (number_left > 0) {
		number_writen = net_char_write (ptr, number_left);

		if (number_writen <= 0)
			eio();
		number_left -= number_writen;
		ptr += number_writen;
	}

	if (ptr - cmps_general_buffer == cmps_out_size + EIF_CMPS_HEAD_SIZE)
		current_position = 0;
	else
		eio();
}

rt_public char *eif_net_retrieved(EIF_INTEGER file_desc)
{
	EIF_GET_CONTEXT
	socket_fides = file_desc;

	return portable_retrieve(net_char_read);
	EIF_END_GET_CONTEXT
}

rt_public void eif_net_basic_store(EIF_INTEGER file_desc, char *object)
{
	socket_fides = file_desc;

	rt_init_store(
			net_store_write,
			net_char_write,
			flush_st_buffer,
			st_write,
			make_header,
			0,
			EIF_BUFFER_SIZE);

	basic_general_free_store(object);

	rt_reset_store();
}

rt_public void eif_net_general_store(EIF_INTEGER file_desc, char *object)
{
	socket_fides = file_desc;

	rt_init_store(
			net_store_write,
			net_char_write,
			flush_st_buffer,
			gst_write,
			make_header,
			TR_ACCOUNT,
			EIF_BUFFER_SIZE); 

	basic_general_free_store(object);

	rt_reset_store();
}

rt_public void eif_net_independent_store(EIF_INTEGER file_desc, char *object)
{
	socket_fides = file_desc;

	rt_init_store(
			net_store_write,
		   	net_char_write,
			idr_flush,
			ist_write,
			imake_header,
			INDEPEND_ACCOUNT,
			EIF_BUFFER_SIZE); 

	independent_free_store (object);
	rt_reset_store();
}

