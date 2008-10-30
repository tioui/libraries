indexing

	description:
		"Server root-class for the same_mach example."
	legal: "See notice at end of class.";

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class OUR_SERVER

inherit

	SOCKET_RESOURCES

	STORABLE

create

	make

feature

	soc1, soc2: NETWORK_STREAM_SOCKET

	make (argv: ARRAY [STRING]) is
			-- Accept communication with client and exchange messages
		local
			count: INTEGER
		do
			if argv.count /= 2 then
				io.error.putstring ("Usage: ")
				io.error.putstring (argv.item (0))
				io.error.putstring (" portnumber%N")
			else
				create soc1.make_server_by_port (argv.item (1).to_integer)
				from
					soc1.listen (5)
					count := 0
				until
					count = 3
				loop
					process -- See below
					count := count + 1
				end
				soc1.cleanup
			end
		rescue
			soc1.cleanup
		end

	process is
			-- Receive a message, extend it, and send it back.
		local
			our_new_list: OUR_MESSAGE
		do
			soc1.accept
			soc2 ?= soc1.accepted
			our_new_list ?= retrieved (soc2)
			from
				our_new_list.start
			until
				our_new_list.after
			loop
				io.putstring (our_new_list.item)
				our_new_list.forth
				io.new_line
			end
			our_new_list.extend ("%N I'm back.%N")
			our_new_list.general_store (soc2)
			soc2.close
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end

