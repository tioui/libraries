indexing

	description: 
		"Implemenation of a Graphic Context. The graphic context is %
		%automatically freed when there are no references to the instance.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_GC

inherit

	MEL_GC_CONSTANTS;

	MEMORY
		rename
			free as gc_free
		export
			{NONE} all
		redefine
			dispose
		end;

	BASIC_ROUTINES
		export
			{NONE} all
		end

creation

	make, 
	make_from_existing

feature {NONE} -- Initialization

	make (a_drawable: MEL_DRAWABLE) is
			-- Create a graphic context for `a_drawable'.
		require
			valid_drawable: a_drawable /= Void and then a_drawable.is_valid
		do
			display_handle := a_drawable.display_handle;
			handle := x_create_gc (display_handle, 
							a_drawable.identifier,
							0, default_pointer);
		ensure
			set: equal (display, a_drawable.display)
		end;

	make_from_existing (a_gc: POINTER; a_display: MEL_DISPLAY) is
			-- Encapsulate an already created graphic context.
		require
			a_gc_not_null: a_gc /= default_pointer;
			valid_display: a_display /= Void and then a_display.is_valid
		do
			handle := a_gc;
			display_handle := a_display.handle
		ensure
			set: handle = a_gc and then equal (display, a_display)
		end;

feature -- Access

	handle: POINTER;
			-- Assocated C GC handle

	display_handle: POINTER;
			-- Display C handle on which the Pixmap is allocated

	display: MEL_DISPLAY is
			-- Mel display on which the Pixmap was allocated
		do
			!! Result.make_from_existing (display_handle)
		end;

feature -- Status report

	is_valid: BOOLEAN is
			-- Is the current GC valid?
		do
			Result := handle /=  default_pointer
		end;

feature -- Status setting

	set_function (a_function: INTEGER) is
			-- Set the logical function' to `a_function'.
		require
			is_valid: is_valid;
			valid_function_range: a_function >= GXclear and then	
					a_function <= GXset
		do
			x_set_function (display_handle, handle, a_function)
		end;

	set_line_attributes (a_line_width: INTEGER; 
				a_line_style, a_cap_style, a_join_style: INTEGER) is
		require
			is_valid: is_valid;
			line_width_large_enough: a_line_width >= 0;
			valid_cap_style: a_cap_style >= CapNotLast and then
					a_cap_style <= CapProjecting;
			valid_style: a_line_style >= LineSolid and then
					a_line_style <= LineDoubleDash;
			valid_join_style: a_join_style >= JoinMiter and then 
					a_join_style <= JoinBevel
		do
			x_set_line_attributes (display_handle, handle, a_line_width, 
				a_line_style, a_cap_style, a_join_style)
		end;

	set_arc_mode (an_arc_style: INTEGER) is
			-- Set arc_mode to ArcChord if `is_arcChord'. Otherwize,
			-- set arc_mode to `ArcPieSlice'.
		require
			is_valid: is_valid;	
			valid_style: an_arc_style = ArcChord or else 
				an_arc_style = ArcPieSlice
		do
			x_set_arc_mode (display_handle, handle, ArcChord)
		end;

	set_cap_style (a_cap_style: INTEGER) is
			-- Set the caps style to `a_cap_style'.
		require
			is_valid: is_valid;
			valid_range: a_cap_style >= CapNotLast and then
					a_cap_style <= CapProjecting
		do
			x_set_cap_style (display_handle, handle, a_cap_style);
		end;

	set_clip_rectangle (x1, y1: INTEGER; a_width, a_height: INTEGER) is
			-- Set a clip area with upper left coordinate `x1' and
			-- `y1' with size `a_width' and `a_height'.
		require
			is_valid: is_valid;
			valid_size: a_width >= 0 and then a_height >= 0
		do
			x_set_clip_rectangles (display_handle, handle, 
				x1, y1, a_width, a_height)
		end;

	set_dashes (a_dash_list: LIST [INTEGER]; offset: INTEGER) is
			-- Set pattern of dash lengths.
		require
			is_valid: is_valid;
			dash_list_not_null: a_dash_list /= Void;
			dash_list_not_empty: not a_dash_list.empty
		local
			an_array_of_char: STRING;
			ext_name: ANY
		do
			!! an_array_of_char.make (a_dash_list.count);
			from
				a_dash_list.start
			until
				a_dash_list.after
			loop
				an_array_of_char.extend (charconv (a_dash_list.item));
				a_dash_list.forth
			end;
			ext_name := an_array_of_char.to_c;
			x_set_dashes (display_handle, handle,
					offset, $ext_name, a_dash_list.count)
		end;

	set_fill_style (a_fill_style: INTEGER) is
			-- Set the style of fill.
		require
			is_valid: is_valid;
			valid_style: a_fill_style >= FillSolid and then
					a_fill_style <= FillOpaqueStippled
		do
			x_set_fill_style (display_handle, handle, a_fill_style);
		end;

	set_background, set_background_color (a_color: MEL_PIXEL) is
			-- Set background color of Gc to `a_color'.
		require
			is_valid: is_valid;
			valid_color: a_color /= Void and then a_color.is_valid
		do
			x_set_background (display_handle, handle, a_color.identifier)
		end;

	set_foreground, set_foreground_color (a_color: MEL_PIXEL) is
			-- Set foreground color of Gc to `a_color'.
		require
			is_valid: is_valid;
			valid_color: a_color /= Void and then a_color.is_valid
		do
			x_set_foreground (display_handle, handle, a_color.identifier)
		end;

	set_join_style (a_join_style: INTEGER) is
			-- Specifies type appearance of joints between consecutive lines.
		require
			is_valid: is_valid;
			valid_style: a_join_style >= JoinMiter and then 
					a_join_style <= JoinBevel
		do
			x_set_join_style (display_handle, handle, a_join_style);
		end;

	set_line_style (a_line_style: INTEGER) is
			-- Set line style.
		require
			is_valid: is_valid;
			valid_style: a_line_style >= LineSolid and then
					a_line_style <= LineDoubleDash
		do
			x_set_line_style (display_handle, handle, a_line_style);
		end;

	set_line_width (new_width: INTEGER) is
			-- Set line to be displayed with width of `new_width'.
		require
			is_valid: is_valid;
			width_large_enough: new_width >= 0
		do
			x_set_line_width (display_handle, handle, new_width);
		end;

	set_clip_mask (a_pixmap: MEL_PIXMAP) is
			-- Set the clip mask to `a_pixmap'. If `a_pixmap' is
			-- Void all pixels are always drawn (removes clip area).
		require
			is_valid: is_valid;
			valid_pixmap: a_pixmap /= Void implies a_pixmap.is_valid
		local
			p_id: POINTER
		do
			if a_pixmap /= Void then	
				p_id := a_pixmap.identifier;	
			end;
			x_set_no_clip (display_handle, handle, p_id)
		end;

	set_stipple (a_stipple: MEL_PIXMAP) is
			-- Set stipple used to fill figures.
			-- (If fill style is FillTiled or FillSolid then the
			-- stipple is not used).
		require
			is_valid: is_valid;
			valid_stipple: a_stipple /= Void and then a_stipple.is_valid;
			stipple_is_bitmap: a_stipple.is_bitmap
		do
			x_set_stipple (display_handle, handle, a_stipple.identifier)
		end;

	set_subwindow_mode (a_mode: INTEGER) is
			-- Set the subwindow mode to ClipByChildren if `is_clip_by_children'.
			-- Otherwize set the subwindow mode to IncludeInferiors.
		require
			is_valid: is_valid;
			valid_mode: a_mode = ClipByChildren or else 
				a_mode = IncludeInferiors
		do
			x_set_subwindow_mode (display_handle, handle, a_mode)
		end;

	set_tile (a_tile: MEL_PIXMAP) is
			-- Set tile used to fill figures. This is used if
			-- fill style is set to `FillTiled'.
		require
			is_valid: is_valid;
			valid_tile: a_tile /= Void and then a_tile.is_valid
		do
			x_set_tile (display_handle, handle, a_tile.identifier)
		end;

	set_font (a_font: MEL_FONT_STRUCT) is
			-- Set GC font font struct `a_font' for all text drawing
			-- (except draw_text).
		require
			valid_font: a_font /= Void and then a_font.is_valid
		do
			x_set_font (display_handle, handle, a_font.font_id)
		end;

feature -- Removal

	free, dispose is
			-- Free the Graphic Context
		do
			if handle /= default_pointer then
				x_free_gc (display_handle, handle)
				handle := default_pointer
			end
		end;

feature {NONE} -- External features

	x_create_gc (a_display: POINTER; drawable: POINTER; 
			value_mask: INTEGER; values: POINTER): POINTER is
		external
			"C [macro <X11/Xlib.h>] (Display *, Drawable, %
				%unsigned long, XGCValues *): EIF_POINTER"
		alias
			"XCreateGC"
		end;

	x_free_gc (a_display: POINTER; a_pointer: POINTER) is
		external
			"C [macro <X11/Xlib.h>] (Display *, GC)"
		alias
			"XFreeGC"
		end;

	x_set_line_attributes (a_display: POINTER; a_gc: POINTER; 
			line_width, line_style, cap_style, join_style: INTEGER) is
		external
			"C [macro <X11/Xlib.h>] (Display *, GC, unsigned int, %
					%int, int, int)"
		alias
			"XSetLineAttributes"
		end;

	x_set_function (a_display: POINTER; a_gc: POINTER; a_funt: INTEGER) is
		external
			"C [macro <X11/Xlib.h>] (Display *, GC, int)"
		alias
			"XSetFunction"
		end;

	x_set_arc_mode (a_display, a_gc: POINTER; a_mode: INTEGER) is
		external
			"C [macro <X11/Xlib.h>] (Display *, GC, int)"
		alias
			"XSetArcMode"
		end;

	x_set_cap_style (a_display, a_gc: POINTER; a_style: INTEGER) is
		external
			"C"
		end;

	x_set_dashes (a_display, a_gc: POINTER; 
				offset: INTEGER; name: POINTER; count: INTEGER) is
		external
			"C [macro <X11/Xlib.h>] (Display *, GC, int, char *, int)"
		alias
			"XSetDashes"
		end;

	x_set_foreground (a_display, a_gc, value: POINTER) is
		external
			"C [macro <X11/Xlib.h>] (Display *, GC, unsigned long)"
		alias
			"XSetForeground"
		end;

	x_set_background (a_display, a_gc, value: POINTER) is
		external
			"C [macro <X11/Xlib.h>] (Display *, GC, unsigned long)"
		alias
			"XSetBackground"
		end;

	x_set_join_style (a_display, a_gc: POINTER; a_style: INTEGER)  is
		external
			"C"
		end;

	x_set_line_style (a_display, a_gc: POINTER; a_style: INTEGER) is
		external
			"C"
		end;

	x_set_line_width (a_display, a_gc: POINTER; a_width: INTEGER) is
		external
			"C"
		end;

	x_set_no_clip (a_display, a_gc, a_pixmap: POINTER) is
		external
			"C [macro <X11/Xlib.h>] (Display *, GC, Pixmap)"
		alias
			"XSetClipMask"
		end;

	x_set_subwindow_mode (dspl_pointer, gc: POINTER; mode: INTEGER) is
		external
			"C [macro <X11/Xlib.h>] (Display *, GC, int)"
		alias
			"XSetSubwindowMode"
		end;

	x_set_stipple (a_display, a_gc, a_pixmap: POINTER) is
		external
			"C [macro <X11/Xlib.h>] (Display *, GC, Pixmap)"
		alias
			"XSetStipple"
		end;

	x_set_tile (a_display, a_gc, a_pixmap: POINTER) is
		external
			"C [macro <X11/Xlib.h>] (Display *, GC, Pixmap)"
		alias
			"XSetTile"
		end;

	x_set_fill_style (a_display, a_gc: POINTER; a_style: INTEGER) is
		external
			"C [macro <X11/Xlib.h>] (Display *, GC, int)"
		alias
			"XSetFillStyle"
		end;

	x_set_clip_rectangles (dspl_pointer, gc: POINTER; x_val, y_val,
					wdth, hght: INTEGER) is
		external
			"C"
		end;

	x_set_font (a_display, a_gc: POINTER; a_font_id: POINTER) is
		external
			"C [macro <X11/Xlib.h>] (Display *, GC, Font)"
		alias
			"XSetFont"
		end;

end -- class MEL_GC

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
