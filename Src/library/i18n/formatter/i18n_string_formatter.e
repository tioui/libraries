note
	description: "Class that provides a feature to replace tokens in a string by provided values"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_STRING_FORMATTER

inherit
	ANY
		redefine
			default_create
		end

create
	default_create,
	make_with_escape_character

feature {NONE} -- Initialization

	default_create
			-- Initialize with default escape character '$'.
		do
			escape_character := '$'
		ensure then
			default_escape_character_set: escape_character = '$'
		end

	make_with_escape_character (a_escape_character: CHARACTER)
			-- Initialize with `a_escape_character' as escape_character
			--
			-- `a_escape_character': Character used to escape replacement tokens
		do
			escape_character := a_escape_character
		ensure
			escape_character_set: escape_character = a_escape_character
		end

feature -- Access

	escape_character: CHARACTER
			-- Character used to escape replacement tokens

feature -- Element Change

	set_escape_character (a_character: like escape_character)
			-- Set `escape_character' with `a_character'.
			--
			-- `a_character': Character used to escape replacement tokens
		do
			escape_character := a_character
		ensure
			escape_character_set: escape_character = a_character
		end

feature -- Basic operations

	formatted_string (a_string: READABLE_STRING_GENERAL; args_tuple: TUPLE): STRING_32
			-- String which has it's tokens replaced by given values
			--
			-- The string given can have token placeholders. The placeholder has
			-- the form `a_escape_charater' followed by the tuple index.
			--
			-- `a_string': Original string with possible token placeholders
			-- `args_tuple': Values which will be replaced in the placeholders
			-- `Result': String which has token placeholders replaced with values
		require
			a_string_not_void: a_string /= Void
			args_tuple_not_void: args_tuple /= Void
			valid_arguments: valid_arguments (args_tuple)
			enough_arguments: required_arguments (a_string) <= args_tuple.count
		local
			l_list: LIST [STRING_32]
			i : INTEGER
			l_list_item,
			l_string: STRING_32
			l_id: INTEGER
		do
			l_list := a_string.as_string_32.split (escape_character)
			create Result.make_empty
			from
					-- Append first string to Result
				l_list.start
				Result.append (l_list.item)
				l_list.forth
			until
				l_list.after
			loop
				l_list_item := l_list.item
				if l_list_item.is_empty then
						-- It wasn't an escape_character
					Result.append_character (escape_character)
				else
						-- it's possibly an escape_character
					from
						i := 1
						l_string := l_list_item.substring (i, i)
					until
						i > l_list_item.count or not l_string.is_integer
					loop	--extract the number
						i := i + 1
						l_string := l_list_item.substring (i, i)
					end
					l_string := l_list_item.substring (1, i - 1)
					if l_string.is_integer then
							-- It was en escape character
						l_id := l_string.to_integer

							--FIXME!!! HACK because 'out' in ANY possibly gives a STRING_8 and this is not so good for STRING_32
						if attached {READABLE_STRING_GENERAL} args_tuple.item (l_id) as test then
							Result.append_string_general (test)
						else
							if attached args_tuple.item (l_id) as a_arg then
								Result.append (a_arg.out)
							end
						end

						Result.append (l_list_item.substring (i, l_list_item.count).twin)
					else
							-- It should not be considered as escape character
						Result.append_character (escape_character)
						Result.append (l_list_item)
					end
				end
				l_list.forth
			end
		ensure
			result_exists: Result /= Void
		end

feature -- Check functions

	valid_arguments (a_tuple: TUPLE) : BOOLEAN
			-- Are all values in the tuple non-void?
		require
			a_tuple_not_void: a_tuple /= Void
		local
			i : INTEGER
		do
			from
				Result := True
				i := 1
			until
				i > a_tuple.count or not Result
			loop
				Result := Result and a_tuple.item (i) /= Void
				i := i + 1
			end
		end

	required_arguments (a_string: READABLE_STRING_GENERAL): INTEGER
			-- The number of arguments which `a_string' needs to have replaced
		require
			a_string_not_void: a_string /= Void
		local
			l_list: LIST [STRING_32]
			l_list_item: STRING_32
			i : INTEGER
			l_string: STRING_32
		do
			l_list := a_string.as_string_32.split (escape_character)
			Result := 0
			from
				l_list.start
				l_list.forth
			until
				l_list.after
			loop
				l_list_item := l_list.item
				if not l_list_item.is_empty then
					from
						i := 1
						l_string := l_list_item.substring (i, i)
					until
						i > l_list_item.count or not l_string.is_integer
					loop	--extract the number
						i := i + 1
						l_string := l_list_item.substring (i, i)
					end
					l_string := l_list_item.substring (1, i-1)
					Result := Result.max (l_string.to_integer)
				end
				l_list.forth
			end
		ensure
			result_not_negative: Result >= 0
			result_correct: a_string.as_string_32.has_substring (escape_character.out + Result.out)
		end

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
