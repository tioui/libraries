--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"General notion of command history."
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

	next_undo_command: EV_UNDOABLE_COMMAND is
			-- Returns the command that is next in the undo queue
		require
			can_undo: can_undo
		deferred
		end

	next_redo_command: EV_UNDOABLE_COMMAND is
			-- Returns the command that is next in the redo queue
		require
			can_redo: can_redo
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

	fake_undo is
			-- Moves the history cursor to the next undo position,
			-- but does not execute the command.
		require
			can_undo: can_undo
		deferred
		end

	fake_redo is
			-- Moves the history cursor to the next redo position,
			-- but does not execute the command.
		require
			can_redo: can_redo
		deferred
		end

end -- class EV_HISTORY

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.7  2000/02/29 18:09:08  oconnor
--| reformatted indexing cluase
--|
--| Revision 1.6  2000/02/22 18:39:48  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.5  2000/02/14 11:40:48  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.2  2000/01/27 19:30:44  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.1  1999/11/24 17:30:46  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:11  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
