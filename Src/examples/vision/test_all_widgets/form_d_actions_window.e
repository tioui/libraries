class FORM_D_ACTIONS_WINDOW

inherit

	ACTIONS_WINDOW
		redefine
			set_other_widgets,
			descendant_actions,
			set_other_widgets_insensitive,
			set_other_widgets_sensitive
		end

creation

	make

feature

	allow_resize_b,
	forbid_resize_b,
	popup_b,
	popdown_b: ACTION_WINDOW_BUTTON

	set_other_widgets is
		do
			set_size (330, 350)
			!!allow_resize_b.associate (Current, b_allow_resize, "Allow resize", 20, 260)
			!!forbid_resize_b.associate (Current, b_forbid_resize, "Forbid resize", 180, 260)
			!!popup_b.associate (Current, b_popup, "Popup", 20, 300)
			!!popdown_b.associate (Current, b_popdown, "Popdown", 180, 300)
		end

	descendant_actions(arg: INTEGER_REF) is
		local
			dialog: DIALOG
		do
			dialog ?= demo_window_array.item(main_window.current_demo)
			inspect arg.item
			when b_allow_resize then
				dialog.allow_resize
			when b_forbid_resize then
				dialog.forbid_resize
			when b_popup then
				dialog.popup
			when b_popdown then
				dialog.popdown
			else
			end
		end

	set_other_widgets_insensitive is
		do
			allow_resize_b.set_insensitive
			forbid_resize_b.set_insensitive
			popup_b.set_insensitive
			popdown_b.set_insensitive
		end

	set_other_widgets_sensitive is
		do
			allow_resize_b.set_sensitive
			forbid_resize_b.set_sensitive
			popup_b.set_sensitive
			popdown_b.set_sensitive
		end

end -- class FORM_D_ACTIONS_WINDOW
