indexing
	description:
		"A demo for multi-column-list";
	date: "$Date$";
	revision: "$Revision$"

class
	MULTI_COLUMN_LIST_ITEM

inherit
	DEMO_ITEM
		redefine
			demo_window
		end

creation
	make

feature {NONE} -- Initialization

	make (par:EV_TREE_ITEM_HOLDER) is
			-- Create the item and the demo that
			-- goes with it.
		do
			make_with_title (par, "EV_MULTI_COLUMN_LIST")
			set_example_path("demo_windows/multi_column_list_window.e")
			set_docs_path("documentation/multi_column_list_documentation.txt")
			set_class_path("EV_MULTI_COLUMN_LIST")
		end

	create_demo is
			-- Create the demo_window.
		do
			!! demo_window.make (demo_page)
		end


	


feature -- Access

	demo_window: MULTI_COLUMN_LIST_WINDOW


end -- class MULTI_COLUMN_LIST_DEMO

--|----------------------------------------------------------------
--| EiffelVision Tutorial: Example for the ISE EiffelVision library.
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
