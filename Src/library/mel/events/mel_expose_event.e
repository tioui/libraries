indexing

	description: 
		"Implementation of the XExposeEvent.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_EXPOSE_EVENT

inherit

	MEL_EVENT

creation
	make

feature -- Access

	x: INTEGER is
			-- X position of exposed area
		do
			Result := c_event_x (handle)
		end;

	y: INTEGER is
			-- Y position of exposed area
		do
			Result := c_event_y (handle)
		end;

	width: INTEGER is
			-- Width of exposed area
		do
			Result := c_event_width (handle)
		end;

	height: INTEGER is
			-- Height of exposed area
		do
			Result := c_event_height (handle)
		end;

	count: INTEGER is
			-- Number of expose events to come
		do
			Result := c_event_count (handle)
		end;

feature {NONE} -- Implementation

	c_event_x (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XExposeEvent *): EIF_INTEGER"
		end;

	c_event_y (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XExposeEvent *): EIF_INTEGER"
		end;

	c_event_width (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XExposeEvent *): EIF_INTEGER"
		end;

	c_event_height (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XExposeEvent *): EIF_INTEGER"
		end;

	c_event_count (event_ptr: POINTER): INTEGER is
		external
			"C [macro %"events.h%"] (XExposeEvent *): EIF_INTEGER"
		end;

end -- class MEL_EXPOSE_EVENT

--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

