note
	description: "[
			Component responsible to send email using an external mailer
			i.e: an external tool such as sendmail or a script, ...
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	NOTIFICATION_EXTERNAL_MAILER

inherit
	NOTIFICATION_MAILER

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_exe: READABLE_STRING_GENERAL; args: detachable ITERABLE [READABLE_STRING_GENERAL])
			-- Initialize `Current'.
		do
			set_parameters (a_exe, args)
		end

	executable_path: PATH

	arguments: detachable ARRAYED_LIST [READABLE_STRING_GENERAL]

	stdin_mode_set: BOOLEAN
			-- Use `stdin' to pass email message, rather than using local file?

	stdin_termination_sequence: detachable READABLE_STRING_8
			-- Termination sequence for the stdin mode
			--| If any, this tells the executable all the data has been provided
			--| For instance, using sendmail, you should have "%N.%N%N"

feature -- Status

	is_available: BOOLEAN
		do
			Result := (create {RAW_FILE}.make_with_path (executable_path)).exists
		end

	last_succeed: BOOLEAN
			-- Last notification succeed?

feature -- Change

	set_parameters (cmd: READABLE_STRING_GENERAL; args: detachable ITERABLE [READABLE_STRING_GENERAL])
			-- Set parameters `executable_path' and associated `arguments'
		local
			l_args: like arguments
		do
			create executable_path.make_from_string (cmd)
			if args = Void then
				arguments := Void
			else
				create l_args.make (5)
				across
					args as c
				loop
					l_args.force (c.item)
				end
				arguments := l_args
			end
		end

	set_stdin_mode (b: BOOLEAN; v: like stdin_termination_sequence)
			-- Set the `stdin_mode_set' value
			-- and provide optional termination sequence when stdin mode is selected.
		do
			stdin_mode_set := b
			stdin_termination_sequence := v
		end

feature -- Basic operation

	process_email (a_email: NOTIFICATION_EMAIL)
		local
			l_factory: PROCESS_FACTORY
			args: like arguments
			p: detachable PROCESS
			retried: INTEGER
			err: BOOLEAN
		do
			last_succeed := False
			if retried = 0 then
				create l_factory
				if stdin_mode_set then
					p := l_factory.process_launcher (executable_path.name, arguments, Void)
					p.set_hidden (True)
					p.set_separate_console (False)

					p.redirect_input_to_stream
					p.launch
					if p.launched then
						p.put_string (a_email.message)
						if attached stdin_termination_sequence as v then
							p.put_string (v)
						end
						p.put_string ("%N") -- End Of Input file.
					end
				else
					if attached arguments as l_args then
						args := l_args.twin
					else
						if attached new_temporary_file (generator) as f then
							f.create_read_write
							f.put_string (a_email.message)
							f.close
							create args.make (1)
							args.force (f.path.name)
						else
							err := True
							-- FAILURE !
							check should_not_occur: False end
						end
					end
					if not err then
						p := l_factory.process_launcher (executable_path.name, args, Void)
						p.set_hidden (True)
						p.set_separate_console (False)

						p.launch
					end
				end
				if p /= Void and then p.launched and then not p.has_exited then
					last_succeed := True
					execution_environment.sleep (1_000)
					p.wait_for_exit
					if not p.has_exited then
						p.terminate
						if not p.has_exited then
							execution_environment.sleep (1_000)
							p.wait_for_exit
						end
					end
				end
			elseif retried = 1 then
				if p /= Void and then p.launched and then not p.has_exited then
					p.terminate
					if not p.has_exited then
						execution_environment.sleep (1_000)
						p.wait_for_exit
					end
				end
			end
		rescue
			retried := retried + 1
			retry
		end

feature {NONE} -- Implementation

	new_temporary_file (a_prefix: detachable READABLE_STRING_8): detachable RAW_FILE
			-- Create file with temporary name.
		local
			retried: INTEGER
			l_prefix: READABLE_STRING_GENERAL
		do
			if retried <= 3 then
					-- Try 3 times...
				if attached {EXECUTION_ENVIRONMENT}.temporary_directory_path as tmp then
					if a_prefix /= Void then
						l_prefix := tmp.extended (a_prefix).name
					else
						l_prefix := tmp.extended ("tmp-").name
					end
					create Result.make_open_temporary_with_prefix (l_prefix)
				elseif a_prefix /= Void then
					create Result.make_open_temporary_with_prefix (a_prefix)
				else
					create Result.make_open_temporary
				end
			end
		ensure
			new_temporary_file_exists: Result /= Void implies Result.exists
			result_is_open_write: Result /= Void implies Result.is_open_write
		rescue
			retried := retried + 1
			retry
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
