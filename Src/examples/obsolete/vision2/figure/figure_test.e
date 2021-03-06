note
	description: "This is the usage pattern of the figure cluster."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Vincent Brendel", "brendel@eiffel.com"
	date: "$Date$"
	revision: "$Revision$"

class
	FIGURE_TEST

inherit
	EV_FONT_CONSTANTS

	EV_DRAWABLE_CONSTANTS

create
	make_and_launch

feature -- Initialization

	make_and_launch
		do
			create application
			prepare
			application.launch
		end

	application: EV_APPLICATION

	prepare
			-- Initialize world.
		local
			pos: EV_RELATIVE_POINT
			pixmap: EV_PIXMAP
			f: RAW_FILE
		do
			-- First, create the world.
			-- Like every figure-group, has origin (0, 0) by default.
			create my_world

			-- While you are debugging the world set points to visible.
			-- Slow but clarifying.
			--my_world.set_points_visible (True)

			-- This world has one position that is moved by the mouse cursor and
			-- of which the scaling and rotation change as well, every time it moves.
			-- The point starts on (50, 50)
			create controlled_position.make_with_origin_and_position (my_world.point, 50, 50)

			-- We want to create a line that moves with one point relative to the
			-- controlled position and the other one moves over a path, defined by a positioning agent.
			create line
			line.point_a.set_origin (controlled_position)
			line.point_b.set_origin (my_world.point)
			my_world.extend (line) -- The line is now a part of the world.

			-- Some other properties of line are now set:
			line.set_line_width (7)
			line.set_foreground_color (create {EV_COLOR}.make_with_rgb (0, 1, 0))

			-- Now we create an ellipse with one fixed point (100,5) and the other one exactly
			-- on the controlled position. We do not use the controlled position as
			-- this point. This is to make it easier to change something later on.
			create ellipse
			create pos.make_with_origin_and_position (my_world.point, 100, 5)
			ellipse.set_point_a (pos)
			create pos.make_with_origin_and_position (controlled_position, 0, 0)
			ellipse.set_point_b (pos)
			ellipse.set_foreground_color (create {EV_COLOR}.make_with_rgb (1, 0, 0))
			my_world.extend (ellipse)

			-- We want a rectangle as well. This rectangle, unlike the ellipse, gets point_a
			-- relative to the controlled position. This means that the rectangle is
			-- resized and rotated by the values in controlled_position which are propagated
			-- through depending points.
			create rectangle
			create pos.make_with_origin_and_position (controlled_position, 20, 30)
			rectangle.set_point_a (pos)
			create pos.make_with_origin_and_position (rectangle.point_a, 10, 50)
			rectangle.set_point_b (pos)
			my_world.extend (rectangle)

			create picture
			create pixmap
			pixmap.set_with_named_file ("logo.png")
			picture.set_pixmap (pixmap)
			picture.point.set_origin (my_world.point)
			picture.point.set_position (200, 200)
			my_world.extend (picture)

			create text
			text.set_text ("EV_FIGURE_TEXT")
			text.font.set_height (40)
			text.font.set_family ({EV_FONT_CONSTANTS}.family_roman)
			text.point.set_origin (my_world.point)
			text.point.set_position (20, 250)
			my_world.extend (text)

			-- This is where it all comes together:
			create drawing_area
			first_window.extend (drawing_area)
			drawing_area.set_minimum_size (300, 300)

			drawing_area.draw_pixmap (0, 0, pixmap)

			drawing_area.expose_actions.extend (agent on_repaint)
			drawing_area.pointer_motion_actions.extend (agent on_mouse_move)
			drawing_area.pointer_button_press_actions.extend (agent on_click)

			-- Bind the world and the device and you're all set.
			create projector.make (my_world, drawing_area)

			first_window.close_request_actions.extend (agent first_window.destroy_and_exit_if_last)
			first_window.show
		end

	first_window: EV_TITLED_WINDOW
			-- The window with the drawable area.
		once
			create Result
			Result.set_title ("Figure world test")
			Result.set_size (300, 300)
		end

	on_click (x, y, z: INTEGER; s,w,e:DOUBLE; sx,sy:INTEGER)
		do
		end

	on_repaint (x, y, w, h: INTEGER)
			-- Do the projection
		do
			projector.project
		end

	on_mouse_move (x, y: INTEGER; s,w,e:DOUBLE; sx,sy:INTEGER)
			-- Mouse moved on world. Do something funny.
		do
			controlled_position.set_x (x)
			controlled_position.set_y (y)
		--	controlled_position.set_angle (controlled_position.angle + 0.1)
		--	controlled_position.set_scale (controlled_position.scale_x * 1.02)
		--	if controlled_position.scale_x > 3 then
		--		controlled_position.set_scale (0.5)
		--	end
			projector.project
		end

	display_text (str: STRING)
			-- Write `str' to standard output. Used for event testing.
		do
			io.put_string (str)
		end

	line_x_pos: INTEGER

	line_positioner (pos: EV_RELATIVE_POINT)
			-- Position one point of the line.
		do
			pos.set_x_abs (line_x_pos + 10)
			pos.set_y_abs (10)
			line_x_pos := line_x_pos + 1
			if line_x_pos > 100 then
				line_x_pos := 0
			end
		end

feature -- Access

	my_world: EV_FIGURE_WORLD
	drawing_area: EV_DRAWING_AREA

	dot: EV_FIGURE_DOT
	ellipse: EV_FIGURE_ELLIPSE
	rectangle: EV_FIGURE_RECTANGLE
	line: EV_FIGURE_LINE

	arc: EV_FIGURE_ARC
	text: EV_FIGURE_TEXT
	polyline: EV_FIGURE_POLYLINE
	polygon: EV_FIGURE_POLYGON
	eql: EV_FIGURE_EQUILATERAL
	triangle: EV_FIGURE_RECTANGLE
	picture: EV_FIGURE_PICTURE

	controlled_position: EV_RELATIVE_POINT
			-- By moving this position, we move the rectangle
			-- and resize the ellipse.

	projector: EV_DRAWING_AREA_PROJECTOR;
			-- The "link" between the world and the drawing area.

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


end -- class FIGURE_TEST

