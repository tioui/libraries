
indexing

	description:
		"General finite state automata, implemented as lists";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class LINKED_AUTOMATON [S -> STATE] inherit

	LINKED_LIST [S]

create

	make

feature -- Status setting

	set_final (state, f: INTEGER) is
			-- Make `state' a final state for regular expression `f'.
		require
			is_in_automaton: state <= count and state >= 1
		local
			old_p: CURSOR
		do
			old_p := cursor;
			go_i_th (state);
			item.set_final (f);
			go_to (old_p)
		ensure
			same_index: index = old index 
		end 

end -- class LINKED_AUTOMATON

--|----------------------------------------------------------------
--| EiffelLex: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

