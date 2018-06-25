﻿note
	description: "A configuration target option."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_TARGET_OPTION

inherit
	CONF_OPTION
		redefine
			copy,
			default_create,
			is_empty,
			make_6_3,
			make_16_11,
			merge
		end

create
	default_create,
	make_6_3,
	make_6_4,
	make_7_0,
	make_7_3,
	make_14_05,
	make_15_11,
	make_16_11,
	make_18_01

feature {NONE} -- Creation

	default_create
			-- <Precursor>
		do
			make_18_01
		end

	make_6_3
			-- <Precursor>
		do
			Precursor
			create concurrency.make (concurrency_name, concurrency_index_none)
			create void_safety_capability.make (void_safety)
			create catcall_safety_capability.make (catcall_detection)
			create concurrency_capability.make (concurrency)
		end

	make_16_11
			-- <Precursor>
			-- Difference from `make_15_11`: SCOOP for concurrency.
		do
			Precursor
			concurrency.put_default_index (concurrency_index_scoop)
		end

feature -- Status report

	is_empty: BOOLEAN
			-- <Precursor>
		do
			Result := Precursor and then
				not catcall_safety_capability.is_root_set and then
				not concurrency.is_set and then
				not concurrency_capability.is_root_set and then
				not void_safety_capability.is_root_set
		end

	has_capability: BOOLEAN
			-- Are there explicitly set capabilities?
		do
			Result :=
				catcall_detection.is_set or else
				catcall_safety_capability.is_root_set or else
				concurrency.is_set or else
				concurrency_capability.is_root_set or else
				void_safety.is_set or else
				void_safety_capability.is_root_set
		end

feature -- Capability

	void_safety_capability: CONF_ORDERED_CAPABILITY
			-- Capability settings for void safety.

	catcall_safety_capability: CONF_ORDERED_CAPABILITY
			-- Capability settings for catcall safety.

	concurrency_capability: CONF_ORDERED_CAPABILITY
			-- Capability settings for concurrency.

feature -- Access: concurrency

	concurrency: CONF_VALUE_CHOICE
			-- Concurrency option.

	concurrency_index_thread: NATURAL_8 = 1
			-- Option index for thread-based concurrency.
			-- This is the lowest level, least restricted.

	concurrency_index_none: NATURAL_8 = 2
			-- Option index for no concurrency.

	concurrency_index_scoop: NATURAL_8 = 3
			-- Option index for SCOOP concurrency.
			-- This is the highest level, most restricted.

feature -- Merging

	merge (other: like Current)
			-- <Precursor>
		do
			Precursor (other)
				-- Merge concurency capability.
			concurrency_capability.set_safely (other.concurrency_capability)
				-- Merge CAT-call and void safety: only root settings need to be merged because capabilities are merged by precursor.
			catcall_safety_capability.set_safely_root (other.catcall_safety_capability)
			void_safety_capability.set_safely_root (other.void_safety_capability)
		end

feature -- Duplication

	copy (other: like Current)
			-- <Precursor>
		do
			if other /= Current then
				Precursor (other)
					-- Make copies of capabilities with appropriate values and update root values.
				create catcall_safety_capability.make (catcall_detection)
				catcall_safety_capability.put_root_index (other.catcall_safety_capability.custom_root_index)
				create concurrency_capability.make (concurrency)
				concurrency_capability.put_root_index (other.concurrency_capability.custom_root_index)
				create void_safety_capability.make (void_safety)
				void_safety_capability.put_root_index (other.void_safety_capability.custom_root_index)
			end
		end

feature {NONE} -- Access: concurrency

	concurrency_name: ARRAY [READABLE_STRING_32]
			-- Available values for `concurrency' option.
		once
			Result := <<
					{CONF_CONSTANTS}.concurrency_multithreaded_name.as_string_32,
					{CONF_CONSTANTS}.concurrency_none_name.as_string_32,
					{CONF_CONSTANTS}.concurrency_scoop_name.as_string_32
				>>
		ensure
			result_attached: Result /= Void
		end

invariant
	consistent_catcall_detection: catcall_safety_capability.value = catcall_detection
	consistent_concurrency: concurrency_capability.value = concurrency
	consistent_void_safety: void_safety_capability.value = void_safety

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
