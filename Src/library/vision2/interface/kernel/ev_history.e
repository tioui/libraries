indexing
	description: "General notion of command history."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_HISTORY

feature -- Access

	can_undo: BOOLEAN is
			-- Is there any command recorded that may be undone?
		deferred
		end
		
	can_redo: BOOLEAN is
			-- Is there any undone command that may be redone?
		deferred
		end

feature -- Basic operations

	record (cmd: EV_UNDOABLE_COMMAND) is
			-- Record `cmd' in Current history.
		require
			cmd_not_void: cmd /= Void
		deferred
		end

	undo is
			-- Undo the last recorded command
		require
			can_undo: can_undo
		deferred
		end

	redo is
			-- Redo the last undone command
		require
			can_undo: can_redo
		deferred
		end

end -- class EV_HISTORY

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
