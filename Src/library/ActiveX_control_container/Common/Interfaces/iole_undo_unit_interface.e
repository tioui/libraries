note
	description: "Control interfaces. Help file: "
	legal: "See notice at end of class."
	status: "See notice at end of class."
	generator: "Automatically generated by the EiffelCOM Wizard."

deferred class
	IOLE_UNDO_UNIT_INTERFACE

inherit
	ECOM_INTERFACE

feature -- Status Report

	do1_user_precondition (p_undo_manager: IOLE_UNDO_MANAGER_INTERFACE): BOOLEAN
			-- User-defined preconditions for `do1'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	get_description_user_precondition (p_bstr: CELL [STRING]): BOOLEAN
			-- User-defined preconditions for `get_description'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	get_unit_type_user_precondition (p_clsid: ECOM_GUID; pl_id: INTEGER_REF): BOOLEAN
			-- User-defined preconditions for `get_unit_type'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

	on_next_add_user_precondition: BOOLEAN
			-- User-defined preconditions for `on_next_add'.
			-- Redefine in descendants if needed.
		do
			Result := True
		end

feature -- Basic Operations

	do1 (p_undo_manager: IOLE_UNDO_MANAGER_INTERFACE)
			-- No description available.
			-- `p_undo_manager' [in].  
		require
			do1_user_precondition: do1_user_precondition (p_undo_manager)
		deferred

		end

	get_description (p_bstr: CELL [STRING])
			-- No description available.
			-- `p_bstr' [out].  
		require
			non_void_p_bstr: p_bstr /= Void
			get_description_user_precondition: get_description_user_precondition (p_bstr)
		deferred

		ensure
			valid_p_bstr: p_bstr.item /= Void
		end

	get_unit_type (p_clsid: ECOM_GUID; pl_id: INTEGER_REF)
			-- No description available.
			-- `p_clsid' [out].  
			-- `pl_id' [out].  
		require
			non_void_p_clsid: p_clsid /= Void
			valid_p_clsid: p_clsid.item /= default_pointer
			non_void_pl_id: pl_id /= Void
			get_unit_type_user_precondition: get_unit_type_user_precondition (p_clsid, pl_id)
		deferred

		end

	on_next_add
			-- No description available.
		require
			on_next_add_user_precondition: on_next_add_user_precondition
		deferred

		end

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




end -- IOLE_UNDO_UNIT_INTERFACE

