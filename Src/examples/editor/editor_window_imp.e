indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EDITOR_WINDOW_IMP

inherit
	EV_TITLED_WINDOW
		redefine
			initialize, is_in_default_state
		end
			
	CONSTANTS
		undefine
			is_equal, default_create, copy
		end

-- This class is the implementation of an EV_TITLED_WINDOW generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize is
			-- Initialize `Current'.
		local
			internal_pixmap: EV_PIXMAP
		do
			Precursor {EV_TITLED_WINDOW}
			initialize_constants
			
				-- Create all widgets.
			create l_ev_menu_bar_1
			create l_ev_menu_2
			create open_file
			create close_file
			create l_ev_vertical_box_1
			create tool_bar
			create cut_tb
			create copy_tb
			create paste_tb
			create l_ev_tool_bar_separator_1
			create l_ev_horizontal_split_area_1
			create editor_container
			create l_ev_notebook_1
			create options_box
			create editable_check
			create general_info_frame
			create l_ev_vertical_box_2
			create l_ev_horizontal_box_1
			create l_ev_label_1
			create buff_screen_size_label
			create l_ev_horizontal_box_2
			create l_ev_label_2
			create flip_count_label
			create l_ev_horizontal_box_3
			create l_ev_label_3
			create viewport_offset_label
			create token_info_frame
			create l_ev_vertical_box_3
			create token_info_label
			create preferences_button
			create cursor_box
			create l_ev_frame_1
			create l_ev_vertical_box_4
			create l_ev_horizontal_box_4
			create l_ev_label_4
			create cursor_line_number
			create l_ev_horizontal_box_5
			create l_ev_label_5
			create cursor_text_position
			create l_ev_horizontal_box_6
			create l_ev_label_6
			create cursor_line_pos
			create l_ev_horizontal_box_7
			create l_ev_label_7
			create cursor_x_pos
			create l_ev_horizontal_box_8
			create l_ev_label_8
			create cursor_y_pos
			create l_ev_frame_2
			create l_ev_vertical_box_5
			create l_ev_horizontal_box_9
			create l_ev_label_9
			create goto_line_text
			create goto_line_button
			create l_ev_horizontal_box_10
			create l_ev_label_10
			create select_chars_first_text
			create l_ev_label_11
			create select_chars_end_text
			create select_char_button
			create l_ev_horizontal_box_11
			create l_ev_label_12
			create select_line_start_text
			create l_ev_label_13
			create select_line_end_text
			create select_line_button
			create line_box
			create l_ev_frame_3
			create l_ev_vertical_box_6
			create line_number_check
			create invisible_symbol_check
			create l_ev_horizontal_box_12
			create l_ev_label_14
			create first_line_displayed_label
			create l_ev_horizontal_box_13
			create l_ev_label_15
			create last_line_displayed_label
			create l_ev_horizontal_box_14
			create l_ev_label_16
			create line_width_label
			create line_info_frame
			create line_info_box
			create line_info_check
			create l_ev_horizontal_box_15
			create l_ev_frame_4
			create l_ev_horizontal_box_16
			create status_label
			create l_ev_cell_1
			create internal_pixmap
			
				-- Build_widget_structure.
			set_menu_bar (l_ev_menu_bar_1)
			l_ev_menu_bar_1.extend (l_ev_menu_2)
			l_ev_menu_2.extend (open_file)
			l_ev_menu_2.extend (close_file)
			extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (tool_bar)
			tool_bar.extend (cut_tb)
			tool_bar.extend (copy_tb)
			tool_bar.extend (paste_tb)
			tool_bar.extend (l_ev_tool_bar_separator_1)
			l_ev_vertical_box_1.extend (l_ev_horizontal_split_area_1)
			l_ev_horizontal_split_area_1.extend (editor_container)
			l_ev_horizontal_split_area_1.extend (l_ev_notebook_1)
			l_ev_notebook_1.extend (options_box)
			options_box.extend (editable_check)
			options_box.extend (general_info_frame)
			general_info_frame.extend (l_ev_vertical_box_2)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (l_ev_label_1)
			l_ev_horizontal_box_1.extend (buff_screen_size_label)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_2)
			l_ev_horizontal_box_2.extend (l_ev_label_2)
			l_ev_horizontal_box_2.extend (flip_count_label)
			l_ev_vertical_box_2.extend (l_ev_horizontal_box_3)
			l_ev_horizontal_box_3.extend (l_ev_label_3)
			l_ev_horizontal_box_3.extend (viewport_offset_label)
			options_box.extend (token_info_frame)
			token_info_frame.extend (l_ev_vertical_box_3)
			l_ev_vertical_box_3.extend (token_info_label)
			options_box.extend (preferences_button)
			l_ev_notebook_1.extend (cursor_box)
			cursor_box.extend (l_ev_frame_1)
			l_ev_frame_1.extend (l_ev_vertical_box_4)
			l_ev_vertical_box_4.extend (l_ev_horizontal_box_4)
			l_ev_horizontal_box_4.extend (l_ev_label_4)
			l_ev_horizontal_box_4.extend (cursor_line_number)
			l_ev_vertical_box_4.extend (l_ev_horizontal_box_5)
			l_ev_horizontal_box_5.extend (l_ev_label_5)
			l_ev_horizontal_box_5.extend (cursor_text_position)
			l_ev_vertical_box_4.extend (l_ev_horizontal_box_6)
			l_ev_horizontal_box_6.extend (l_ev_label_6)
			l_ev_horizontal_box_6.extend (cursor_line_pos)
			l_ev_vertical_box_4.extend (l_ev_horizontal_box_7)
			l_ev_horizontal_box_7.extend (l_ev_label_7)
			l_ev_horizontal_box_7.extend (cursor_x_pos)
			l_ev_vertical_box_4.extend (l_ev_horizontal_box_8)
			l_ev_horizontal_box_8.extend (l_ev_label_8)
			l_ev_horizontal_box_8.extend (cursor_y_pos)
			cursor_box.extend (l_ev_frame_2)
			l_ev_frame_2.extend (l_ev_vertical_box_5)
			l_ev_vertical_box_5.extend (l_ev_horizontal_box_9)
			l_ev_horizontal_box_9.extend (l_ev_label_9)
			l_ev_horizontal_box_9.extend (goto_line_text)
			l_ev_horizontal_box_9.extend (goto_line_button)
			l_ev_vertical_box_5.extend (l_ev_horizontal_box_10)
			l_ev_horizontal_box_10.extend (l_ev_label_10)
			l_ev_horizontal_box_10.extend (select_chars_first_text)
			l_ev_horizontal_box_10.extend (l_ev_label_11)
			l_ev_horizontal_box_10.extend (select_chars_end_text)
			l_ev_horizontal_box_10.extend (select_char_button)
			l_ev_vertical_box_5.extend (l_ev_horizontal_box_11)
			l_ev_horizontal_box_11.extend (l_ev_label_12)
			l_ev_horizontal_box_11.extend (select_line_start_text)
			l_ev_horizontal_box_11.extend (l_ev_label_13)
			l_ev_horizontal_box_11.extend (select_line_end_text)
			l_ev_horizontal_box_11.extend (select_line_button)
			l_ev_notebook_1.extend (line_box)
			line_box.extend (l_ev_frame_3)
			l_ev_frame_3.extend (l_ev_vertical_box_6)
			l_ev_vertical_box_6.extend (line_number_check)
			l_ev_vertical_box_6.extend (invisible_symbol_check)
			l_ev_vertical_box_6.extend (l_ev_horizontal_box_12)
			l_ev_horizontal_box_12.extend (l_ev_label_14)
			l_ev_horizontal_box_12.extend (first_line_displayed_label)
			l_ev_vertical_box_6.extend (l_ev_horizontal_box_13)
			l_ev_horizontal_box_13.extend (l_ev_label_15)
			l_ev_horizontal_box_13.extend (last_line_displayed_label)
			l_ev_vertical_box_6.extend (l_ev_horizontal_box_14)
			l_ev_horizontal_box_14.extend (l_ev_label_16)
			l_ev_horizontal_box_14.extend (line_width_label)
			line_box.extend (line_info_frame)
			line_info_frame.extend (line_info_box)
			line_info_box.extend (line_info_check)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_15)
			l_ev_horizontal_box_15.extend (l_ev_frame_4)
			l_ev_frame_4.extend (l_ev_horizontal_box_16)
			l_ev_horizontal_box_16.extend (status_label)
			l_ev_horizontal_box_16.extend (l_ev_cell_1)
			
			l_ev_menu_2.set_text ("File")
			open_file.set_text ("Open")
			close_file.set_text ("Close")
			l_ev_vertical_box_1.disable_item_expand (tool_bar)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_15)
			cut_tb.set_tooltip ("Cut")
			internal_pixmap.set_with_named_file ("D:\Src\tools\doc_builder\resources\icons\icon_cut_color.ico")
			cut_tb.set_pixmap (internal_pixmap)
			copy_tb.set_tooltip ("Copy")
			internal_pixmap.set_with_named_file ("D:\Src\tools\doc_builder\resources\icons\icon_copy_color.ico")
			copy_tb.set_pixmap (internal_pixmap)
			paste_tb.set_tooltip ("Paste")
			internal_pixmap.set_with_named_file ("D:\Src\tools\doc_builder\resources\icons\icon_paste.ico")
			paste_tb.set_pixmap (internal_pixmap)
			editor_container.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (0, 128, 0))
			editor_container.set_minimum_width (550)
			editor_container.set_padding_width (1)
			editor_container.set_border_width (1)
			l_ev_notebook_1.set_item_text (options_box, "General")
			l_ev_notebook_1.set_item_text (cursor_box, "Cursor")
			l_ev_notebook_1.set_item_text (line_box, "Line")
			options_box.set_minimum_width (250)
			options_box.set_padding_width (5)
			options_box.set_border_width (10)
			options_box.disable_item_expand (editable_check)
			options_box.disable_item_expand (general_info_frame)
			options_box.disable_item_expand (token_info_frame)
			options_box.disable_item_expand (preferences_button)
			editable_check.enable_select
			editable_check.set_text ("Editable")
			general_info_frame.set_text ("General")
			l_ev_vertical_box_2.set_padding_width (5)
			l_ev_vertical_box_2.set_border_width (5)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_1)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_2)
			l_ev_vertical_box_2.disable_item_expand (l_ev_horizontal_box_3)
			l_ev_horizontal_box_1.disable_item_expand (l_ev_label_1)
			l_ev_label_1.set_text ("Buffered screen size: ")
			l_ev_label_1.align_text_left
			buff_screen_size_label.set_minimum_width (30)
			l_ev_horizontal_box_2.disable_item_expand (l_ev_label_2)
			l_ev_label_2.set_text ("Flip count: ")
			l_ev_label_2.align_text_left
			flip_count_label.set_minimum_width (30)
			l_ev_horizontal_box_3.disable_item_expand (l_ev_label_3)
			l_ev_label_3.set_text ("Viewport y offset: ")
			l_ev_label_3.align_text_left
			viewport_offset_label.set_minimum_width (30)
			token_info_frame.set_text ("Token information")
			l_ev_vertical_box_3.set_padding_width (5)
			l_ev_vertical_box_3.set_border_width (5)
			token_info_label.set_text ("No current token")
			token_info_label.align_text_left
			preferences_button.set_text ("Preferences")
			cursor_box.set_padding_width (5)
			cursor_box.set_border_width (10)
			l_ev_frame_1.set_text ("General")
			l_ev_vertical_box_4.set_padding_width (5)
			l_ev_vertical_box_4.set_border_width (5)
			l_ev_vertical_box_4.disable_item_expand (l_ev_horizontal_box_4)
			l_ev_vertical_box_4.disable_item_expand (l_ev_horizontal_box_5)
			l_ev_vertical_box_4.disable_item_expand (l_ev_horizontal_box_6)
			l_ev_vertical_box_4.disable_item_expand (l_ev_horizontal_box_7)
			l_ev_vertical_box_4.disable_item_expand (l_ev_horizontal_box_8)
			l_ev_horizontal_box_4.disable_item_expand (l_ev_label_4)
			l_ev_horizontal_box_4.disable_item_expand (cursor_line_number)
			l_ev_label_4.set_text ("On line:  ")
			l_ev_label_4.align_text_left
			cursor_line_number.set_minimum_width (30)
			l_ev_horizontal_box_5.disable_item_expand (l_ev_label_5)
			l_ev_horizontal_box_5.disable_item_expand (cursor_text_position)
			l_ev_label_5.set_text ("Position in text (in characters): ")
			l_ev_label_5.align_text_left
			cursor_text_position.set_minimum_width (30)
			l_ev_horizontal_box_6.disable_item_expand (l_ev_label_6)
			l_ev_horizontal_box_6.disable_item_expand (cursor_line_pos)
			l_ev_label_6.set_text ("Position in line (in characters): ")
			l_ev_label_6.align_text_left
			cursor_line_pos.set_minimum_width (30)
			cursor_line_pos.set_minimum_height (13)
			l_ev_horizontal_box_7.disable_item_expand (l_ev_label_7)
			l_ev_horizontal_box_7.disable_item_expand (cursor_x_pos)
			l_ev_label_7.set_text ("X pos: ")
			l_ev_label_7.align_text_left
			cursor_x_pos.set_minimum_width (30)
			cursor_x_pos.align_text_left
			l_ev_horizontal_box_8.disable_item_expand (l_ev_label_8)
			l_ev_horizontal_box_8.disable_item_expand (cursor_y_pos)
			l_ev_label_8.set_text ("Y Pos: ")
			l_ev_label_8.set_minimum_width (30)
			l_ev_label_8.align_text_left
			cursor_y_pos.align_text_left
			l_ev_frame_2.set_text ("Position")
			l_ev_vertical_box_5.set_padding_width (5)
			l_ev_vertical_box_5.set_border_width (5)
			l_ev_vertical_box_5.disable_item_expand (l_ev_horizontal_box_9)
			l_ev_vertical_box_5.disable_item_expand (l_ev_horizontal_box_10)
			l_ev_vertical_box_5.disable_item_expand (l_ev_horizontal_box_11)
			l_ev_horizontal_box_9.set_padding_width (5)
			l_ev_horizontal_box_9.disable_item_expand (l_ev_label_9)
			l_ev_horizontal_box_9.disable_item_expand (goto_line_button)
			l_ev_label_9.set_text ("Go to line ")
			l_ev_label_9.align_text_left
			goto_line_text.set_leap (1)
			goto_line_button.set_text ("Go")
			l_ev_horizontal_box_10.set_padding_width (5)
			l_ev_horizontal_box_10.disable_item_expand (l_ev_label_10)
			l_ev_horizontal_box_10.disable_item_expand (l_ev_label_11)
			l_ev_horizontal_box_10.disable_item_expand (select_char_button)
			l_ev_label_10.set_text ("Select chars ")
			l_ev_label_11.set_text (" to ")
			select_char_button.set_text ("Go")
			l_ev_horizontal_box_11.set_padding_width (5)
			l_ev_horizontal_box_11.disable_item_expand (l_ev_label_12)
			l_ev_horizontal_box_11.disable_item_expand (l_ev_label_13)
			l_ev_horizontal_box_11.disable_item_expand (select_line_button)
			l_ev_label_12.set_text ("Select lines   ")
			l_ev_label_13.set_text (" to ")
			select_line_button.set_text ("Go")
			line_box.set_padding_width (5)
			line_box.set_border_width (10)
			l_ev_frame_3.set_text ("General")
			l_ev_vertical_box_6.set_padding_width (5)
			l_ev_vertical_box_6.set_border_width (5)
			l_ev_vertical_box_6.disable_item_expand (line_number_check)
			l_ev_vertical_box_6.disable_item_expand (invisible_symbol_check)
			l_ev_vertical_box_6.disable_item_expand (l_ev_horizontal_box_12)
			l_ev_vertical_box_6.disable_item_expand (l_ev_horizontal_box_13)
			l_ev_vertical_box_6.disable_item_expand (l_ev_horizontal_box_14)
			line_number_check.set_text ("Show line numbers")
			invisible_symbol_check.set_text ("Show invisible symbols")
			l_ev_horizontal_box_12.disable_item_expand (l_ev_label_14)
			l_ev_horizontal_box_12.disable_item_expand (first_line_displayed_label)
			l_ev_label_14.set_text ("First line displayed: ")
			l_ev_label_14.align_text_left
			first_line_displayed_label.set_minimum_width (30)
			first_line_displayed_label.align_text_left
			l_ev_horizontal_box_13.disable_item_expand (l_ev_label_15)
			l_ev_horizontal_box_13.disable_item_expand (last_line_displayed_label)
			l_ev_label_15.set_text ("Last line displayed: ")
			l_ev_label_15.align_text_left
			last_line_displayed_label.set_minimum_width (30)
			last_line_displayed_label.align_text_left
			l_ev_horizontal_box_14.disable_item_expand (l_ev_label_16)
			l_ev_horizontal_box_14.disable_item_expand (line_width_label)
			l_ev_label_16.set_text ("Width: ")
			l_ev_label_16.align_text_left
			line_width_label.set_minimum_width (30)
			line_info_frame.set_text ("Structure")
			line_info_box.set_padding_width (5)
			line_info_box.set_border_width (5)
			line_info_box.disable_item_expand (line_info_check)
			line_info_check.set_text ("Show line structure information")
			l_ev_horizontal_box_15.set_border_width (2)
			l_ev_horizontal_box_16.disable_item_expand (status_label)
			set_minimum_width (800)
			set_minimum_height (600)
			set_title ("Display window")
			
				--Connect events.
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	goto_line_text, select_chars_first_text, select_chars_end_text, select_line_start_text,
	select_line_end_text: EV_SPIN_BUTTON
	open_file, close_file: EV_MENU_ITEM
	cut_tb, copy_tb, paste_tb: EV_TOOL_BAR_BUTTON
	editable_check,
	line_number_check, invisible_symbol_check, line_info_check: EV_CHECK_BUTTON
	editor_container, options_box,
	cursor_box, line_box, line_info_box: EV_VERTICAL_BOX
	buff_screen_size_label, flip_count_label, viewport_offset_label,
	token_info_label, cursor_line_number, cursor_text_position, cursor_line_pos, cursor_x_pos,
	cursor_y_pos, first_line_displayed_label, last_line_displayed_label, line_width_label,
	status_label: EV_LABEL
	preferences_button, goto_line_button, select_char_button, select_line_button: EV_BUTTON
	general_info_frame,
	token_info_frame, line_info_frame: EV_FRAME
	tool_bar: EV_TOOL_BAR

feature {NONE} -- Implementation

	l_ev_notebook_1: EV_NOTEBOOK
	l_ev_cell_1: EV_CELL
	l_ev_horizontal_split_area_1: EV_HORIZONTAL_SPLIT_AREA
	l_ev_menu_2: EV_MENU
	l_ev_menu_bar_1: EV_MENU_BAR
	l_ev_vertical_box_1,
	l_ev_vertical_box_2, l_ev_vertical_box_3, l_ev_vertical_box_4, l_ev_vertical_box_5,
	l_ev_vertical_box_6: EV_VERTICAL_BOX
	l_ev_horizontal_box_1, l_ev_horizontal_box_2, l_ev_horizontal_box_3,
	l_ev_horizontal_box_4, l_ev_horizontal_box_5, l_ev_horizontal_box_6, l_ev_horizontal_box_7,
	l_ev_horizontal_box_8, l_ev_horizontal_box_9, l_ev_horizontal_box_10, l_ev_horizontal_box_11,
	l_ev_horizontal_box_12, l_ev_horizontal_box_13, l_ev_horizontal_box_14, l_ev_horizontal_box_15,
	l_ev_horizontal_box_16: EV_HORIZONTAL_BOX
	l_ev_label_1, l_ev_label_2, l_ev_label_3, l_ev_label_4, l_ev_label_5,
	l_ev_label_6, l_ev_label_7, l_ev_label_8, l_ev_label_9, l_ev_label_10, l_ev_label_11,
	l_ev_label_12, l_ev_label_13, l_ev_label_14, l_ev_label_15, l_ev_label_16: EV_LABEL
	l_ev_frame_1,
	l_ev_frame_2, l_ev_frame_3, l_ev_frame_4: EV_FRAME
	l_ev_tool_bar_separator_1: EV_TOOL_BAR_SEPARATOR

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


end -- class EDITOR_WINDOW_IMP
