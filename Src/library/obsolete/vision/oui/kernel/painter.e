note

	description: "Set of routines for drawing"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	PAINTER 

inherit

	G_ANY
		export
			{NONE} all
		end;

	W_MAN_GEN
		export
			{NONE} all
		end

feature -- Status report

	is_drawable: BOOLEAN
			-- Can we draw on the window ?
		require
			drawing_set: valid_drawing;
		do
			Result := drawing_i.is_drawable
		end;

	valid_drawing: BOOLEAN
		do
			Result := drawing_i /= Void;
		end;

feature -- Element change

	set_font (a_font: FONT)
			-- Set the font used to draw texts.
		require
			drawing_set: valid_drawing;
			a_font_exists: a_font /= Void
		do
			drawing_i.set_drawing_font (a_font)
		end;

	set_drawing (a_drawing: DRAWING)
			-- Set the drawing one which all routines are directed.
		do
			if (a_drawing = Void) then
				drawing_i := Void
			else
				drawing_i := a_drawing.implementation
			end
		ensure
			drawing_set: (a_drawing /= Void) implies (drawing_i = a_drawing.implementation)
		end;

	set_logical_mode (a_mode: INTEGER)
			-- Set drawing logical function to `a_mode'.
		require
			mode_large_enough: a_mode >= 0;
			mode_small_enough: a_mode <= 15;
			drawing_set: valid_drawing;
		do
			drawing_i.set_logical_mode (a_mode)
		end;

feature -- Basic operations

	draw_text (x, y: INTEGER; a_text: STRING)
			-- Draw `a_text' at `x', `y'.
		require
			a_text_exists: a_text /= Void
		do
			drawing_i.draw_text (coord_xy (x, y), a_text)
		end;

	fill_polygon (points: LIST [COORD_XY])
			-- Fill a polygon.
		require
			points_exists: points /= Void;
			list_with_two_points_at_least: points.count >= 3
		do
			drawing_i.fill_polygon (points)
		end;

feature {NONE} -- Implementation

	coord_xy (x, y: INTEGER): COORD_XY
			-- Set of coordinates
		do
			create Result;
			Result.set (x, y)
		ensure
			x_set: Result.x = x;
			y_set: Result.y = y
		end;

	set_foreground (color: COLOR)
			-- Set the color to use for the foreground.
		require
			drawing_set: valid_drawing;
			color_exists: color /= Void
		do
			drawing_i.set_foreground_gc_color (color)
		end;

	draw_point (x, y: INTEGER)
			-- Draw a point at (`x', `y').
		require
			drawing_set: valid_drawing;
		do
			drawing_i.draw_point (coord_xy (x, y))
		end;

	draw_rectangle (x, y, width, height: INTEGER; orientation: REAL)
			-- Draw a rectangle whose center is at (`x', `y'),
			-- whose size is (`width', `height').
		require
			drawing_set: valid_drawing;
			width_positive: width >= 0;
			height_positive: height >= 0;
			orientation_positive: orientation >= 0;
			orientation_less_than_360: orientation < 360
		do
			drawing_i.draw_rectangle (coord_xy (x, y), width, height, orientation)
		end;

	fill_rectangle (x, y, width, height: INTEGER; orientation: REAL)
			-- Fill a rectangle whose center is at (`x', `y'),
			-- whose size is (`width', `height').
		require
			drawing_set: valid_drawing;
			width_positive: width >= 0;
			height_positive: height >= 0;
			orientation_positive: orientation >= 0;
			orientation_less_than_360: orientation < 360
		do
			drawing_i.fill_rectangle (coord_xy (x, y), width, height, orientation)
		end;

	draw_segment (x1, y1, x2, y2: INTEGER)
			-- Draw a segment between (`x1', `y1') and (`x2', `y2').
		require
			drawing_set: valid_drawing;
		do
			drawing_i.draw_segment (coord_xy (x1, y1), coord_xy (x2, y2))
		end;

	drawing_i: DRAWING_I;
			-- Implementation of the drawing set

	set_subwindow_mode (a_mode: INTEGER)
			-- Set subwindow mode to `a_mode'.
		require
			mode_large_enough: a_mode >= 0;
			mode_small_enough: a_mode <= 1;
			drawing_set: valid_drawing;
		do
			drawing_i.set_subwindow_mode (a_mode)
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




end -- class PAINTER

