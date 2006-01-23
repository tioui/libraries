indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NEW_ITEM_DIALOG_IMP

inherit
	EV_DIALOG
		redefine
			initialize, is_in_default_state
		end
			
	CONSTANTS
		undefine
			is_equal, default_create, copy
		end

-- This class is the implementation of an EV_DIALOG generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_DIALOG}
			initialize_constants
			
				-- Create all widgets.
			create l_ev_vertical_box_1
			create grid_label_radio_button
			create label_item_box
			create l_ev_label_1
			create text_entry
			create select_font_button
			create custom_item_radio_button
			create custom_item_box
			create l_ev_cell_1
			create l_ev_vertical_box_2
			create ellipse_radio_button
			create l_ev_horizontal_box_1
			create pixmap_radio_button
			create select_pixmap_button
			create editable_item_radio_button
			create l_ev_frame_1
			create l_ev_horizontal_box_2
			create l_ev_label_2
			create label_x
			create l_ev_label_3
			create label_y
			create l_ev_frame_2
			create l_ev_horizontal_box_3
			create multiple_items_check_button
			create x_count
			create y_count
			create l_ev_horizontal_box_4
			create l_ev_cell_2
			create add_button
			create close_button
			
				-- Build_widget_structure.
			extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (grid_label_radio_button)
			l_ev_vertical_box_1.extend (label_item_box)
			label_item_box.extend (l_ev_label_1)
			label_item_box.extend (text_entry)
			label_item_box.extend (select_font_button)
			l_ev_vertical_box_1.extend (custom_item_radio_button)
			l_ev_vertical_box_1.extend (custom_item_box)
			custom_item_box.extend (l_ev_cell_1)
			custom_item_box.extend (l_ev_vertical_box_2)
			l_ev_vertical_box_2.extend (ellipse_radio_button)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (pixmap_radio_button)
			l_ev_horizontal_box_1.extend (select_pixmap_button)
			l_ev_vertical_box_1.extend (editable_item_radio_button)
			l_ev_vertical_box_1.extend (l_ev_frame_1)
			l_ev_frame_1.extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (l_ev_label_2)
			l_ev_horizontal_box_2.extend (label_x)
			l_ev_horizontal_box_2.extend (l_ev_label_3)
			l_ev_horizontal_box_2.extend (label_y)
			l_ev_vertical_box_1.extend (l_ev_frame_2)
			l_ev_frame_2.extend (l_ev_horizontal_box_3)
			l_ev_horizontal_box_3.extend (multiple_items_check_button)
			l_ev_horizontal_box_3.extend (x_count)
			l_ev_horizontal_box_3.extend (y_count)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_4)
			l_ev_horizontal_box_4.extend (l_ev_cell_2)
			l_ev_horizontal_box_4.extend (add_button)
			l_ev_horizontal_box_4.extend (close_button)
			
			l_ev_vertical_box_1.set_padding_width (box_padding)
			l_ev_vertical_box_1.set_border_width (box_padding)
			l_ev_vertical_box_1.disable_item_expand (l_ev_frame_1)
			l_ev_vertical_box_1.disable_item_expand (l_ev_frame_2)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_4)
			grid_label_radio_button.set_text ("EV_GRID_LABEL_ITEM")
			label_item_box.set_padding_width (box_padding)
			label_item_box.set_border_width (box_padding)
			label_item_box.disable_item_expand (l_ev_label_1)
			label_item_box.disable_item_expand (select_font_button)
			l_ev_label_1.set_text ("Text:")
			text_entry.set_text ("sd")
			select_font_button.set_text ("Select Font")
			custom_item_radio_button.set_text ("EV_GRID_CUSTOM_ITEM")
			custom_item_box.disable_sensitive
			custom_item_box.disable_item_expand (l_ev_cell_1)
			l_ev_cell_1.set_minimum_width (16)
			l_ev_cell_1.set_minimum_height (10)
			l_ev_vertical_box_2.merge_radio_button_groups (l_ev_horizontal_box_1)
			ellipse_radio_button.set_text ("Ellipse")
			l_ev_horizontal_box_1.disable_item_expand (select_pixmap_button)
			l_ev_horizontal_box_1.merge_radio_button_groups (l_ev_vertical_box_2)
			pixmap_radio_button.set_text ("Pixmap")
			select_pixmap_button.disable_sensitive
			select_pixmap_button.set_text ("Select")
			select_pixmap_button.set_minimum_width (button_width)
			editable_item_radio_button.set_text ("EV_GRID_EDITABLE_ITEM")
			l_ev_frame_1.set_text ("Label Position")
			l_ev_horizontal_box_2.set_padding_width (box_padding)
			l_ev_horizontal_box_2.set_border_width (box_padding)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_label_2)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_label_3)
			l_ev_label_2.set_text ("X :")
			label_x.set_text ("1")
			label_x.value_range.adapt (create {INTEGER_INTERVAL}.make (1, 1000000))
			label_x.set_value (1)
			l_ev_label_3.set_text ("Y :")
			label_y.set_text ("1")
			label_y.value_range.adapt (create {INTEGER_INTERVAL}.make (1, 1000000))
			label_y.set_value (1)
			l_ev_frame_2.set_text ("Multiple label properties")
			l_ev_horizontal_box_3.set_padding_width (box_padding)
			l_ev_horizontal_box_3.set_border_width (box_padding)
			l_ev_horizontal_box_3.disable_item_expand (multiple_items_check_button)
			x_count.disable_sensitive
			x_count.set_text ("10")
			x_count.value_range.adapt (create {INTEGER_INTERVAL}.make (0, 200))
			x_count.set_value (10)
			y_count.disable_sensitive
			y_count.set_text ("10")
			y_count.value_range.adapt (create {INTEGER_INTERVAL}.make (0, 1000000))
			y_count.set_value (10)
			l_ev_horizontal_box_4.set_padding_width (box_padding)
			l_ev_horizontal_box_4.set_border_width (box_padding)
			l_ev_horizontal_box_4.disable_item_expand (add_button)
			l_ev_horizontal_box_4.disable_item_expand (close_button)
			add_button.set_text ("Add")
			add_button.set_minimum_width (button_width)
			close_button.set_text ("Close")
			close_button.set_minimum_width (button_width)
			set_title ("New Item Entry")
			
				--Connect events.
			grid_label_radio_button.select_actions.extend (agent grid_label_radio_button_selected)
			select_font_button.select_actions.extend (agent select_font_button_selected)
			custom_item_radio_button.select_actions.extend (agent custom_item_radio_button_selected)
			ellipse_radio_button.select_actions.extend (agent ellipse_radio_button_selected)
			pixmap_radio_button.select_actions.extend (agent pixmap_radio_button_selected)
			select_pixmap_button.select_actions.extend (agent select_pixmap_button_selected)
			editable_item_radio_button.select_actions.extend (agent editable_item_radio_button_selected)
			multiple_items_check_button.select_actions.extend (agent multiple_items_check_button_selected)
			add_button.select_actions.extend (agent add_button_selected)
			close_button.select_actions.extend (agent close_button_selected)
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	label_x, label_y, x_count, y_count: EV_SPIN_BUTTON
	select_font_button, select_pixmap_button, add_button,
	close_button: EV_BUTTON
	grid_label_radio_button, custom_item_radio_button, ellipse_radio_button,
	pixmap_radio_button, editable_item_radio_button: EV_RADIO_BUTTON
	label_item_box, custom_item_box: EV_HORIZONTAL_BOX
	multiple_items_check_button: EV_CHECK_BUTTON
	text_entry: EV_TEXT_FIELD

feature {NONE} -- Implementation

	l_ev_cell_1, l_ev_cell_2: EV_CELL
	l_ev_horizontal_box_1, l_ev_horizontal_box_2, l_ev_horizontal_box_3,
	l_ev_horizontal_box_4: EV_HORIZONTAL_BOX
	l_ev_vertical_box_1, l_ev_vertical_box_2: EV_VERTICAL_BOX
	l_ev_label_1, l_ev_label_2,
	l_ev_label_3: EV_LABEL
	l_ev_frame_1, l_ev_frame_2: EV_FRAME

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end
	
	user_initialization is
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end
	
	grid_label_radio_button_selected is
			-- Called by `select_actions' of `grid_label_radio_button'.
		deferred
		end
	
	select_font_button_selected is
			-- Called by `select_actions' of `select_font_button'.
		deferred
		end
	
	custom_item_radio_button_selected is
			-- Called by `select_actions' of `custom_item_radio_button'.
		deferred
		end
	
	ellipse_radio_button_selected is
			-- Called by `select_actions' of `ellipse_radio_button'.
		deferred
		end
	
	pixmap_radio_button_selected is
			-- Called by `select_actions' of `pixmap_radio_button'.
		deferred
		end
	
	select_pixmap_button_selected is
			-- Called by `select_actions' of `select_pixmap_button'.
		deferred
		end
	
	editable_item_radio_button_selected is
			-- Called by `select_actions' of `editable_item_radio_button'.
		deferred
		end
	
	multiple_items_check_button_selected is
			-- Called by `select_actions' of `multiple_items_check_button'.
		deferred
		end
	
	add_button_selected is
			-- Called by `select_actions' of `add_button'.
		deferred
		end
	
	close_button_selected is
			-- Called by `select_actions' of `close_button'.
		deferred
		end
	

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class NEW_ITEM_DIALOG_IMP
