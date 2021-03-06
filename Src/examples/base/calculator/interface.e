note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class 
	INTERFACE

create
	make

feature {NONE}

	make (k, m: STRING; c: STATE)
			-- Fill out key with `k', command with `c' and message with `m'.
		do
			operator_key := k
			associated_command := c
			help_message := m
		ensure
			operator_key = k
			associated_command = c
			help_message = m
		end

feature

	operator_key: STRING
		-- Letter key associated to an operation.

	associated_command: STATE
		-- Associated state.

	help_message: STRING;
		-- Help message.

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class INTERFACE
