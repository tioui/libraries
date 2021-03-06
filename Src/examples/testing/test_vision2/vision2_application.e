note
	description: "EiffelVision Custom Application.%
		%The original version of this class has been generated by EiffelBuild."
	generator: "EiffelBuild"
	date: "$Date$"
	revision: "$Revision$"

class
	VISION2_APPLICATION

inherit
	EV_APPLICATION
		redefine
			create_interface_objects,
			initialize
		end

create
	default_create, make_and_launch

feature {NONE} -- Initialization

	make_and_launch
			-- Create, initialize and launch event loop.
		do
			default_create
			launch
		end

feature {NONE} -- User Initialization

	user_create_interface_objects
			-- User object creation.
		do
				-- Create Window
			create main_window
		end

	user_initialization
			-- User object initialization.
		do
				-- Show Window
			main_window.show
		end

feature -- Access

	main_window: MAIN_WINDOW
			-- Application Main Window.	

feature {NONE} -- Implementation

	frozen initialize
			-- <Precursor>
			-- Do not alter routine.
		do
			user_initialization
			Precursor
		end

	frozen create_interface_objects
			-- <Precursor>
			-- Do not alter routine.
		do
			user_create_interface_objects
			Precursor
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
