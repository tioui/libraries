indexing 
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 
 
class
	FONT_LIST_WINDOWS 
 
inherit 
	FONT_LIST_I	
		rename
			position as index,
			go as go_i_th,
			offleft as before,
			offright as before
		end

	LINKED_LIST [FONT]
		rename
			make as ll_make
		export
			{NONE} ll_make
		end

creation
	make

feature -- Initialization

	make (a_font_list: FONT_LIST) is
			-- Make the list.
		do
			ll_make
		end

feature -- Obsolete 

	search_equal (v: FONT) is
		obsolete "Use .compare_objects, search"
		do
		end

feature -- Inapplicable

	destroy is
		do
		end
 
end -- class FONT_LIST_WINDOWS
 
--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
