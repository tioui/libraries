indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class BUTTON_ACTIONS_WINDOW

inherit

	ACTIONS_WINDOW
		redefine
			set_other_widgets,
			descendant_actions,
			set_other_widgets_sensitive,
			set_other_widgets_insensitive,
			finish
		end

create

	make

feature


	set_font_b,
	set_fg_b,
	activate_b,
	set_center_b,
	set_left_b,
	set_text_b: ACTION_WINDOW_BUTTON

	set_other_widgets is
		do
			set_size (330, 430)
			create set_font_b.associate (Current, b_set_font, "Set font", 20, 300)
			create set_fg_b.associate (Current, b_set_fg, "Set fg", 20, 340)
			create activate_b.associate (Current, b_activate, "Activate", 20, 380)
			create set_center_b.associate (Current, b_set_center, "Set center", 180, 300)
			create set_left_b.associate (Current, b_set_left, "Set left", 180, 340)
			create set_text_b.associate (Current, b_set_text, "Set text", 180, 380)
		end

	activate_action: BOOLEAN

	finish is
		local
			widget: PUSH_B
	do
		if activate_action then
			activate_action:=False
			widget ?= demo_window_array.item(main_window.current_demo).main_widget
			widget.remove_activate_action (Current, m_activate)
		end
	end

	descendant_actions(arg: INTEGER_REF) is
		local
			widget: PUSH_B
			color: COLOR
		do
			widget ?= demo_window_array.item(main_window.current_demo).main_widget
			inspect arg.item
			when b_set_font then
				if font_box.is_popped_up then
					font_box.remove_ok_action (Current, b_set_font)
					font_box.remove_cancel_action (Current, b_font_cancel)
					widget.set_font (font_box.font)
					font_box.popdown
					set_widgets_sensitive
				else
					font_box.add_ok_action (Current, b_set_font)
					font_box.add_cancel_action (Current, b_font_cancel)
					set_widgets_insensitive
					font_box.popup
				end
			when b_font_cancel then
				font_box.remove_ok_action (Current, b_set_font)
				font_box.remove_cancel_action (Current, b_font_cancel)
				font_box.popdown
				set_widgets_sensitive
			when b_set_fg then
				if prompt.is_popped_up then
					prompt.remove_ok_action (Current, b_bg_color)
					prompt.remove_cancel_action (Current, b_cancel)
					create color.make
					color.set_name(prompt.selection_text)
					widget.set_background_color(color)
					set_widgets_sensitive
					prompt.popdown
				else
					prompt.add_ok_action (Current, b_bg_color)
					prompt.add_cancel_action (Current, b_cancel)
					prompt.set_selection_label("Enter color:")
					prompt.set_selection_text ("")
					prompt_type:=b_bg_color
					set_widgets_insensitive
					prompt.popup
				end
			when b_activate then
				if activate_action then
					activate_action:=False
					widget.remove_activate_action (Current, m_activate)
				else
					activate_action:=True
					widget.add_activate_action (Current, m_activate)
				end
			when m_activate then
				if md.is_popped_up then
					md.popdown
					md.remove_ok_action (Current, m_activate)
					set_widgets_sensitive
				else
					md.set_message ("Activated")
					md.add_ok_action (Current, m_activate)
					md.popup
					set_widgets_insensitive
				end
			when b_set_center then
				widget.set_center_alignment
			when b_set_left then
				widget.set_left_alignment
			when b_set_text then
				if prompt.is_popped_up then
					prompt.remove_ok_action (Current, b_set_text)
					prompt.remove_cancel_action (Current, b_cancel)
					prompt.popdown
					widget.set_text(prompt.selection_text)
					set_widgets_sensitive
					prompt_type:=0
				else
					prompt_type:=b_set_text
					prompt.set_selection_label("Enter string:")
					prompt.set_selection_text("")
					prompt.add_ok_action (Current, b_set_text)
					prompt.add_cancel_action (Current, b_cancel)
					set_widgets_insensitive
					prompt.popup
				end
			else
			end
		end

	set_other_widgets_insensitive is
		do
			set_font_b.set_insensitive
			set_fg_b.set_insensitive
			activate_b.set_insensitive
			set_center_b.set_insensitive
			set_left_b.set_insensitive
			set_text_b.set_insensitive
		end

	set_other_widgets_sensitive is
		do
			set_font_b.set_sensitive
			set_fg_b.set_sensitive
			activate_b.set_sensitive
			set_center_b.set_sensitive
			set_left_b.set_sensitive
			set_text_b.set_sensitive
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


end -- class BUTTON_ACTIONS_WINDOW

