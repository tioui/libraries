indexing
	description: "Objects that demonstrate simple use of%
		%`border_width' for EV_VERTICAL_BOX"
	date: "$Date$"
	revision: "$Revision$"

class
	VERTICAL_BOX_BORDER_WIDTH_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create vertical_box
			vertical_box.extend (
				create {EV_BUTTON}.make_with_text ("First item"))
			vertical_box.extend (
				create {EV_BUTTON}.make_with_text ("Second item"))
			vertical_box.extend (
				create {EV_BUTTON}.make_with_text ("Third item"))
			vertical_box.set_border_width (20)
				
			widget := vertical_box
		end
		
feature {NONE} -- Implementation

	vertical_box: EV_VERTICAL_BOX
		-- Widget that test is to be performed on.

	padding_output_label: EV_LABEL
		-- Label to show level of padding.

	increase_padding_button, decrease_padding_button: EV_BUTTON
		-- Buttons used to alter padding.

end -- class VERTICAL_BOX_BORDER_WIDTH_TEST
