note

	description: "Drawing routines for split windows"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class

	SPLIT_ROUTINES

inherit

	WEL_PS_CONSTANTS
		export
			{NONE} all
		end

	WEL_COLOR_CONSTANTS
		export
			{NONE} all
		end

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

	WEL_ROP2_CONSTANTS
		export
			{NONE} all
		end

feature -- Basic routines

	draw_vertical_split (a_dc: WEL_DC; a_x, a_y1, a_y2: INTEGER)
			-- draw a vertical split at 'a_x' from `a_y1' to `a_y2'
			-- on `a_dc'
		require
			a_dc_not_void: a_dc /= Void
			a_dc_exists: a_dc.exists
		do
			a_dc.select_pen (face_pen)
			a_dc.line (a_x, a_y1, a_x, a_y2)
			a_dc.select_pen (highlight_pen)
			a_dc.line (a_x + 1, a_y1, a_x + 1, a_y2)
			a_dc.select_pen (face_pen)
			a_dc.line (a_x + 2, a_y1, a_x + 2, a_y2)
			a_dc.line (a_x + 3, a_y1, a_x + 3, a_y2)
			a_dc.select_pen (shadow_pen)
			a_dc.line (a_x + 4, a_y1, a_x + 4, a_y2)
			a_dc.select_pen (window_frame_pen)
			a_dc.line (a_x + 5, a_y1, a_x + 5, a_y2)
		end

	draw_horizontal_split (a_dc: WEL_DC; a_y, a_x1, a_x2: INTEGER)
			-- Draw an horizontal split at 'a_y' from `a_x1' to `a_x2'
			-- on `a_dc'
		require
			a_dc_not_void: a_dc /= Void
			a_dc_exists: a_dc.exists
		do
			a_dc.select_pen (face_pen)
			a_dc.line (a_x1, a_y, a_x2, a_y)
			a_dc.select_pen (highlight_pen)
			a_dc.line (a_x1, a_y + 1, a_x2, a_y + 1)
			a_dc.select_pen (face_pen)
			a_dc.line (a_x1, a_y + 2, a_x2, a_y + 2)
			a_dc.line (a_x1, a_y + 3, a_x2, a_y + 3)
			a_dc.select_pen (shadow_pen)
			a_dc.line (a_x1, a_y + 4, a_x2, a_y + 4)
			a_dc.select_pen (window_frame_pen)
			a_dc.line (a_x1, a_y + 5, a_x2, a_y + 5)
		end

	invert_rectangle (a_dc: WEL_DC; a_left, a_top, a_right, a_bottom: INTEGER)
			-- Invert the rectangular zone defined by
			-- `a_left', `a_top', `a_right', `a_bottom'
			-- on `a_dc'.
		require
			a_dc_not_void: a_dc /= Void
			a_dc_exists: a_dc.exists
		local
			old_rop2: INTEGER
		do
			old_rop2 := a_dc.rop2
			a_dc.set_rop2 (R2_not)
			a_dc.rectangle (a_left, a_top, a_right, a_bottom)
			a_dc.set_rop2 (old_rop2)
		end

feature {NONE} -- Implementation

	window_frame_pen: WEL_PEN
			-- Pen with the window frame color
		local
			color: WEL_COLOR_REF
		do
			create color.make_system (Color_windowframe)
			create Result.make (ps_solid, 1, color)
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	face_pen: WEL_PEN
			-- Pen with the face color
		local
			color: WEL_COLOR_REF
		do
			create color.make_system (Color_btnface)
			create Result.make (ps_solid, 1, color)
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end
	
	shadow_pen: WEL_PEN
			-- Pen with the shadow color
		local
			color: WEL_COLOR_REF
		do
			create color.make_system (Color_btnshadow)
			create Result.make (ps_solid, 1, color)
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	highlight_pen: WEL_PEN
			-- Pen with the highlight color
		local
			color: WEL_COLOR_REF
		do
			create color.make_system (Color_btnhighlight)
			create Result.make (ps_solid, 1, color)
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
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




end -- class SPLIT_PENS

