note
	description: "[
					Generated by EiffelRibbon tool
					Don't edit this file, since it will be replaced by EiffelRibbon tool
					generated files everytime
																							]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GROUP_IN_RIBBON_GALLERY_IMP

inherit
	EV_RIBBON_GROUP

feature {NONE} -- Initialization

	create_interface_objects
			-- Create objects
		do
			create in_ribbon_gallery.make_with_command_list (<<{COMMAND_NAME_CONSTANTS}.in_ribbon_gallery>>)

			create buttons.make (1)
			buttons.extend (in_ribbon_gallery)

		end

feature -- Query

	in_ribbon_gallery: IN_RIBBON_GALLERY


end

