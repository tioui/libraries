note

	description: 
		"Callback structure specific to the list. %
		%Associated C structure is XmListCallbackStruct."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_LIST_CALLBACK_STRUCT

inherit

	MEL_ANY_CALLBACK_STRUCT
		redefine
			reasons_list
		end;

create
	make

feature -- Access

	reasons_list: ARRAY [INTEGER]
			-- List of reasons that is valid for this
			-- callback structure
			-- (Reasons - XmCR_APPLY, XmCR_CANCEL, XmCR_OK, XmCR_NO_MATCH)
		once
			Result := 
			<<XmCR_BROWSE_SELECT, XmCR_DEFAULT_ACTION, XmCR_EXTENDED_SELECT,
				XmCR_MULTIPLE_SELECT, XmCR_SINGLE_SELECT>>
		end;

	item: MEL_STRING
			-- Item selected
		local
			ptr: POINTER
		do
			ptr := c_item (handle);
			if ptr /= default_pointer then
				create Result.make_from_existing (ptr);
				Result.set_shared
			end
        ensure
            Result_is_shared: Result /= Void implies Result.is_shared
		end;

	item_length: INTEGER
			-- Number of bytes in `item'
		do
			Result := c_item_length (handle)
		end;

	item_position: INTEGER
			-- Item's position within `items' table
		do
			Result := c_item_position (handle)
		end;

	selected_items: MEL_STRING_TABLE
			-- Selected items
		do
			create Result.make_from_existing (c_selected_items (handle), selected_item_count)
		ensure
			valid_result: Result /= Void 
		end;

	selected_item_count: INTEGER
			-- Number of selected items
		do
			Result := c_selected_item_count (handle)
		end;

	selected_item_positions: POINTER
			-- Integer array of selected positions
		do
			Result := c_selected_item_positions (handle)
		end;

	selection_type: INTEGER
			-- Type of most recent selection
		do
			Result := c_item_length (handle)
		end

feature {NONE} -- Implementation

	c_item (a_callback_struct_ptr: POINTER): POINTER
		external
			"C [macro %"callback_struct.h%"] (XmListCallbackStruct *): EIF_POINTER"
		end;

	c_item_length (a_callback_struct_ptr: POINTER): INTEGER
		external
			"C [macro %"callback_struct.h%"] (XmListCallbackStruct *): EIF_INTEGER"
		end;

	c_item_position (a_callback_struct_ptr: POINTER): INTEGER
		external
			"C [macro %"callback_struct.h%"] (XmListCallbackStruct *): EIF_INTEGER"
		end;

	c_selected_items (a_callback_struct_ptr: POINTER): POINTER
		external
			"C [macro %"callback_struct.h%"] (XmListCallbackStruct *): EIF_POINTER"
		end;

	c_selected_item_count (a_callback_struct_ptr: POINTER): INTEGER
		external
			"C [macro %"callback_struct.h%"] (XmListCallbackStruct *): EIF_INTEGER"
		end;

	c_selected_item_positions (a_callback_struct_ptr: POINTER): POINTER
		external
			"C [macro %"callback_struct.h%"] (XmListCallbackStruct *): EIF_POINTER"
		end;

	c_selection_type (a_callback_struct_ptr: POINTER): INTEGER
		external
			"C [macro %"callback_struct.h%"] (XmListCallbackStruct *): EIF_INTEGER"
		end;

	XmINITIAL: INTEGER
		external
			"C [macro <Xm/List.h>]: EIF_INTEGER"
		alias
			"XmINITIAL"
		end;

	XmMODIFICATION: INTEGER
		external
			"C [macro <Xm/List.h>]: EIF_INTEGER"
		alias
			"XmMODIFICATION"
		end;

	XmADDITION: INTEGER
		external
			"C [macro <Xm/List.h>]: EIF_INTEGER"
		alias
			"XmADDITION"
		end;

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




end -- class MEL_LIST_CALLBACK_STRUCT


