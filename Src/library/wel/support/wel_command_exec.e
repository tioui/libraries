indexing
	description: "Execute commands."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_COMMAND_EXEC

create
	make

feature -- Initialization

	make (a_command: WEL_COMMAND; an_argument: ANY) is
			-- Set `command' and `argument' with 
			-- `a_command' and `an_argument'.
		require
			a_command_not_void: a_command /= Void
		do
			command := a_command
			argument := an_argument
		ensure
			command_set: command = a_command
			argument_set: argument = an_argument
		end

feature -- Access

	command: WEL_COMMAND
			-- User-defined command to execute

	argument: ANY
			-- Argument to be given to `command' before execution

feature -- Execution

	execute (window: WEL_WINDOW; message: INTEGER; wparam, lparam: POINTER) is
			-- Create message information corresponding to `message'
			-- and execute `command'.
		require
			window_not_void: window /= Void
			positive_message: message >= 0
		local
			creator: WEL_MESSAGE_INFORMATION_CREATOR
		do
			create creator.make (window, message, wparam, lparam)
			command.set_message_information (creator.message_information)
			command.execute (argument)
		end

end -- class WEL_COMMAND_EXEC

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

