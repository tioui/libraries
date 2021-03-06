note

	description: 
		"EiffelVision implementation of a MOTIF manager widget."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 
	MANAGER_IMP

inherit

	COMPOSITE_IMP;

	MEL_MANAGER
		rename
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen
		end

feature -- Access

	is_stackable: BOOLEAN 
			-- Is the Current widget stackable?
		do
			Result := True;
		end;

feature -- Status Report

	foreground_color: COLOR
			-- Color used for the foreground_color
		local
			fg_color_x: COLOR_IMP
		do
			if private_foreground_color = Void then
				create private_foreground_color.make;
				fg_color_x ?= private_foreground_color.implementation;
				fg_color_x.set_default_pixel (mel_foreground_color,
						mel_screen.default_colormap);
				fg_color_x.increment_users
			end;
			Result := private_foreground_color;
		ensure
			color_exists: Result /= Void
		end;

feature -- Status Setting

	set_foreground_color (a_color: COLOR)
			-- Set `foreground_color' to `a_color'.
		require
			a_color_exists: not (a_color = Void)
		local
			color_implementation: COLOR_IMP;	
		do
			if private_foreground_color /= Void then
				color_implementation ?= private_foreground_color.implementation;
				color_implementation.decrement_users;
			end;
			private_foreground_color := a_color;
			color_implementation ?= a_color.implementation;
			color_implementation.increment_users;
			color_implementation.allocate_pixel;
			set_foreground_color_from_imp (color_implementation)
		ensure
			set: foreground_color = a_color
		end;

	set_initial_input_focus (a_widget: WIDGET)
			-- Set child which will initially have input focus
		local
			widget_implementation: WIDGET_IMP
		do
			widget_implementation ?= a_widget.implementation
			check
				widget_implementation /= void
			end
			set_initial_focus (widget_implementation)
		end

feature {COLOR_IMP} -- Implementation

	private_foreground_color: COLOR;
			-- foreground_color color

	update_foreground_color
			-- Update the X color after a change inside the Eiffel color.
		local
			color_implementation: COLOR_IMP
		do
			color_implementation ?= private_foreground_color.implementation;
			color_implementation.allocate_pixel;
			set_foreground_color_from_imp (color_implementation);
		end

	set_foreground_color_from_imp (color_imp: COLOR_IMP)
			-- Set the background color from implementation `color_imp'.
		require
			valid_color_imp: color_imp /= Void and color_imp.is_valid
		do
			mel_set_foreground_color (color_imp)
		end;

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




end -- class MANAGER_IMP

