indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ITEM_TAB

inherit
	ITEM_TAB_IMP

	GRID_ACCESSOR
		undefine
			copy, default_create, is_equal
		end

feature {NONE} -- Initialization

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		local
			list_item: EV_LIST_ITEM
			font_families: LINEAR [STRING]
		do
			item_finder.set_prompt ("Item Finder : ")
			item_finder.motion_actions.extend (agent finding_item)
			
			add_default_pixmaps_to_combo (pixmap_holder)
			add_default_colors_to_combo (foreground_color_combo)
			add_default_colors_to_combo (background_color_combo)

				-- Now Build default Fonts
			font_families ?= (create {EV_ENVIRONMENT}).font_families
			create list_item.make_with_text ("")
			font_combo.extend (list_item)
			from
				font_families.start
			until
				font_families.after
			loop
				create list_item.make_with_text (font_families.item)
				font_combo.extend (list_item)
				font_families.forth
			end
--			font_combo.disable_edit
--			font_size_combo.disable_edit
		end

feature {NONE} -- Implementation

	found_item: EV_GRID_ITEM
	
	finding_item (an_item: EV_GRID_ITEM) is
			--
		local
			row_index, column_index: INTEGER
		do
			if an_item /= Void then
				item_frame.enable_sensitive
				item_operations_frame.enable_sensitive
				found_item := an_item
				row_index := found_item.row.index
				column_index := found_item.column.index
				item_x_index.change_actions.block
				item_x_index.set_value (column_index)
				item_x_index.change_actions.resume
				item_y_index.change_actions.block
				item_y_index.set_value (row_index)
				item_y_index.change_actions.resume
				update_item_data (column_index, row_index)
			else
				found_item := Void
				if item_frame.is_sensitive then
					item_frame.disable_sensitive
					item_operations_frame.disable_sensitive
				end
			end
		end
	
	item_x_index_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `item_x_index'.
		do
			found_item := grid.item (a_value, item_y_index.value)
			update_item_data (a_value, item_y_index.value)
		end
	
	item_y_index_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `item_y_index'.
		do
			found_item := grid.item (item_x_index.value, a_value)
			update_item_data (item_x_index.value, a_value)
		end
		
	update_item_data (an_x, ay: INTEGER) is
			-- Display data for item at grid position `an_x', `a_y'.
		local
			label_item: EV_GRID_LABEL_ITEM
			deselectable: EV_DESELECTABLE
			l_color: EV_COLOR
			font_name: STRING
			font_height: INTEGER
			set: BOOLEAN
		do
			if found_item /= Void then
				main_box.enable_sensitive
				label_item ?= found_item
				if label_item /= Void then
					textable_container.enable_sensitive
					textable_entry.change_actions.block
					textable_entry.set_text (label_item.text)
					textable_entry.change_actions.resume
					left_border_container.enable_sensitive
					left_border_spin_button.change_actions.block
					left_border_spin_button.set_value (label_item.left_border)
					left_border_spin_button.change_actions.resume
					right_border_container.enable_sensitive
					right_border_spin_button.change_actions.block
					right_border_spin_button.set_value (label_item.right_border)
					right_border_spin_button.change_actions.resume
					top_border_container.enable_sensitive
					top_border_spin_button.change_actions.block
					top_border_spin_button.set_value (label_item.top_border)
					top_border_spin_button.change_actions.resume
					bottom_border_container.enable_sensitive
					bottom_border_spin_button.change_actions.block
					bottom_border_spin_button.set_value (label_item.bottom_border)
					bottom_border_spin_button.change_actions.resume
					spacing_container.enable_sensitive
					spacing_spin_button.change_actions.block
					spacing_spin_button.set_value (label_item.spacing)
					spacing_spin_button.change_actions.resume
					select_pixmap_from_combo (pixmap_holder, label_item.pixmap)
					alignment_container.enable_sensitive
					if label_item.is_left_aligned then
						alignment_combo.i_th (1).select_actions.block
						alignment_combo.i_th (1).enable_select
						alignment_combo.i_th (1).select_actions.resume
					elseif label_item.is_center_aligned then
						alignment_combo.i_th (2).select_actions.block
						alignment_combo.i_th (2).enable_select
						alignment_combo.i_th (2).select_actions.resume
					elseif label_item.is_right_aligned then
						alignment_combo.i_th (3).select_actions.block
						alignment_combo.i_th (3).enable_select
						alignment_combo.i_th (3).select_actions.resume
					end
					if label_item.is_top_aligned then
						vertical_alignment_combo.i_th (1).select_actions.block
						vertical_alignment_combo.i_th (1).enable_select
						vertical_alignment_combo.i_th (1).select_actions.resume
					elseif label_item.is_vertically_center_aligned then
						vertical_alignment_combo.i_th (2).select_actions.block
						vertical_alignment_combo.i_th (2).enable_select
						vertical_alignment_combo.i_th (2).select_actions.resume
					elseif label_item.is_bottom_aligned then
						vertical_alignment_combo.i_th (3).select_actions.block
						vertical_alignment_combo.i_th (3).enable_select
						vertical_alignment_combo.i_th (3).select_actions.resume
					end
					is_full_select_button.select_actions.block
					if label_item.is_full_select_enabled then
						is_full_select_button.enable_select
					else
						is_full_select_button.disable_select
					end
					is_full_select_button.select_actions.resume
					background_color_combo.select_actions.block
					if label_item.background_color /= Void then
						from
							background_color_combo.start
						until
							background_color_combo.off
						loop
							l_color ?= background_color_combo.item.data		
							if l_color /= Void and then l_color.is_equal (label_item.background_color) then
								background_color_combo.item.enable_select
								background_color_combo.go_i_th (background_color_combo.count)
							end
							background_color_combo.forth
						end
					else
						background_color_combo.first.enable_select
					end
					background_color_combo.select_actions.resume
					foreground_color_combo.select_actions.block
					if label_item.foreground_color /= Void then
						from
							foreground_color_combo.start
						until
							foreground_color_combo.off
						loop
							l_color ?= foreground_color_combo.item.data		
							if l_color /= Void and then l_color.is_equal (label_item.foreground_color) then
								foreground_color_combo.item.enable_select
								foreground_color_combo.go_i_th (foreground_color_combo.count)
							end
							foreground_color_combo.forth
						end
					else
						foreground_color_combo.first.enable_select
					end
					foreground_color_combo.select_actions.resume
					font_container.enable_sensitive
					if label_item.font /= Void then
						if label_item.font.preferred_families.is_empty then
							font_name := ""
						else
							font_name := label_item.font.preferred_families.i_th (1)
						end
						font_combo.select_actions.block
						from
							font_combo.go_i_th (2)
						until
							font_combo.off or set
						loop
							if font_combo.item.text.is_equal ("font_name") then
								set := True								
								font_combo.item.enable_select
							end
							if not set then
								font_combo.forth
							end
						end
						if font_combo.after then
							font_combo.i_th (1).enable_select
						end
						font_combo.select_actions.resume
						font_height := label_item.font.height_in_points
						font_size_combo.select_actions.block
						set := False
						from
							font_size_combo.go_i_th (2)
						until
							font_size_combo.off or set
						loop
							if font_size_combo.item.text.to_integer = font_height then
								set := True								
								font_size_combo.item.enable_select
							end
							if not set then
								font_size_combo.forth
							end
						end
						if font_size_combo.after then
							font_size_combo.i_th (1).enable_select
						end
						font_size_combo.select_actions.resume
					end
				else
					textable_container.disable_sensitive
					left_border_container.disable_sensitive
					spacing_container.disable_sensitive
					alignment_container.disable_sensitive
					bottom_border_container.disable_sensitive
					top_border_container.disable_sensitive
					right_border_container.disable_sensitive
					font_container.disable_sensitive
				end
				deselectable ?= found_item
				if deselectable /= Void then
					is_selected.enable_sensitive
					is_selected.select_actions.block
					if deselectable.is_selected then
						is_selected.enable_select
					else
						is_selected.disable_select
					end
					is_selected.select_actions.resume
				else
					is_selected.disable_sensitive
				end
			else
				main_box.disable_sensitive
			end
		end
		
	textable_entry_changed is
			-- Called by `change_actions' of `textable_entry'.
		local
			textable: EV_TEXTABLE
		do
			textable ?= found_item
			if textable /= Void then
				textable.set_text (textable_entry.text)
			end
		end
		
	is_selected_selected is
			-- Called by `select_actions' of `is_selected'.
		local
			deselectable: EV_DESELECTABLE
		do
			deselectable ?= found_item
			if deselectable /= Void then
				if deselectable.is_selected then
					deselectable.disable_select
				else
					deselectable.enable_select
				end
			end
		end

	remove_item_button_selected is
			-- Called by `select_actions' of `remove_item_button'.
		do
			grid.remove_item (found_item.column.index, found_item.row.index)
			update_item_data (item_x_index.value, item_y_index.value)
		end

	left_border_spin_button_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `left_border_spin_button'.
		local
			label_item: EV_GRID_LABEL_ITEM
		do
			label_item ?= found_item
			if label_item /= Void then
				label_item.set_left_border (a_value)
			end
		end

	spacing_spin_button_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `spacing_spin_button'.
		local
			label_item: EV_GRID_LABEL_ITEM
		do
			label_item ?= found_item
			if label_item /= Void then
				label_item.set_spacing (a_value)
			end
		end

	pixmap_holder_item_selected is
			-- Called by `select_actions' of `pixmap_holder'.			
		local
			selected_item_index: INTEGER
			label_item: EV_GRID_LABEL_ITEM
			pixmap: EV_PIXMAP
		do
			label_item ?= found_item
			if label_item /= Void then
				selected_item_index := pixmap_holder.index_of (pixmap_holder.selected_item, 1)
				inspect selected_item_index
				when 1 then
					label_item.remove_pixmap
				else
					pixmap ?= pixmap_holder.selected_item.data
					label_item.set_pixmap (pixmap)
				end
			end
		end

	left_alignment_item_selected is
			-- Called by `select_actions' of `left_alignment_item'.
		local
			label_item: EV_GRID_LABEL_ITEM
		do
			label_item ?= found_item
			if label_item /= Void then
				label_item.align_text_left
			end
		end
	
	center_alignment_item_selected is
			-- Called by `select_actions' of `center_alignment_item'.
		local
			label_item: EV_GRID_LABEL_ITEM
		do
			label_item ?= found_item
			if label_item /= Void then
				label_item.align_text_center
			end
		end

	foreground_color_combo_selected is
			-- Called by `select_actions' of `foreground_color_combo'.
		local
			label_item: EV_GRID_LABEL_ITEM
			color: EV_COLOR
		do
			label_item ?= found_item
			if label_item /= Void then
				color ?= foreground_color_combo.selected_item.data
				label_item.set_foreground_color (color)
			end
		end
	
	background_color_combo_selected is
			-- Called by `select_actions' of `background_color_combo'.
		local
			label_item: EV_GRID_LABEL_ITEM
			color: EV_COLOR
		do
			label_item ?= found_item
			if label_item /= Void then
				color ?= background_color_combo.selected_item.data
				label_item.set_background_color (color)
			end
		end
	
	right_alignment_item_selected is
			-- Called by `select_actions' of `right_alignment_item'.
		local
			label_item: EV_GRID_LABEL_ITEM
		do
			label_item ?= found_item
			if label_item /= Void then
				label_item.align_text_right
			end
		end

	apply_pixmap_row_button_selected is
			-- Called by `select_actions' of `apply_pixmap_row_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			row: INTEGER
			original_pixmap: EV_PIXMAP
		do
			from
				counter := 1
				row := found_item.row.index
				original_item ?= found_item
				original_pixmap := original_item.pixmap
			until
				counter > grid.column_count
			loop
				label_item ?= grid.item (counter, row)
				if label_item /= Void then
					label_item.set_pixmap (original_pixmap)
				end
				counter := counter + 1
			end
		end
	
	apply_pixmap_column_selected is
			-- Called by `select_actions' of `apply_pixmap_column_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			column: INTEGER
			original_pixmap: EV_PIXMAP
		do
			from
				counter := 1
				column := found_item.column.index
				original_item ?= found_item
				original_pixmap := original_item.pixmap
			until
				counter > grid.row_count
			loop
				label_item ?= grid.item (column, counter)
				if label_item /= Void then
					label_item.set_pixmap (original_pixmap)
				end
				counter := counter + 1
			end
		end
	
	apply_alignment_row_button_selected is
			-- Called by `select_actions' of `apply_alignment_row_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			row: INTEGER
		do
			from
				counter := 1
				row := found_item.row.index
				original_item ?= found_item
			until
				counter > grid.column_count
			loop
				label_item ?= grid.item (counter, row)
				if label_item /= Void then
					if original_item.is_left_aligned then
						label_item.align_text_left
					elseif original_item.is_center_aligned then
						label_item.align_text_center
					else
						label_item.align_text_right
					end
				end
				counter := counter + 1
			end
		end
	
	apply_alignment_column_button_selected is
			-- Called by `select_actions' of `apply_alignment_column_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			column: INTEGER
		do
			from
				counter := 1
				column := found_item.column.index
				original_item ?= found_item
			until
				counter > grid.row_count
			loop
				label_item ?= grid.item (column, counter)
				if label_item /= Void then
					if original_item.is_left_aligned then
						label_item.align_text_left
					elseif original_item.is_center_aligned then
						label_item.align_text_center
					else
						label_item.align_text_right
					end
				end
				counter := counter + 1
			end
		end
	
	apply_left_border_row_button_selected is
			-- Called by `select_actions' of `apply_left_border_row_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			row: INTEGER
			original_left_border: INTEGER
		do
			from
				counter := 1
				row := found_item.row.index
				original_item ?= found_item
				original_left_border := original_item.left_border
			until
				counter > grid.column_count
			loop
				label_item ?= grid.item (counter, row)
				if label_item /= Void then
					label_item.set_left_border (original_left_border)
				end
				counter := counter + 1
			end
		end
	
	apply_left_border_column_button_selected is
			-- Called by `select_actions' of `apply_left_border_column_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			column: INTEGER
			original_left_border: INTEGER
		do
			from
				counter := 1
				column := found_item.column.index
				original_item ?= found_item
				original_left_border := original_item.left_border
			until
				counter > grid.row_count
			loop
				label_item ?= grid.item (column, counter)
				if label_item /= Void then
					label_item.set_left_border (original_left_border)
				end
				counter := counter + 1
			end
		end
	
	apply_spacing_row_button_selected is
			-- Called by `select_actions' of `apply_spacing_row_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			row: INTEGER
			original_spacing: INTEGER
		do
			from
				counter := 1
				row := found_item.row.index
				original_item ?= found_item
				original_spacing := original_item.spacing
			until
				counter > grid.column_count
			loop
				label_item ?= grid.item (counter, row)
				if label_item /= Void then
					label_item.set_spacing (original_spacing)
				end
				counter := counter + 1
			end
		end
	
	apply_spacing_column_button_selected is
			-- Called by `select_actions' of `apply_spacing_column_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			column: INTEGER
			original_spacing: INTEGER
		do
			from
				counter := 1
				column := found_item.column.index
				original_item ?= found_item
				original_spacing := original_item.spacing
			until
				counter > grid.row_count
			loop
				label_item ?= grid.item (column, counter)
				if label_item /= Void then
					label_item.set_spacing (original_spacing)
				end
				counter := counter + 1
			end
		end

	apply_background_row_button_selected is
			-- Called by `select_actions' of `apply_background_row_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			row: INTEGER
			original_color: EV_COLOR
		do
			from
				counter := 1
				row := found_item.row.index
				original_item ?= found_item
				original_color := original_item.background_color
			until
				counter > grid.column_count
			loop
				label_item ?= grid.item (counter, row)
				if label_item /= Void then
					label_item.set_background_color (original_color)
				end
				counter := counter + 1
			end
		end
	
	apply_background_column_button_selected is
			-- Called by `select_actions' of `apply_background_column_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			column: INTEGER
			original_color: EV_COLOR
		do
			from
				counter := 1
				column := found_item.column.index
				original_item ?= found_item
				original_color := original_item.background_color
			until
				counter > grid.row_count
			loop
				label_item ?= grid.item (column, counter)
				if label_item /= Void then
					label_item.set_background_color (original_color)
				end
				counter := counter + 1
			end
		end
	
	apply_selection_row_selected_button is
			-- Called by `select_actions' of `apply_selection_row_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			row: INTEGER
			original_selected: BOOLEAN
		do
			from
				counter := 1
				row := found_item.row.index
				original_item ?= found_item
				original_selected := original_item.is_selected
			until
				counter > grid.column_count
			loop
				label_item ?= grid.item (counter, row)
				if label_item /= Void then
					if original_selected then
						label_item.enable_select	
					else
						label_item.disable_select
					end
				end
				counter := counter + 1
			end
		end
	
	apply_selection_column_button_selected is
			-- Called by `select_actions' of `apply_selection_column_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			column: INTEGER
			original_selected: BOOLEAN
		do
			from
				counter := 1
				column := found_item.column.index
				original_item ?= found_item
				original_selected := original_item.is_selected
			until
				counter > grid.row_count
			loop
				label_item ?= grid.item (column, counter)
				if label_item /= Void then
					if original_selected then
						label_item.enable_select	
					else
						label_item.disable_select
					end
				end
				counter := counter + 1
			end
		end
	
	apply_foreground_row_button_selected is
			-- Called by `select_actions' of `apply_foreground_row_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			row: INTEGER
			original_color: EV_COLOR
		do
			from
				counter := 1
				row := found_item.row.index
				original_item ?= found_item
				original_color := original_item.foreground_color
			until
				counter > grid.column_count
			loop
				label_item ?= grid.item (counter, row)
				if label_item /= Void then
					label_item.set_foreground_color (original_color)
				end
				counter := counter + 1
			end
		end
	
	apply_foreground_column_button_selected is
			-- Called by `select_actions' of `apply_foreground_column_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			column: INTEGER
			original_color: EV_COLOR
		do
			from
				counter := 1
				column := found_item.column.index
				original_item ?= found_item
				original_color := original_item.foreground_color
			until
				counter > grid.row_count
			loop
				label_item ?= grid.item (column, counter)
				if label_item /= Void then
					label_item.set_foreground_color (original_color)
				end
				counter := counter + 1
			end
		end

	apply_bottom_border_row_button_selected is
			-- Called by `select_actions' of `apply_bottom_border_row_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			row: INTEGER
			original_bottom_border: INTEGER
		do
			from
				counter := 1
				row := found_item.row.index
				original_item ?= found_item
				original_bottom_border := original_item.bottom_border
			until
				counter > grid.column_count
			loop
				label_item ?= grid.item (counter, row)
				if label_item /= Void then
					label_item.set_bottom_border (original_bottom_border)
				end
				counter := counter + 1
			end
		end
	
	apply_bottom_border_column_button_selected is
			-- Called by `select_actions' of `apply_bottom_border_column_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			column: INTEGER
			original_bottom_border: INTEGER
		do
			from
				counter := 1
				column := found_item.column.index
				original_item ?= found_item
				original_bottom_border := original_item.bottom_border
			until
				counter > grid.row_count
			loop
				label_item ?= grid.item (column, counter)
				if label_item /= Void then
					label_item.set_bottom_border (original_bottom_border)
				end
				counter := counter + 1
			end
		end
	
	apply_right_border_row_button_selected is
			-- Called by `select_actions' of `apply_right_border_row_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			row: INTEGER
			original_right_border: INTEGER
		do
			from
				counter := 1
				row := found_item.row.index
				original_item ?= found_item
				original_right_border := original_item.right_border
			until
				counter > grid.column_count
			loop
				label_item ?= grid.item (counter, row)
				if label_item /= Void then
					label_item.set_right_border (original_right_border)
				end
				counter := counter + 1
			end
		end
	
	apply_right_border_column_button_selected is
			-- Called by `select_actions' of `apply_right_border_column_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			column: INTEGER
			original_right_border: INTEGER
		do
			from
				counter := 1
				column := found_item.column.index
				original_item ?= found_item
				original_right_border := original_item.right_border
			until
				counter > grid.row_count
			loop
				label_item ?= grid.item (column, counter)
				if label_item /= Void then
					label_item.set_right_border (original_right_border)
				end
				counter := counter + 1
			end
		end
	
	apply_top_border_row_button_selected is
			-- Called by `select_actions' of `apply_top_border_row_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			row: INTEGER
			original_top_border: INTEGER
		do
			from
				counter := 1
				row := found_item.row.index
				original_item ?= found_item
				original_top_border := original_item.top_border
			until
				counter > grid.column_count
			loop
				label_item ?= grid.item (counter, row)
				if label_item /= Void then
					label_item.set_top_border (original_top_border)
				end
				counter := counter + 1
			end
		end
	
	apply_top_border_column_button_selected is
			-- Called by `select_actions' of `apply_top_border_column_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			column: INTEGER
			original_top_border: INTEGER
		do
			from
				counter := 1
				column := found_item.column.index
				original_item ?= found_item
				original_top_border := original_item.top_border
			until
				counter > grid.row_count
			loop
				label_item ?= grid.item (column, counter)
				if label_item /= Void then
					label_item.set_top_border (original_top_border)
				end
				counter := counter + 1
			end
		end

	top_border_spin_button_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `top_border_spin_button'.
		local
			label_item: EV_GRID_LABEL_ITEM
		do
			label_item ?= found_item
			if label_item /= Void then
				label_item.set_top_border (a_value)
			end
		end
	
	bottom_border_spin_button_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `bottom_border_spin_button'.
		local
			label_item: EV_GRID_LABEL_ITEM
		do
			label_item ?= found_item
			if label_item /= Void then
				label_item.set_bottom_border (a_value)
			end
		end
	
	right_border_spin_button_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `right_border_spin_button'.
		local
			label_item: EV_GRID_LABEL_ITEM
		do
			label_item ?= found_item
			if label_item /= Void then
				label_item.set_right_border (a_value)
			end
		end

	top_alignment_item_selected is
			-- Called by `select_actions' of `top_alignment_item'.
		local
			label_item: EV_GRID_LABEL_ITEM
		do
			label_item ?= found_item
			if label_item /= Void then
				label_item.align_text_top
			end
		end
	
	vertically_center_item_selected is
			-- Called by `select_actions' of `vertically_center_item'.
		local
			label_item: EV_GRID_LABEL_ITEM
		do
			label_item ?= found_item
			if label_item /= Void then
				label_item.align_text_vertically_center
			end
		end
	
	bottom_alignment_item_selected is
			-- Called by `select_actions' of `bottom_alignment_item'.
		local
			label_item: EV_GRID_LABEL_ITEM
		do
			label_item ?= found_item
			if label_item /= Void then
				label_item.align_text_bottom
			end
		end
	
	apply_vertical_alignment_column_button_selected is
			-- Called by `select_actions' of `apply_vertical_selection_column_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			column: INTEGER
		do
			from
				counter := 1
				column := found_item.column.index
				original_item ?= found_item
			until
				counter > grid.row_count
			loop
				label_item ?= grid.item (column, counter)
				if label_item /= Void then
					if original_item.is_top_aligned then
						label_item.align_text_top
					elseif original_item.is_vertically_center_aligned then
						label_item.align_text_vertically_center
					else
						label_item.align_text_bottom
					end
				end
				counter := counter + 1
			end
		end
	
	apply_vertical_alignment_row_button_selected is
			-- Called by `select_actions' of `apply_vertical_selection_row_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			row: INTEGER
		do
			from
				counter := 1
				row := found_item.row.index
				original_item ?= found_item
			until
				counter > grid.column_count
			loop
				label_item ?= grid.item (counter, row)
				if label_item /= Void then
					if original_item.is_top_aligned then
						label_item.align_text_top
					elseif original_item.is_vertically_center_aligned then
						label_item.align_text_vertically_center
					else
						label_item.align_text_bottom
					end
				end
				counter := counter + 1
			end
		end

	font_size_combo_selected is
			-- Called by `select_actions' of `font_size_combo'.
		local
			font: EV_FONT
			label_item: EV_GRID_LABEL_ITEM
		do
			if font_combo.index_of (font_combo.selected_item, 1) > 1 and				
				font_size_combo.index_of (font_size_combo.selected_item, 1) > 1 then

				label_item ?= found_item
				if label_item /= Void then
					if label_item.font /= Void then
						font := label_item.font.twin					
					else
						create font
						font.preferred_families.extend (font_combo.selected_item.text)
					end
					font.set_height_in_points (font_size_combo.selected_item.text.to_integer)
					label_item.set_font (font)
				end
			end
		end

	font_combo_selected is
			-- Called by `select_actions' of `font_combo'.
		local
			font: EV_FONT
			label_item: EV_GRID_LABEL_ITEM
		do
			if font_combo.index_of (font_combo.selected_item, 1) > 1 and				
			font_size_combo.index_of (font_size_combo.selected_item, 1) > 1 then

				label_item ?= found_item
				if label_item /= Void then
					if label_item.font /= Void then
						font := label_item.font.twin
						font.preferred_families.wipe_out
					else
						create font
						font.set_height_in_points (font_size_combo.selected_item.text.to_integer)
					end
					font.preferred_families.extend (font_combo.selected_item.text)
	
					label_item.set_font (font)
				end
			end
		end

	apply_font_row_button_selected is
			-- Called by `select_actions' of `apply_font_row_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			row: INTEGER
		do
			from
				counter := 1
				row := found_item.row.index
				original_item ?= found_item
			until
				counter > grid.column_count
			loop
				label_item ?= grid.item (counter, row)
				if label_item /= Void then
					label_item.set_font (original_item.font)
				end
				counter := counter + 1
			end
		end

	apply_font_column_button_selected is
			-- Called by `select_actions' of `apply_font_column_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			column: INTEGER
		do
			from
				counter := 1
				column := found_item.column.index
				original_item ?= found_item
			until
				counter > grid.row_count
			loop
				label_item ?= grid.item (column, counter)
				if label_item /= Void then
					label_item.set_font (original_item.font)
				end
				counter := counter + 1
			end
		end

	is_full_select_button_selected is
			-- Called by `select_actions' of `is_full_select_button'.
		local
			label_item: EV_GRID_LABEL_ITEM
		do
			label_item ?= found_item
			if label_item /= Void then
				if is_full_select_button.is_selected then
					label_item.enable_full_select
				else
					label_item.disable_full_select
				end
			end
		end
	
	apply_full_select_column_button_selected is
			-- Called by `select_actions' of `apply_full_select_column_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			row: INTEGER
		do
			from
				counter := 1
				row := found_item.row.index
				original_item ?= found_item
			until
				counter > grid.column_count
			loop
				label_item ?= grid.item (counter, row)
				if label_item /= Void then
					if original_item.is_full_select_enabled then
						label_item.enable_full_select
					else
						label_item.disable_full_select
					end
				end
				counter := counter + 1
			end
		end
	
	apply_full_select_row_button_selected is
			-- Called by `select_actions' of `apply_full_select_row_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			column: INTEGER
		do
			from
				counter := 1
				column := found_item.column.index
				original_item ?= found_item
			until
				counter > grid.row_count
			loop
				label_item ?= grid.item (column, counter)
				if label_item /= Void then
					if original_item.is_full_select_enabled then
						label_item.enable_full_select
					else
						label_item.disable_full_select
					end
				end
				counter := counter + 1
			end
		end
	
	apply_text_row_button_selected is
			-- Called by `select_actions' of `apply_text_row_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			row: INTEGER
		do
			from
				counter := 1
				row := found_item.row.index
				original_item ?= found_item
			until
				counter > grid.column_count
			loop
				label_item ?= grid.item (counter, row)
				if label_item /= Void then
					label_item.set_text (original_item.text)
				end
				counter := counter + 1
			end
		end
	
	apply_text_column_button_selected is
			-- Called by `select_actions' of `apply_text_column_button'.
		local
			counter: INTEGER
			original_item, label_item: EV_GRID_LABEL_ITEM
			column: INTEGER
		do
			from
				counter := 1
				column := found_item.column.index
				original_item ?= found_item
			until
				counter > grid.row_count
			loop
				label_item ?= grid.item (column, counter)
				if label_item /= Void then
					label_item.set_text (original_item.text)
				end
				counter := counter + 1
			end
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


end -- class ITEM_TAB

