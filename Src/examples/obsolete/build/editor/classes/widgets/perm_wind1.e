note
	description: "Permanent window: Editor."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$";
	description: "Permanent window."

class PERM_WIND1

inherit
	WINDOWS;
	STATES;
	PERM_WIND
		undefine
			init_toolkit
		redefine
			realize, make
		end

create 
	make

feature  -- Creation

	make (a_name: STRING; a_parent: SCREEN)
		do
			 Precursor (a_name, a_parent)
			create scrolled_text1.make ("Scrolled_text1", Current)
			create push_b1.make ("push_b1", Current)
			create push_b2.make ("push_b2", Current)
			create push_b3.make ("push_b3", Current)
			create push_b4.make ("push_b4", Current)
			create push_b5.make ("push_b5", Current)
			set_values
		end

	set_values
		do
			set_title ("Editor")
			scrolled_text1.set_font_name ("Arial,16,400,,default,dontcare,default,0,0,0,default,default,default")
			scrolled_text1.set_x_y (82, - 3)
			scrolled_text1.set_size (412, 513)
			push_b1.set_text ("VIEW")
			push_b1.forbid_recompute_size
			push_b1.set_font_name ("Celtic,20,700,,default,dontcare,default,0,0,0,default,default,default")
			push_b1.set_x_y (7, 13)
			push_b1.set_size (67, 26)
			push_b2.set_text ("BACK")
			push_b2.forbid_recompute_size
			push_b2.set_font_name ("Celtic,20,700,,default,dontcare,default,0,0,0,default,default,default")
			push_b2.set_x_y (7, 49)
			push_b2.set_size (67, 26)
			push_b3.set_text ("OPEN")
			push_b3.forbid_recompute_size
			push_b3.set_font_name ("Celtic,20,700,,default,dontcare,default,0,0,0,default,default,default")
			push_b3.set_x_y (7, 85)
			push_b3.set_size (67, 26)
			push_b4.set_text ("SAVE")
			push_b4.forbid_recompute_size
			push_b4.set_font_name ("Celtic,20,700,,default,dontcare,default,0,0,0,default,default,default")
			push_b4.set_x_y (7, 121)
			push_b4.set_size (67, 26)
			push_b5.set_text ("QUIT")
			push_b5.forbid_recompute_size
			push_b5.set_font_name ("Celtic,20,700,,default,dontcare,default,0,0,0,default,default,default")
			push_b5.set_x_y (7, 157)
			push_b5.set_size (67, 26)
			set_x_y (105, 34)
			set_size (494, 510)
			record_resize_policy (perm_wind1.scrolled_text1, True, True, True, True)
			record_resize_policy (perm_wind1.push_b1, False, False, True, True)
			record_resize_policy (perm_wind1.push_b2, False, False, True, True)
			record_resize_policy (perm_wind1.push_b3, False, False, True, True)
			record_resize_policy (perm_wind1.push_b4, False, False, True, True)
			record_resize_policy (perm_wind1.push_b5, False, False, True, True)
			set_colors
		end

	set_colors
		local
			a_color: COLOR
			a_pixmap: PIXMAP
		do
			create a_pixmap.make
			a_pixmap.read_from_file ("C:\WINNT\Soap Bubbles.bmp")
			set_background_pixmap (a_pixmap)
			create a_color.make
			a_color.set_name ("NavyBlue")
			perm_wind1.scrolled_text1.set_background_color (a_color)
			create a_color.make
			a_color.set_name ("white")
			perm_wind1.scrolled_text1.set_foreground_color (a_color)
		end

feature  -- Attributes

	scrolled_text1: SCROLLED_T

	push_b1: PUSH_B
			-- VIEW

	push_b2: PUSH_B
			-- BACK

	push_b3: PUSH_B
			-- OPEN

	push_b4: PUSH_B
			-- SAVE

	push_b5: PUSH_B
			-- QUIT

feature  -- Realization

	realize
		do
			set_callbacks
			 Precursor
		end

	set_callbacks
		do
			set_scrolled_text1_callbacks
			set_push_b1_callbacks
			set_push_b2_callbacks
			set_push_b3_callbacks
			set_push_b4_callbacks
			set_push_b5_callbacks
		end

	set_scrolled_text1_callbacks
		local
			com1: COMMAND3
			meta_command: META_COMMAND
		do
			create com1.make
			create meta_command.make
			meta_command.add (basic, com1)
			perm_wind1.scrolled_text1.add_modify_action (meta_command, void)
		end

	set_push_b1_callbacks
		local
			com1: COMMAND1
			com2: COMMAND1
			meta_command: META_COMMAND
		do
			create com1.make (perm_wind1.scrolled_text1)
			create com2.make (perm_wind1.scrolled_text1)
			create meta_command.make
			meta_command.add (editing, com1)
			meta_command.add (basic, com2)
			perm_wind1.push_b1.add_activate_action (meta_command, void)
		end

	set_push_b2_callbacks
		local
			com1: COMMAND4
			meta_command: META_COMMAND
		do
			create com1.make (perm_wind1.scrolled_text1)
			create meta_command.make
			meta_command.add (viewing, com1)
			perm_wind1.push_b2.add_activate_action (meta_command, void)
		end

	set_push_b3_callbacks
		local
			com1: BUILD_OPEN
			com2: BUILD_OPEN
			meta_command: META_COMMAND
		do
			create com1.make (perm_wind1.scrolled_text1)
			create com2.make (perm_wind1.scrolled_text1)
			create meta_command.make
			meta_command.add (editing, com1)
			meta_command.add (basic, com2)
			perm_wind1.push_b3.add_activate_action (meta_command, void)
		end

	set_push_b4_callbacks
		local
			com1: BUILD_SAVE
			meta_command: META_COMMAND
		do
			create com1.make (perm_wind1.scrolled_text1)
			create meta_command.make
			meta_command.add (editing, com1)
			perm_wind1.push_b4.add_activate_action (meta_command, void)
		end

	set_push_b5_callbacks
		local
			com1: COMMAND2
			com2: COMMAND2
			com3: COMMAND2
			meta_command: META_COMMAND
		do
			create com1.make
			create com2.make
			create com3.make
			create meta_command.make
			meta_command.add (editing, com1)
			meta_command.add (basic, com2)
			meta_command.add (viewing, com3)
			perm_wind1.push_b5.add_activate_action (meta_command, void)
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


end -- class PERM_WIND1
