indexing
	description: "An editable combo-box that handles bitmaps."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DROP_DOWN_COMBO_BOX_EX

inherit
	WEL_COMBO_BOX_EX
		redefine
			text_length,
			set_text,
			text
		end

	WEL_EM_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Status report

	text_length: INTEGER is
			-- Text length
		do
			Result := cwin_get_window_text_length (edit_item)
		end

	text: STRING is
			-- Window text
		local
			length: INTEGER
			a_wel_string: WEL_STRING
			nb: INTEGER
		do
			length := text_length
			if length > 0 then
				length := length + 1
				create Result.make (length)
				Result.fill_blank
				create a_wel_string.make (Result)
				nb := cwin_get_window_text (edit_item, a_wel_string.item, length)
				Result := a_wel_string.string
				Result.keep_head (nb)
			else
				create Result.make (0)
			end
		end

feature -- Status settings

	set_text (a_text: STRING) is
			-- Set the window text
		local
			a_wel_string: WEL_STRING
		do
			if a_text /= Void then
				create a_wel_string.make (a_text)
			else
				create a_wel_string.make_empty (0)
			end
			cwin_set_window_text (edit_item, a_wel_string.item)
		end

	set_limit_text (limit: INTEGER) is
			-- Set the length of the text the user may type.
		require
			exists: exists
			positive_limit: limit >= 0
		do
			cwin_send_message (edit_item, Em_limittext, to_wparam (limit), to_lparam (0))
		end

feature {NONE} -- Implementation

	edit_item: POINTER is
			-- Return the child edit control that composes the
			-- current control. Corresponds to a WEL_EDIT.
		require
			exists: exists
		do
			Result := cwin_send_message_result (item, Cbem_geteditcontrol, to_wparam (0), to_lparam (0))
		end

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_border
				+ Cbs_autohscroll + Cbs_dropdown
		end

end -- class WEL_DROP_DOWN_COMBO_BOX_EX

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

