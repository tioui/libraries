note

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	FONT_LIST_I

inherit
	G_ANY_I
		export
			{NONE} all
		undefine
			copy,
			is_equal
		end;

feature -- Access

	first: FONT
			-- Item at first position
		require
			not_empty: not empty
		deferred
		end;

	item: like first
			-- Item at cursor position
		require
			not_off: not off
		deferred
		end;

	i_th alias "[]" (i: INTEGER): like first
			-- Item at `i'_th position
		require
			index_large_enough: i >= 1;
			index_small_enough: i <= count;
		deferred
		end;

	last: like first
			-- Item at last position
		require
			not_empty: not empty
		deferred
		end;

	position: INTEGER
			-- Current cursor position, 0 if empty
		deferred
		end;

feature -- Measurement

	count: INTEGER
			-- Number of items in the chain
		deferred
		end

feature -- Status report

	empty: BOOLEAN
			-- Is the chain empty?
		deferred
		end;

	off: BOOLEAN
			-- Is cursor off?
		deferred
		end;

	offleft: BOOLEAN
			-- Is cursor off left edge?
		deferred
		end;

	offright: BOOLEAN
			-- Is cursor off right edge?
		deferred
		end;

	isfirst: BOOLEAN
			-- Is cursor at first position in the chain?
		deferred
		ensure
			Result implies (not empty)
		end;

	islast: BOOLEAN
			-- Is cursor at last position in the chain?
		deferred
		ensure
			Result implies (not empty)
		end;

feature -- Status setting

	destroy
			-- Destroy current font list.
		deferred
		end;

feature -- Cursor movement

	start
			-- Move cursor to first position.
		deferred
		ensure
			empty or isfirst
		end;

	finish
			-- Move cursor to last position
			-- (no effect if chain is empty).
		deferred
		ensure
			empty or islast
		end;

	forth
			-- Move cursor forward one position.
		require
			not empty and then position <= count
		deferred
		ensure
			position >= 1 and position <= count + 1
		end;

	back
			-- Move cursor backward one position.
		require
			not_offleft: position > 0
		deferred
		end;

	move (i: INTEGER)
			-- Move cursor `i' positions.
		require
			stay_right: position + i >= 0;
			stay_left: position + i <= count + 1;
			not_empty_unless_zero: empty implies i=0;
		deferred
		end;

	go (i: INTEGER)
			-- Move cursor to position `i'.
		require
			index_large_enough: i >= 0;
			index_small_enough: i <= count + 1;
			not_empty_unless_zero: empty implies i=0;
		deferred
		ensure
			position_set: position = i
		end;

	search_equal (v: like first)
			-- Move cursor to first position
			-- (at or after current cursor position)
			-- where item is equal to `v' (shallow equality);
			-- go off right if none.
		require
			search_element_exists: v /= Void
		deferred
		ensure
			valid: (not off) implies (v.is_equal (item))
		end;

	index_of (v: like first; i: INTEGER): INTEGER
			-- Index of `i'-th item `v'; 0 if none
		require
			positive_occurrence: i > 0
		deferred
		ensure
			positive_result: Result >= 0
		end;

	has (v: like first): BOOLEAN
			-- Does `v' appear in the chain ?
		deferred
		end

invariant
	empty_is_zero_cnt:
		empty = (count = 0);
	off_is_offleft_or_offright:
		off = ((position = 0) or else (position = count + 1));
	isfirst_is_pos_one:
		isfirst = (position = 1);
	islast_is_pos_cnt:
		islast = (not empty and (position = count));
	non_negative_count: count >= 0;
	non_negative_position: position >= 0
	stay_on: position <= count + 1;
	empty_implies_off: empty implies off;
	empty_implies_zero_pos:
		empty implies position = 0;
	not_on_empty:
		empty implies not (isfirst or islast)

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- FONT_LIST_I

