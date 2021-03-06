note
	description: "Abstract description of an assigner call."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ASSIGNER_CALL_AS

inherit
	INSTRUCTION_AS

create
	initialize

feature {NONE} -- Initialization

	initialize (t: like target; s: like source; a_as: like assignment_symbol)
			-- Create a new ASSIGNER CALL AST node.
		require
			t_not_void: t /= Void
			s_not_void: s /= Void
		do
			target := t
			source := s
			assignment_symbol := a_as
		ensure
			target_set: target = t
			source_set: source = s
			assignment_symbol_set: assignment_symbol = a_as
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_assigner_call_as (Current)
		end

feature -- Roundtrip

	assignment_symbol: detachable SYMBOL_AS
			-- Symbol ":=" associated with this structure

feature -- Attributes

	target: EXPR_AS
			-- Target of the assignment

	source: EXPR_AS
			-- Source of the assignment

feature -- Roundtrip

	index: INTEGER
			-- <Precursor>
		do
			if attached assignment_symbol as s then
				Result := s.index
			end
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := target.first_token (a_list)
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := source.last_token (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (source, other.source) and then
				equivalent (target, other.target)
		end

feature -- Settings

	set_source (s: like source)
			-- Set `source' with `s'.
		require
			s_not_void: s /= Void
		do
			source := s
		ensure
			source_set: source = s
		end

invariant
	target_not_void: target /= Void
	source_not_void: source /= Void

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
