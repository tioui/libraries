indexing
	description: "Default factory implementation for `INI_AST_FACTORY'"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INI_DEFAULT_NODE_FACTORY

inherit
	INI_NODE_FACTORY

feature {INI_PARSER}

	new_id_node (a_id: STRING; a_span: INI_TEXT_SPAN): INI_ID_NODE is
			--
		do
			create Result.make (a_id, a_span)
		end

	new_value_node (a_value: STRING; a_span: INI_TEXT_SPAN): INI_VALUE_NODE is
			--
		do
			create Result.make (a_value, a_span)
		end

	new_symbol_node (a_symbol: STRING; a_span: INI_TEXT_SPAN): INI_SYMBOL_NODE is
			--
		do
			create Result.make (a_symbol, a_span)
		end

	new_section_node (a_open: INI_SYMBOL_NODE; a_label: INI_ID_NODE; a_close: INI_SYMBOL_NODE): INI_SECTION_NODE is
			--
		do
			create Result.make (a_open, a_label, a_close)
		end

	new_property_node (a_id: INI_ID_NODE; a_assigner: INI_SYMBOL_NODE; a_value: INI_VALUE_NODE): INI_PROPERTY_NODE is
			--
		do
			create Result.make (a_id, a_assigner, a_value)
		end

	new_literal_node (a_id: STRING; a_span: INI_TEXT_SPAN): INI_LITERAL_NODE is
			--
		do
			create Result.make (a_id, a_span)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class {INI_DEFAULT_AST_FACTORY}
