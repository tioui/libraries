indexing
	description:
		"Eiffel Vision multi column list row. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_MULTI_COLUMN_LIST_ROW_I

inherit
	EV_ITEM_I
		redefine
			interface,
			parent_imp,
			pixmap_equal_to
		end

	EV_PICK_AND_DROPABLE_I
		redefine
			interface
		end

	EV_PIXMAPABLE_I
		undefine
			pixmap_equal_to
		redefine
			interface,
			pixmap_equal_to
		end

	EV_DESELECTABLE_I
		redefine
			interface,
			is_selectable
		end

	EV_MULTI_COLUMN_LIST_ROW_ACTION_SEQUENCES_I

feature -- Status report

	is_selectable: BOOLEAN is
			-- May the tree item be selected.
		do
			Result := parent /= Void
		end

feature -- Element Change

	set_pixmap (a_pix: EV_PIXMAP) is
			-- Set the rows `pixmap' to `a_pix'.
		deferred
		end
		
	pixmap: EV_PIXMAP is
			-- `Result' is pixmap displayed in `Current'.
			-- We do not simply return `internal_pixmap' as
			-- the image must be stretched to fit the size allocated
			-- by `parent'.
		do
			Result := clone (internal_pixmap)
			if internal_pixmap /= Void and then parent /= Void and then internal_pixmap.width /= parent_imp.pixmaps_width and then internal_pixmap.height /= parent_imp.pixmaps_height then
				Result.stretch (parent_imp.pixmaps_width, parent_imp.pixmaps_height)
			end
		end

	internal_pixmap: EV_PIXMAP
			-- Pixmap used at the start of the row.

	remove_pixmap is
			-- Remove the rows pixmap.
		deferred			
		end

	parent_imp: EV_MULTI_COLUMN_LIST_IMP is
			-- Parent implementation of `Current'.
		deferred
		end

feature {NONE} -- Contract support

	pixmap_equal_to (a_pixmap: EV_PIXMAP): BOOLEAN is
			-- Is `a_pixmap' equal to `pixmap'?
		local
			scaled_pixmap: EV_PIXMAP
			multi_column_list: EV_MULTI_COLUMN_LIST
		do
			if parent /= Void then
				scaled_pixmap := clone (a_pixmap)
				multi_column_list ?= parent
				scaled_pixmap.stretch (multi_column_list.pixmaps_width, multi_column_list.pixmaps_height)
			else
				scaled_pixmap := a_pixmap		
			end
			Result := scaled_pixmap.is_equal (pixmap)
		end
		
feature {EV_MULTI_COLUMN_LIST_ROW} -- Implementation

	on_item_added_at (an_item: STRING; item_index: INTEGER) is
			-- `an_item' has been added to index `item_index'.
		deferred
		end

	on_item_removed_at (an_item: STRING; item_index: INTEGER) is
			-- `an_item' has been removed from index `item_index'.
		deferred
		end
		
feature {EV_ANY_I} -- Implementation

	interface: EV_MULTI_COLUMN_LIST_ROW

end -- class EV_MULTI_COLUMN_LIST_ROW_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

