note

	description: 
		"Motif Toggle Button Gadget."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_TOGGLE_BUTTON_GADGET

inherit

	MEL_TOGGLE_BUTTON_GADGET_RESOURCES
		export
			{NONE} all
		end;

	MEL_LABEL_GADGET
		redefine
			make, create_callback_struct
		end

create 
	make,
	make_from_existing

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN)
			-- Create a motif toggle button gadget.
		local
			widget_name: ANY
		do
			parent := a_parent;	
			widget_name := a_name.to_c;
			screen_object := xm_create_toggle_button_gadget (a_parent.screen_object, $widget_name, default_pointer, 0);
			Mel_widgets.add (Current);
			set_default;
			if do_manage then
				manage
			end
		end;

feature -- Access

	value_changed_command: MEL_COMMAND_EXEC
			-- Command set for the value changed callback
		do
			Result := motif_command (XmNvalueChangedCallback)
		end;

	arm_command: MEL_COMMAND_EXEC
			-- Command set for the arm callback
		do
			Result := motif_command (XmNarmCallback)
		end;

	disarm_command: MEL_COMMAND_EXEC
			-- Command set for the disarm callback
		do
			Result := motif_command (XmNdisarmCallback)
		end

feature -- Status report

	state: BOOLEAN
			-- State of current toggle button
		require
			exists: not is_destroyed
		do
			Result := xm_toggle_button_get_state (screen_object);
		end;

	is_filled_on_select: BOOLEAN
			-- Is the indicator filled with `fill_color'?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNfillOnSelect)
		end;

	is_indicator_visible: BOOLEAN
			-- Is the indicator visible?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNindicatorOn)
		end;

	indicator_size: INTEGER
			-- Size of the indicator
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNindicatorSize)
		ensure
			indicator_size_large_enough: Result >= 0
		end;

	is_indicator_square: BOOLEAN
			-- Is the indicator type a square?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNindicatorType) = XmN_OF_MANY
		end;

	select_color: MEL_PIXEL
			-- Color when toggle is selected
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixel (Current, XmNselectColor)
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.is_shared
		end;

	select_insensitive_pixmap: MEL_PIXMAP
			-- Insensitive pixmap when toggle is selected
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixmap (Current, XmNselectInsensitivePixmap)
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.is_shared
		end;

	select_pixmap: MEL_PIXMAP
			-- Pixmap when toggle is selected
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixmap (Current, XmNselectPixmap)
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.is_shared
		end;

	spacing: INTEGER
			-- Distance between the toggle indicator and its label
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNspacing)
		ensure
			spacing_large_enough: Result >= 0
		end;

	is_indicator_visible_when_off: BOOLEAN
			-- Is the toggle indicator visible when off?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNvisibleWhenOff)
		end;

feature -- Status setting

	set_toggle_on
			-- Set Current toggle on.
		require
			exists: not is_destroyed
		do
			xm_toggle_button_set_state (screen_object, True, False)
		ensure
			state_is_true: state
		end;

	set_toggle_off
			-- Set Current toggle off.
		require
			exists: not is_destroyed
		do
			xm_toggle_button_set_state (screen_object, False, False)
		ensure
			state_is_false: not state
		end;

	arm
			-- Set `state' to `True' and call callback (if set).
		require
			exists: not is_destroyed
		do
			xm_toggle_button_set_state (screen_object, True, True)
		ensure
			state_is_true: state
		end;

	disarm
			-- Set `state' to `False' and call callback (if set).
		require
			exists: not is_destroyed
		do
			xm_toggle_button_set_state (screen_object, False, True)
		ensure
			state_is_false: not state
		end;

	fill_on_select
			-- Fill the indicator with `select_color' when toggle is selected.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNfillOnSelect, True)
		ensure
			filled_on_select_is_true: is_filled_on_select
		end;

	do_not_fill_on_select
			-- Do not fill the indicator with `select_color'.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNfillOnSelect, False)
		ensure
			filled_on_select_is_false: not is_filled_on_select
		end;

	set_indicator_visible
			-- Set the indicator visible.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNindicatorOn, True)
		ensure
			indicator_visible_is_true: is_indicator_visible
		end;

	set_indicator_invisible
			-- Set the indicator invisible.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object,XmNindicatorOn, False)
		ensure
			indicator_visible_is_false: not is_indicator_visible
		end;

	set_indicator_size (a_width: INTEGER)
			-- Set `indicator_size' to `a_width'.
		require
			exists: not is_destroyed;
			a_width_large_enough: a_width >= 0
		do
			set_xt_dimension (screen_object, XmNindicatorSize, a_width)
		ensure
			value_set: indicator_size = a_width
		end;

	set_indicator_square
			-- Set the indicator type to square.
		require
			exists: not is_destroyed;
		do
			set_xt_unsigned_char (screen_object, XmNindicatorType, XmN_OF_MANY)
		ensure
			indicator_square_is_true: is_indicator_square
		end;
 
  	set_indicator_diamond
			-- Set the indicator type to diamond.
		require
			exists: not is_destroyed;
		do
			set_xt_unsigned_char (screen_object, XmNindicatorType, XmONE_OF_MANY)
		ensure
			indicator_square_is_false: not is_indicator_square
		end;

	set_select_color (a_color: MEL_PIXEL)
			-- Set `select_color' to `a_color'.
		require
			exists: not is_destroyed;
			valid_color: a_color /= Void and then a_color.is_valid;
			same_display: a_color.same_display (display)
		do
			set_xt_pixel (screen_object, XmNselectColor, a_color)
		ensure
			select_color_set: select_color.is_equal (a_color)
		end;

	set_select_insensitive_pixmap (a_pixmap: MEL_PIXMAP)
			-- Set `select_insensitive_pixmap' to `a_pixmap'.
		require
			exists: not is_destroyed;
			valid_pixmap: a_pixmap /= Void and then a_pixmap.is_valid;
			same_depth: parent.depth = a_pixmap.depth;
			same_display: a_pixmap.same_display (display)
		do
			set_xt_pixmap (screen_object, XmNselectInsensitivePixmap, a_pixmap)
		ensure
			select_insensitive_pixmap_set: select_insensitive_pixmap.is_equal (a_pixmap)
		end;	

	set_select_pixmap (a_pixmap: MEL_PIXMAP)
			-- Set `select_pixmap' to `a_pixmap'.
		require
			exists: not is_destroyed;
			valid_pixmap: a_pixmap /= Void and then a_pixmap.is_valid;
			same_depth: parent.depth = a_pixmap.depth;
			same_display: a_pixmap.same_display (display)
		do
			set_xt_pixmap (screen_object, XmNselectPixmap, a_pixmap)
		ensure
			select_pixmap_set: select_pixmap.is_equal (a_pixmap)
		end;

	set_spacing (a_width: INTEGER)
			-- Set `spacing' to `a_width'.
		require
			exists: not is_destroyed;
			a_width_large_enough: a_width >= 0
		do
			set_xt_dimension (screen_object, XmNspacing, a_width)
		ensure
			value_set: spacing = a_width
		end;

	set_indicator_visible_when_off
			-- Set the indicator visible when off.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNvisibleWhenOff, True)
		ensure
			indicator_is_visible_when_off: is_indicator_visible_when_off
		end;

	set_indicator_invisible_when_off
			-- Set the indicator invisible when off.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNvisibleWhenOff, False)
		ensure
			indicator_is_not_visible_when_off: not is_indicator_visible_when_off
		end;

feature -- Element change

	set_value_changed_callback (a_command: MEL_COMMAND; an_argument: ANY)
			-- Set `a_command' to be executed when the value of the button
			-- has been changed.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNvalueChangedCallback, a_command, an_argument);
		ensure
			command_set: command_set (value_changed_command, a_command, an_argument)
		end;

	set_arm_callback (a_command: MEL_COMMAND; an_argument: ANY)
			-- Set `a_command' to be executed when the button is pressed.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNarmCallback, a_command, an_argument);
		ensure
			command_set: command_set (arm_command, a_command, an_argument)
		end;

	set_disarm_callback (a_command: MEL_COMMAND; an_argument: ANY)
			-- Set `a_command' to be executed when the button is released.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNdisarmCallback, a_command, an_argument);
		ensure
			command_set: command_set (disarm_command, a_command, an_argument)
		end;

feature -- Removal

	remove_value_changed_callback
			-- Remove the command for the value changed callback.
		do
			remove_callback (XmNvalueChangedCallback)
		ensure
			removed: value_changed_command = Void
		end;

	remove_arm_callback
			-- Remove the command for the arm callback.
		do
			remove_callback (XmNarmCallback)
		ensure
			removed: arm_command = Void
		end;

	remove_disarm_callback
			-- Remove the command for the arm callback.
		do
			remove_callback (XmNdisarmCallback)
		ensure
			removed: disarm_command = Void
		end;

feature {MEL_DISPATCHER} -- Basic operations

	create_callback_struct (a_callback_struct_ptr: POINTER;
					resource_name: POINTER): MEL_TOGGLE_BUTTON_CALLBACK_STRUCT
			-- Create the callback structure specific to this widget
			-- according to the `a_callback_struct_ptr' pointer.
		do
			create Result.make (Current, a_callback_struct_ptr)
		end;

feature {NONE} -- Implementation

	xm_toggle_button_set_state (scr_obj: POINTER; value1, value2: BOOLEAN)
		external
			"C (Widget, Boolean, Boolean) | <Xm/ToggleBG.h>"
		alias
			"XmToggleButtonSetState"
		end;

	xm_toggle_button_get_state (scr_obj: POINTER): BOOLEAN
		external
			"C (Widget): EIF_BOOLEAN | <Xm/ToggleB.h>"
		alias
			"XmToggleButtonGetState"
		end;

	xm_create_toggle_button_gadget (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/ToggleBG.h>"
		alias
			"XmCreateToggleButtonGadget"
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




end -- class MEL_TOGGLE_BUTTON_GADGET


