indexing

	description:
		"``Active'' data structures, which at every stage have %
		%a possibly undefined ``current item''. %
		%Basic access and modification operations apply to the current item.";

	status: "See notice at end of class";
	names: active, access;
	access: membership;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class ACTIVE [G] inherit

	BAG [G]

feature -- Access

	item: G is
			-- Current item
		require
			readable: readable
		deferred
		end;

feature -- Status report

	readable: BOOLEAN is
			-- Is there a current item that may be read?
		deferred
		end;

	writable: BOOLEAN is
			-- Is there a current item that may be modified?
		deferred
		end;

feature -- Element change

	replace (v: G) is
			-- Replace current item by `v'.
		require
			writable: writable
		deferred
		ensure
			item_replaced: item = v
		end;

feature -- Removal

	remove is
			-- Remove current item.
		require
			prunable: prunable;
			writable: writable
		deferred
		end;

invariant

	writable_constraint: writable implies readable;
	empty_constraint: empty implies (not readable) and (not writable)

end -- class ACTIVE


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
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

