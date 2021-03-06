note
	description: "Objects that demonstrate an EV_RADIO_BUTTON"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	RADIO_BUTTON_BASIC_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create
			-- Create `Current' and initialize test in `widget'.
		do
			create radio_button.make_with_text ("A radio button")			
		
			widget := radio_button
		end
		
feature {NONE} -- Implementation

	radio_button: EV_RADIO_BUTTON;
		-- Widget that test is to be performed on.

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


end -- class RADIO_BUTTON_BASIC_TEST
