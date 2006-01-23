indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GRID_ITEM_FINDER

inherit
	GRID_ITEM_FINDER_IMP
	
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
			l_pixmap: EV_PIXMAP
		do
			l_pixmap := (create {EV_STOCK_PIXMAPS}).help_cursor
			cursor_pixmap.set_size (32, 32)
			cursor_pixmap.draw_pixmap (0, 0, l_pixmap)
			cursor_pixmap.pointer_motion_actions.extend (agent motion_event)
			create motion_actions
			create end_motion_actions
		end
	
feature -- Access

	motion_actions: ACTION_SEQUENCE [TUPLE [EV_GRID_ITEM]]
	
	end_motion_actions: ACTION_SEQUENCE [TUPLE [EV_GRID_ITEM]]
	
	set_prompt (a_prompt: STRING) is
			-- Assign `a_prompt' as user prompt for `Current'.
		do
			prompt_label.set_text (a_prompt)	
		end

feature {NONE} -- Implementation

	motion_event (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			--
		local
			translated_x, translated_y: INTEGER
		do
			translated_x := a_x + grid.virtual_x_position + (cursor_pixmap.screen_x - grid.screen_x) - grid.viewable_x_offset
			translated_y := a_y + grid.virtual_y_position + (cursor_pixmap.screen_y - grid.screen_y) - grid.viewable_y_offset
			if translated_x >= grid.virtual_x_position and translated_x <= grid.virtual_x_position + grid.viewable_width and
			translated_y >= grid.virtual_y_position and translated_y <= grid.virtual_y_position + grid.viewable_height then
	
				found_item := grid.item_at_virtual_position (translated_x, translated_y)
				if found_item /= Void then
					motion_actions.call ([found_item])
				else
					motion_actions.call ([Void])
				end
			end
		end
		
	pointer_pressed (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_button_press_actions' of `cursor_pixmap'.
		do
			cursor_pixmap.set_pointer_style ((create {EV_STOCK_PIXMAPS}).help_cursor)
			cursor_pixmap.enable_capture
			cursor_pixmap.clear
		end
	
	pointer_released (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Called by `pointer_button_release_actions' of `cursor_pixmap'.
		do
			cursor_pixmap.set_pointer_style ((create {EV_STOCK_PIXMAPS}).standard_cursor)
			cursor_pixmap.disable_capture
			cursor_pixmap.draw_pixmap (0, 0, (create {EV_STOCK_PIXMAPS}).help_cursor)
			end_motion_actions.call ([found_item])
		end
		
	found_item: EV_GRID_ITEM;

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


end -- class GRID_ITEM_FINDER

