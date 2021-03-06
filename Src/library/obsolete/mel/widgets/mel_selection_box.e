note

	description:
			"Widget for selecting one of a list of alternatives."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SELECTION_BOX

inherit

	MEL_SELECTION_BOX_RESOURCES
		export
			{NONE} all
		end;

	MEL_BULLETIN_BOARD
		redefine
			create_callback_struct, cancel_button,
			default_button, create_widget
		end

create
	make,
	make_no_auto_unmanage,
	make_from_existing

feature {NONE} -- Initialization

	create_widget (p_so: POINTER; w_name: ANY; auto_manage_flag: BOOLEAN)
			-- Create motif selection box with `auto_manage_flag'.
		do
			if auto_manage_flag then
				screen_object := xm_create_selection_box (p_so, $w_name, default_pointer, 0)
			else
				screen_object := xm_create_selection_box (p_so, $w_name, auto_unmanage_arg, 1)
			end;
		end;

feature -- Access

	apply_button: MEL_PUSH_BUTTON_GADGET
			-- Apply button
		local
			w: POINTER
		do
			w := xm_selection_box_get_child (screen_object, XmDIALOG_APPLY_BUTTON);
			if w /= default_pointer then
				Result ?= Mel_widgets.item (w);
				if Result = Void then
					create Result.make_from_existing (w, Current)
				end
			end
		end;

	cancel_button: MEL_PUSH_BUTTON_GADGET
			-- Cancel button
		local
			w: POINTER
		do
			w := xm_selection_box_get_child (screen_object, XmDIALOG_CANCEL_BUTTON);
			if w /= default_pointer then
				Result ?= Mel_widgets.item (w);
				if Result = Void then
					create Result.make_from_existing (w, Current)
				end
			end
		end;

	help_button: MEL_PUSH_BUTTON_GADGET
			-- Help button
		local
			w: POINTER
		do
			w := xm_selection_box_get_child (screen_object, XmDIALOG_HELP_BUTTON);
			if w /= default_pointer then
				Result ?= Mel_widgets.item (w);
				if Result = Void then
					create Result.make_from_existing (w, Current)
				end
			end
		end;

	ok_button: MEL_PUSH_BUTTON_GADGET
			-- Ok button
		local
			w: POINTER
		do
			w := xm_selection_box_get_child (screen_object, XmDIALOG_OK_BUTTON);
			if w /= default_pointer then
				Result ?= Mel_widgets.item (w);
				if Result = Void then
					create Result.make_from_existing (w, Current)
				end
			end
		end;

	list: MEL_SCROLLED_LIST
			-- List in box
		local
			w: POINTER
		do
			w := xm_selection_box_get_child (screen_object, XmDIALOG_LIST);
			if w /= default_pointer then
				Result ?= Mel_widgets.item (w);
				if Result = Void then
					create Result.make_from_existing (w, Current)
				end
			end
		end;

	list_label: MEL_LABEL_GADGET
			-- Label of `list'
		local
			w: POINTER
		do
			w := xm_selection_box_get_child (screen_object, XmDIALOG_LIST_LABEL);
			if w /= default_pointer then
				Result ?= Mel_widgets.item (w);
				if Result = Void then
					create Result.make_from_existing (w, Current)
				end
			end
		end;

	selection_label: MEL_LABEL_GADGET
			-- Label to show selection
		local
			w: POINTER
		do
			w := xm_selection_box_get_child (screen_object, XmDIALOG_SELECTION_LABEL);
			if w /= default_pointer then
				Result ?= Mel_widgets.item (w);
				if Result = Void then
					create Result.make_from_existing (w, Current)
				end
			end
		end;

	separator: MEL_SEPARATOR_GADGET
			-- Separator used
		local
			w: POINTER
		do
			w := xm_selection_box_get_child (screen_object, XmDIALOG_SEPARATOR);
			if w /= default_pointer then
				Result ?= Mel_widgets.item (w);
				if Result = Void then
					create Result.make_from_existing (w, Current)
				end
			end
		end;

	text: MEL_TEXT_FIELD
			-- Text
		local
			w: POINTER
		do
			w := xm_selection_box_get_child (screen_object, XmDIALOG_TEXT);
			if w /= default_pointer then
				Result ?= Mel_widgets.item (w);
				if Result = Void then
					create Result.make_from_existing (w, Current)
				end
			end
		end;

	work_area: MEL_WIDGET
			-- Work area of box
		local
			w: POINTER
		do
			w := xm_selection_box_get_child (screen_object, XmDIALOG_WORK_AREA);
			if w /= default_pointer then
				Result ?= Mel_widgets.item (w);
				if Result = Void then
					create Result.make_from_existing (w, Current)
				end
			end
		end;

	default_button: MEL_PUSH_BUTTON_GADGET
			-- Default button
		local
			ptr: POINTER
		do
			ptr := xm_selection_box_get_child (screen_object, XmDIALOG_DEFAULT_BUTTON);
			if ptr /= default_pointer then
				Result ?= Mel_widgets.item (ptr)
				if Result = Void then
					create Result.make_from_existing (ptr, Current)
				end
			end;
		end;

	apply_command: MEL_COMMAND_EXEC
			-- Command set for the apply callback
		do
			Result := motif_command (XmNapplyCallback)
		end;

	cancel_command: MEL_COMMAND_EXEC
			-- Command set for the cancel callback
		do
			Result := motif_command (XmNcancelCallback)
		end;

	ok_command: MEL_COMMAND_EXEC
			-- Command set for the ok callback
		do
			Result := motif_command (XmNokCallback)
		end;

	no_match_command: MEL_COMMAND_EXEC
			-- Command set for the no match callback
		do
			Result := motif_command (XmNnoMatchCallback)
		end;

feature -- Status report

	apply_label_string: MEL_STRING
			-- Label of `apply_button'
		require
			exists: not is_destroyed
		do
			Result := get_xm_string (screen_object, XmNapplyLabelString)
		ensure
			apply_label_string_exists: Result /= Void and then not Result.is_destroyed
		end;

	cancel_label_string: MEL_STRING
			-- Label of `cancel_button'
		require
			exists: not is_destroyed
		do
			Result := get_xm_string (screen_object, XmNcancelLabelString)
		ensure
			cancel_label_string_exists: Result /= Void and then not Result.is_destroyed
		end;

	help_label_string: MEL_STRING
			-- Label of `help_button'
		require
			exists: not is_destroyed
		do
			Result := get_xm_string (screen_object, XmNhelpLabelString)
		ensure
			help_label_string_exists: Result /= Void and then not Result.is_destroyed
		end;

	ok_label_string: MEL_STRING
			-- Label of `ok_button'
		require
			exists: not is_destroyed
		do
			Result := get_xm_string (screen_object, XmNokLabelString)
		ensure
			ok_label_string_exists: Result /= Void and then not Result.is_destroyed
		end;

	is_work_area_above_selection: BOOLEAN
			-- Is `work_area' displayed above `text'?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNchildPlacement) = XmPLACE_ABOVE_SELECTION
		end;

	 is_work_area_below_selection: BOOLEAN
			-- Is `work_area' displayed below `text'?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNchildPlacement) = XmPLACE_BELOW_SELECTION
		end;

	is_work_area_on_top: BOOLEAN
			-- Is `work_area' displayed above `list'?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNchildPlacement) = XmPLACE_TOP
		end;

	is_prompt_dialog: BOOLEAN
			-- Is the dialog type "prompt dialog"?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNdialogType) = XmDIALOG_PROMPT
		end;

	is_selection_dialog: BOOLEAN
			-- Is the dialog type "selection dialog"?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNdialogType) = XmDIALOG_SELECTION
		end;

	is_command_dialog: BOOLEAN
			-- Is the dialog type "command dialog"?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNdialogType) = XmDIALOG_COMMAND
		end;

	is_file_selection_dialog: BOOLEAN
			-- Is the dialog type "file selection dialog"?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNdialogType) = XmDIALOG_FILE_SELECTION
		end;

	list_item_count: INTEGER
			-- Number of items in `list_items'
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNlistItemCount)
		ensure
			list_item_count_large_enough: Result >= 0
		end;

	list_items: MEL_STRING_TABLE
			-- Items in `list'
		require
			exists: not is_destroyed
		do
			create Result.make_from_existing 
				(get_xm_string_table (screen_object, XmNlistItems), 
				list_item_count);
			Result.set_shared
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_is_shared: Result.is_shared
		end;

	list_label_string: MEL_STRING
			-- Label of `list'
		require
			exists: not is_destroyed
		do
			Result := get_xm_string (screen_object, XmNlistLabelString)
		ensure
			Result_not_void: Result /= Void and then Result.is_destroyed
		end;

	list_visible_item_count: INTEGER
			-- Number of visible items in `list'
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNlistVisibleItemCount)
		ensure
			Result_large_enough: Result >= 0
		end;

	buttons_minimized: BOOLEAN
			-- Keep the buttons their preferred size?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNminimizeButtons)
		end;

	must_match: BOOLEAN
			-- Must the typed selection match an item in `list'?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNmustMatch)
		end;

	text_accelerators
			-- The translations to add to `text'.
		require
			exists: not is_destroyed
		do
		ensure
		end;

	text_columns: INTEGER
			-- Number of columns in `text'
		require
			exists: not is_destroyed
		do
			Result := get_xt_short (screen_object, XmNtextColumns)
		ensure
			text_columns_large_enough: Result >= 0
		end;

	text_string: MEL_STRING
			-- String in `text'
		require
			exists: not is_destroyed
		do
			Result := get_xm_string (screen_object, XmNtextString)
		ensure
			text_string_not_void: Result /= Void
		end;

feature -- Status setting

	set_apply_label_string (a_compound_string: MEL_STRING)
			-- Set `apply_label_string' to `a_compound_string'.
		require
			exists: not is_destroyed;
			valid_a_compound_string: a_compound_string /= Void and then not a_compound_string.is_destroyed
		do
			set_xm_string (screen_object, XmNApplyLabelString, a_compound_string)
		ensure
			apply_label_string_set: apply_label_string.is_equal (a_compound_string)
		end;

	set_cancel_label_string (a_compound_string: MEL_STRING)
			-- Set `cancel_label_string' to `a_compound_string'.
		require
			exists: not is_destroyed;
			valid_a_compound_string: a_compound_string /= Void and then not a_compound_string.is_destroyed
		do
			set_xm_string (screen_object, XmNcancelLabelString, a_compound_string)
		ensure
			cancel_label_string_set: cancel_label_string.is_equal (a_compound_string)
		end;

	set_help_label_string (a_compound_string: MEL_STRING)
			-- Set `help_label_string' to `a_compound_string'.
		require
			exists: not is_destroyed;
			valid_a_compound_string: a_compound_string /= Void and then not a_compound_string.is_destroyed
		do
			set_xm_string (screen_object, XmNhelpLabelString, a_compound_string)
		ensure
			help_label_string_set: help_label_string.is_equal (a_compound_string)
		end;

	set_ok_label_string (a_compound_string: MEL_STRING)
			-- Set `ok_label_string' to `a_compound_string'.
		require
			exists: not is_destroyed;
			valid_a_compound_string: a_compound_string /= Void and then not a_compound_string.is_destroyed
		do
			set_xm_string (screen_object, XmNokLabelString, a_compound_string)
		ensure
			ok_label_string_set: ok_label_string.is_equal (a_compound_string)
		end;

	place_work_area_above_selection
			-- Set `is_work_area_above_selection'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNchildPlacement, XmPLACE_ABOVE_SELECTION)
		ensure
			work_area_is_placed_above_selection: is_work_area_above_selection
		end;

	 place_work_area_below_selection
			-- Set `is_work_area_below_selection'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNchildPlacement, XmPLACE_BELOW_SELECTION)
		ensure
			work_area_is_placed_below_selection: is_work_area_below_selection
		end;

	place_work_area_on_top
			-- Set `is_work_area_on_top'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNchildPlacement, XmPLACE_TOP)
		ensure
			work_area_is_placed_on_top: is_work_area_on_top
		end;

	set_prompt_dialog
			-- Set `is_prompt_dialog'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNdialogType, XmDIALOG_PROMPT)
		ensure
			dialog_prompt_set: is_prompt_dialog
		end;

	set_selection_dialog
			-- Set `is_selection_dialog'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNdialogType, XmDIALOG_SELECTION)
		ensure
			dialog_selection_set: is_selection_dialog
		end;

	set_command_dialog
			-- Set `is_command_dialog'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNdialogType, XmDIALOG_COMMAND)
		ensure
			dialog_command_set: is_command_dialog
		end;

	set_file_selection_dialog
			-- Set `is_file_selection_dialog'
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNdialogType, XmDIALOG_FILE_SELECTION)
		ensure
			dialog_file_selection_set: is_file_selection_dialog
		end;

	set_list_item_count (a_count: INTEGER)
			-- Set `list_item_count' to `a_count'.
		require
			exists: not is_destroyed;
			a_count_large_enough: a_count >= 0
		do
			set_xt_int (screen_object, XmNlistItemCount, a_count)
		ensure
			list_item_count_set: list_item_count = a_count
		end;

	set_list_items (a_list: MEL_STRING_TABLE)
			-- Set `list_items' to `a_list'.
		require
			exists: not is_destroyed;
			valid_list: a_list /= Void and then a_list.is_destroyed
		do
			set_xm_string_table (screen_object, XmNlistItems, a_list.handle)
		end;

	set_list_label_string (a_compound_string: MEL_STRING)
			-- Set `list_label_string' to `a_compound_string'.
		require
			exists: not is_destroyed;
			a_compound_string_exists: not a_compound_string.is_destroyed
		do
			set_xm_string (screen_object, XmNlistLabelString, a_compound_string)
		ensure
			list_label_string_set: list_label_string.is_equal (a_compound_string)
		end;

	set_list_visible_item_count (a_count: INTEGER)
			-- Set `list_visible_item_count' to `a_count'.
		require
			exists: not is_destroyed;
			a_count_large_enough: a_count >= 0
		do
			set_xt_int (screen_object, XmNlistVisibleItemCount, a_count)
		ensure
			list_visible_item_count_set: list_visible_item_count = a_count
		end;

	minimize_button
			-- Set `buttons_minimized' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNminimizeButtons, True)
		ensure
			buttons_minimized: buttons_minimized
		end;

	maximize_button
			-- Set `buttons_minimized' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNminimizeButtons, False)
		ensure
			buttons_maximized: not buttons_minimized
		end;

	enable_must_match
			-- Set `must_match' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNmustMatch, True)
		ensure
			must_match_enabled: must_match 
		end;

	disable_must_match
			-- Set `must_match' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNmustMatch, False)
		ensure
			must_match_disabled: not must_match 
		end;

	set_text_columns (a_number: INTEGER)
			-- Set `text_columns' to `a_number'.
		require
			exists: not is_destroyed;
			a_number_large_enough: a_number >= 0
		do
			set_xt_short (screen_object, XmNtextColumns, a_number)
		ensure
			text_columns_set: text_columns = a_number
		end;

	set_text_string (a_compound_string: MEL_STRING)
			-- Set `text_string' to `a_compound_string'.
		require
			exists: not is_destroyed;
			valid_a_compound_string_exists: a_compound_string /= Void and then not a_compound_string.is_destroyed
		do
			set_xm_string (screen_object, XmNtextString, a_compound_string)
		ensure
			text_string_set: text_string.is_equal (a_compound_string)
		end;

feature -- Element change

	set_apply_callback (a_command: MEL_COMMAND; an_argument: ANY)
			-- Set `a_command' to be executed when the user selects
			-- the `apply_button'.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNapplyCallback, a_command, an_argument)
		ensure
			command_set: command_set (apply_command, a_command, an_argument)
		end;

	set_cancel_callback (a_command: MEL_COMMAND; an_argument: ANY)
			-- Set `a_command' to be executed when the user selects
			-- the `cancel_button'.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNcancelCallback, a_command, an_argument)
		ensure
			command_set: command_set (cancel_command, a_command, an_argument)
		end;

	set_ok_callback (a_command: MEL_COMMAND; an_argument: ANY)
			-- Set `a_command' to be executed when the user selects
			-- the `ok_button'.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNokCallback, a_command, an_argument)
		ensure
			command_set: command_set (ok_command, a_command, an_argument)
		end;

	set_no_match_callback (a_command: MEL_COMMAND; an_argument: ANY)
			-- Set `a_command' to be executed when the user types a selection
			-- in the text area that does not match an item in the list.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNnoMatchCallback, a_command, an_argument)
		ensure
			command_set: command_set (no_match_command, a_command, an_argument)
		end;

feature -- Removal

	remove_apply_callback
			-- Remove the command for the apply callback.
		do
			remove_callback (XmNapplyCallback)
		ensure
			removed: apply_command = Void
		end;

	remove_cancel_callback
			-- Remove the command for the cancel callback.
		do
			remove_callback (XmNcancelCallback)
		ensure
			removed: cancel_command = Void
		end;

	remove_ok_callback
			-- Remove the command for the ok callback.
		do
			remove_callback (XmNokCallback)
		ensure
			removed: ok_command = Void
		end;

	remove_no_match_callback
			-- Remove the command for the no match callback.
		do
			remove_callback (XmNnoMatchCallback)
		ensure
			removed: no_match_command = Void
		end;

feature {MEL_DISPATCHER} -- Basic operations

	create_callback_struct (a_callback_struct_ptr, 
				resource_name: POINTER): MEL_ANY_CALLBACK_STRUCT
			-- Create the callback structure specific to this widget
			-- according to `a_callback_struct_ptr'.
		do
			if resource_name = XmNokCallback or else
				resource_name = XmNcancelCallback or else
				resource_name = XmNnoMatchCallback or else
				resource_name = XmNapplyCallback
			then
				create {MEL_SELECTION_BOX_CALLBACK_STRUCT} Result.make (Current, a_callback_struct_ptr)
			else
				create Result.make (Current, a_callback_struct_ptr)
			end
		end;

feature {NONE} -- External Features

	xm_create_selection_box (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/SelectioB.h>"
		alias
			"XmCreateSelectionBox"
		end;

	xm_selection_box_get_child (scr_obj: POINTER; value: INTEGER): POINTER
		external
			"C (Widget, unsigned char): EIF_POINTER | <Xm/SelectioB.h>"
		alias
			"XmSelectionBoxGetChild"
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




end -- class MEL_SELECTION_BOX


