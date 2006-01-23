indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_ITEM_DIALOG

inherit
	NEW_ITEM_DIALOG_IMP
	
	GRID_ACCESSOR
		undefine
			default_create, copy, is_equal
		end
		
	PROFILING_SETTING
		undefine
			default_create, copy, is_equal
		end

feature {NONE} -- Initialization

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
		end

feature {NONE} -- Implementation
	
	select_font_button_selected is
			-- Called by `select_actions' of `select_font_button'.
		local
			font_dialog: EV_FONT_DIALOG
		do
			create font_dialog
			font_dialog.show_modal_to_window (Current)
			selected_font := font_dialog.font
		end
		
	selected_font: EV_FONT


	add_button_selected is
			-- Called by `select_actions' of `add_button'.
		local
			editable_grid_item: EV_GRID_EDITABLE_ITEM
			grid_label_item: EV_GRID_LABEL_ITEM
			l_xcount, l_ycount: INTEGER
			text: STRING
			grid_custom_item: EV_GRID_DRAWABLE_ITEM
			upper_y, upper_x: INTEGER
			grid_item: EV_GRID_ITEM
			time1, time2: DATE_TIME
			labelx_value, labely_value: INTEGER
		do
			if profile then
				start_profiling
			end
			create time1.make_now
			
			text := text_entry.text
			
				-- Determine how many items to add in each direction.
			if y_count.is_sensitive then
				upper_y := y_count.value
			else
				upper_y := 1
			end
			if x_count.is_sensitive then
				upper_x := x_count.value
			else
				upper_x := 1
			end
			labelx_value := label_x.value
			labely_value := label_y.value
			
				from
					l_ycount := 0
				until
					l_ycount = upper_y
				loop
					from
						l_xcount := 0
					until
						l_xcount = upper_x
					loop
						if grid_label_radio_button.is_selected then
							create grid_label_item
							grid_label_item.set_text (text.twin + " " + (l_xcount + 1).out + ", " + (l_ycount + 1).out)
							grid_item := grid_label_item
						elseif editable_item_radio_button.is_selected then
							create editable_grid_item
							editable_grid_item.set_text (text.twin + " " + (l_xcount + 1).out + ", " + (l_ycount + 1).out)
							grid_item := editable_grid_item
						else
							
							create grid_custom_item
							if ellipse_radio_button.is_selected then
								grid_custom_item.expose_actions.extend (agent draw_ellipse (?, grid_custom_item))
							else
								grid_custom_item.expose_actions.extend (agent draw_pixmap (?, grid_custom_item))
							end
							grid_item := grid_custom_item
						end
						grid.set_item (labelx_value + l_xcount, labely_value + l_ycount, grid_item)
						l_xcount := l_xcount + 1
					end
					l_ycount := l_ycount + 1
					if l_ycount \\ 1000 = 0 then
						set_status_message (l_ycount.out)
						((create {EV_ENVIRONMENT}).application).process_events
					end
				end
			from
				l_xcount := 0
			until
				l_xcount = upper_x
			loop
				grid.column (l_xcount + 1).set_title ("Column " + (l_xcount + 1).out)
				l_xcount := l_xcount + 1
			end
			if profile then
				stop_profiling
			end
			create time2.make_now
			set_status_message (((l_xcount * l_ycount).out + " Items added in : " + ((time2.relative_duration (time1).fine_seconds_count).out)))
			grid.pointer_double_press_actions.wipe_out
			grid.pointer_double_press_item_actions.extend (agent activate_item)
		end

	activate_item (a_x, a_y, a_button: INTEGER; a_item: EV_GRID_ITEM) is
			-- 
		do
			if a_item /= Void then
				a_item.activate
			end	
		end
		
		
	item_counter: INTEGER
		
	draw_ellipse (drawable: EV_DRAWABLE; an_item: EV_GRID_DRAWABLE_ITEM) is
			--
		do
			drawable.set_foreground_color (grid.background_color)
			drawable.fill_rectangle (0, 0, an_item.width, an_item.height)
			if an_item.is_selected then
				if grid.has_focus then
					drawable.set_foreground_color (grid.focused_selection_color)
				else
					drawable.set_foreground_color (grid.non_focused_selection_color)
				end
				drawable.fill_ellipse (0, 0, an_item.width, an_item.height)
			end
			drawable.draw_ellipse (0, 0, an_item.width, an_item.height)
			drawable.set_foreground_color (grid.foreground_color)
			drawable.draw_ellipse (0, 0, an_item.width, an_item.height)
		end

	draw_pixmap (drawable: EV_DRAWABLE; an_item: EV_GRID_DRAWABLE_ITEM) is
			--
		local
			back_color: EV_COLOR
			a_pixmap: EV_PIXMAP
		do
			if back_color = Void then
				back_color := grid.background_color
			end
			drawable.set_foreground_color (back_color)
			drawable.fill_rectangle (0, 0, an_item.width, an_item.height)
			a_pixmap := pixmap
			drawable.draw_pixmap ((an_item.width - a_pixmap.width) // 2, 0, a_pixmap)
		end
		
	multiple_items_check_button_selected is
			-- Called by `select_actions' of `multiple_items_check_button'.
		do
			if multiple_items_check_button.is_selected then
				x_count.enable_sensitive
				y_count.enable_sensitive
			else
				x_count.disable_sensitive
				y_count.disable_sensitive
			end
		end
		
	grid_label_radio_button_selected is
			-- Called by `select_actions' of `grid_label_radio_button'.
		do
			label_item_box.enable_sensitive
			custom_item_box.disable_sensitive
		end
		
	custom_item_radio_button_selected is
			-- Called by `select_actions' of `custom_item_radio_button'.
		do
			label_item_box.disable_sensitive
			custom_item_box.enable_sensitive
		end
		
	editable_item_radio_button_selected is
			-- Called by `select_actions' of `editable_item_radio_button'.
		do
			label_item_box.disable_sensitive
			custom_item_box.disable_sensitive
		end
		
	select_pixmap_button_selected is
			-- Called by `select_actions' of `select_pixmap_button'.
		local
			file_open_dialog: EV_FILE_OPEN_DIALOG
		do
			create file_open_dialog
			file_open_dialog.show_modal_to_window (Current)
			create pixmap
			pixmap.set_with_named_file (file_open_dialog.file_name)
		end
		
	ellipse_radio_button_selected is
			-- Called by `select_actions' of `ellipse_radio_button'.
		do
			select_pixmap_button.disable_sensitive
		end
		
	pixmap_radio_button_selected is
			-- Called by `select_actions' of `pixmap_radio_button'.
		do
			select_pixmap_button.enable_sensitive
		end
		
	pixmap: EV_PIXMAP
		--

	close_button_selected is
			-- Called by `select_actions' of `cancel_button'.
		do
			destroy
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


end -- class NEW_ITEM_DIALOG

