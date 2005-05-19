indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

class
	POSITION_TAB

inherit
	POSITION_TAB_IMP
	
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
		do
			grid.virtual_position_changed_actions.extend (agent virtual_position_changed)
			grid.virtual_size_changed_actions.extend (agent virtual_size_changed)
		end

feature -- Access

	set_is_selected (a_state: BOOLEAN) is
			-- Assign `a_state' to `is_selected'.
		do
			is_selected := a_state
		end

feature {NONE} -- Implementation

	is_selected: BOOLEAN

	virtual_position_changed (a_x, a_y: INTEGER) is
			-- Virtual position of `grid' has changed.
		do
			if is_selected then
				drawable.redraw
				virtual_x_position.change_actions.block
				virtual_x_position.set_value (a_x)
				virtual_x_position.change_actions.resume
				virtual_y_position.change_actions.block
				virtual_y_position.set_value (a_y)
				virtual_y_position.change_actions.resume
				display_first_visible_row
				display_first_visible_column
				display_last_visible_column
				display_last_visible_row
			end
		end

	display_first_visible_row is
			--
		local
			l_row: EV_GRID_ROW
		do
			l_row := grid.first_visible_row
			if l_row /= Void then
				first_visible_row_label.set_text ("First Visible Row : " + l_row.index.out)
			else
				first_visible_row_label.set_text ("First Visible Row Void")
			end
		end

	display_last_visible_row is
			--
		local
			l_row: EV_GRID_ROW
		do
			l_row := grid.last_visible_row
			if l_row /= Void then
				last_visible_row_label.set_text ("Last Visible Row : " + l_row.index.out)
			else
				last_visible_row_label.set_text ("Last Visible Row Void")
			end
		end

	display_first_visible_column is
			--
		local
			l_column: EV_GRID_column
		do
			l_column := grid.first_visible_column
			if l_column /= Void then
				first_visible_column_label.set_text ("First Visible Column : " + l_column.index.out)
			else
				first_visible_column_label.set_text ("First Visible Column Void")
			end
		end

	display_last_visible_column is
			--
		local
			l_column: EV_GRID_column
		do
			l_column := grid.last_visible_column
			if l_column /= Void then
				last_visible_column_label.set_text ("Last Visible Column : " + l_column.index.out)
			else
				last_visible_column_label.set_text ("Last Visible Column Void")
			end
		end
		
	display_viewable_width is
			--
		do
			viewable_width.set_text ("Viewable Width : " + grid.viewable_width.out)
		end

	display_viewable_height is
			--
		do
			viewable_height.set_text ("Viewable Height : " + grid.viewable_height.out)
		end

	display_viewable_x_offset is
			--
		do
			viewable_x_offset.set_text ("Viewable X Offset : " + grid.viewable_x_offset.out)
		end

	display_viewable_y_offset is
			--
		do
			viewable_y_offset.set_text ("Viewable Y Offset : " + grid.viewable_y_offset.out)
		end

	virtual_size_changed (a_width, a_height: INTEGER) is
			-- Virtual size of `grid' has changed.
		do
			if is_selected then
				drawable.redraw
				display_first_visible_row
				display_first_visible_column
				display_last_visible_column
				display_last_visible_row
			end
		end
		
	virtual_x_position_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `virtual_x_position'.
		do
			if is_selected then
				grid.virtual_position_changed_actions.block
				grid.set_virtual_position (a_value, grid.virtual_y_position)
				grid.virtual_position_changed_actions.resume
				display_first_visible_column
				display_last_visible_column
				drawable.redraw
			end
		end



	virtual_y_position_changed (a_value: INTEGER) is
			-- Called by `change_actions' of `virtual_y_position'.
		do
			if is_selected then
				grid.virtual_position_changed_actions.block
				grid.set_virtual_position (grid.virtual_x_position, a_value)
				grid.virtual_position_changed_actions.resume
				display_first_visible_row
				display_last_visible_row
				drawable.redraw
			end
		end
		
	drawable_exposed (a_x, a_y, a_width, a_height: INTEGER) is
			-- Called by `expose_actions' of `drawable'.
		local
			virtual_width, virtual_height: INTEGER
		do
			drawable.clear
			virtual_width := grid.virtual_width
			virtual_height := grid.virtual_height
			virtual_x_position.value_range.adapt (create {INTEGER_INTERVAL}.make (0, virtual_width - grid.viewable_width))
			virtual_y_position.value_range.adapt (create {INTEGER_INTERVAL}.make (0, virtual_height - grid.viewable_height))
			drawable.set_foreground_color (stock_colors.black)
			if virtual_width / drawable.width > virtual_height / drawable.height then
				scale := virtual_width / drawable.width
				left := 0
				top := (drawable.height - (virtual_height / scale).truncated_to_integer) // 2
				right := drawable.width
				bottom := (virtual_height / scale).truncated_to_integer
				
			else
				scale := virtual_height / drawable.height
				left := (drawable.width - (virtual_width / scale).truncated_to_integer) // 2
				top := 0
				right := (virtual_width / scale).truncated_to_integer
				bottom := drawable.height
			end
			drawable.draw_rectangle (left, top, right, bottom)
			drawable.set_foreground_color (stock_colors.red)
			drawable.draw_rectangle (left + ((grid.virtual_x_position) / scale).truncated_to_integer, (top + (grid.virtual_y_position) / scale).truncated_to_integer, (grid.viewable_width / scale).truncated_to_integer, (grid.viewable_height / scale).truncated_to_integer)
		end
		
	scale: REAL
		-- Last computed scaling factor.
	
	left, right, top, bottom: INTEGER
		
	pointed_moved_on_drawable (a_x, a_y: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_motion_actions' of `drawable'.
		local
			v_x, v_y: INTEGER
			x_pos, y_pos: INTEGER
		do
			x_pos := a_x
			y_pos := a_y
			if moving then
				v_x := ((x_pos - left) * scale).truncated_to_integer.max (0).min (grid.virtual_width - grid.viewable_width)
				v_y := ((y_pos - top) * scale).truncated_to_integer.max (0).min (grid.virtual_height - grid.viewable_height)
				grid.set_virtual_position (v_x, v_y)
				virtual_x_position.set_value (v_x)
				virtual_y_position.set_value (v_y)
				drawable.redraw
			end
		end
	
	drawable_resized (a_x, a_y, a_width, a_height: INTEGER) is
			-- Called by `resize_actions' of `drawable'.
		do
			if drawable.is_displayed then
				drawable.redraw
				display_first_visible_row
				display_first_visible_column
				display_last_visible_column
				display_last_visible_row
				display_viewable_height
				display_viewable_width
				display_viewable_x_offset
				display_viewable_Y_offset
			end
		end
		
	button_pressed_on_drawable (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_button_press_actions' of `drawable'.
		do
			if a_button = 1 then
				press_x := a_x
				press_y := a_y
				moving := True
			end
		end
	
	button_released_on_drawable (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_button_release_actions' of `drawable'.
		do
			if a_button = 1 then
				moving := False
			end
		end
		
	moving: BOOLEAN
		
	last_x, last_y: INTEGER
	
	press_x, press_y: INTEGER

end -- class POSITION_TAB

