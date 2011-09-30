note
	description: "[
						Objects that represent an EV_RIBBON_TITLED_WINDOW
						The original version of this class was generated by EiffelRibbon.
																			]"
	generator: "EiffelBuild"
	date: "$Date$"
	revision: "$Revision$"

class
	MAIN_WINDOW

inherit
	EV_RIBBON_TITLED_WINDOW
		redefine
			create_interface_objects,
			initialize
		end

	EV_SHARED_APPLICATION
		undefine
			default_create, copy
		end


feature {NONE}-- Initialization

	initialize
			-- Initialize `Current'.
		do
			Precursor {EV_RIBBON_TITLED_WINDOW}

				-- Build widget structure.

			set_title ("Ribbon window")

				-- Call `user_initialization'.
			user_initialization
		end

	user_initialization
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			set_size (800, 400)

				-- Attach Ribbon by COM here
			ribbon.init_with_window (Current)
			close_request_actions.extend (agent ev_application.destroy)
			show_actions.extend_kamikaze (agent
									do
										if attached ev_application as l_app then
											l_app.destroy_actions.extend (agent ribbon.destroy)
										end
									end)
		end

	create_interface_objects
			-- <Precursor>
		do
				-- Initialize before calling Precursor all the attached attributes
				-- from the current class.

				-- Proceed with vision2 objects creation.
			Precursor
			create ribbon.make

		end

feature -- Access

	ribbon: RIBBON
			-- Ribbon attached to current

end

