indexing

	description:
		"EiffelVision tree item, implementation interface.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_TREE_ITEM_I

inherit
	EV_ITEM_I

	EV_TREE_ITEM_CONTAINER_I

feature {NONE} -- Initialization

	make_with_text (par: EV_TREE_ITEM_CONTAINER; txt: STRING) is
			-- Create a tree-item with `txt' as label and
			-- `par' as parent.
		deferred
		end

feature -- Status report

	is_expanded: BOOLEAN is
			-- is the item expanded ?
		require
			exists: not destroyed
		deferred
		end

feature -- Event : command association

	add_subtree_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is
			-- Add 'command' to the list of commands to be
			-- executed when the menu item is activated
		require
			exists: not destroyed
		deferred
		end

end -- class EV_TREE_ITEM_I

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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
