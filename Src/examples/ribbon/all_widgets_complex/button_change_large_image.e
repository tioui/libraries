note
	description: "[
					Generated by EiffelRibbon tool
																							]"
	date: "$Date$"
	revision: "$Revision$"

class
	BUTTON_CHANGE_LARGE_IMAGE

inherit
	BUTTON_CHANGE_LARGE_IMAGE_IMP
		redefine
			create_interface_objects
		end

create
	{EV_RIBBON_GROUP, EV_RIBBON_SPLIT_BUTTON} make_with_command_list

feature -- Query

	text: STRING_32 = "Button 1"
			-- This is generated by EiffelRibbon tool

feature {NONE} -- Initialization

	create_interface_objects
			-- <Precursor>
		do
			Precursor
			select_actions.extend (agent
										local
											l_pixel_buffer: EV_PIXEL_BUFFER
										do
											create l_pixel_buffer
											if counter.item \\ 2 = 0 then
												l_pixel_buffer.set_with_named_file ("./res/Button_Image.bmp")
											else
												l_pixel_buffer.set_with_named_file ("./res/PrintRelationshipsL.bmp")
											end
											set_large_image (l_pixel_buffer)
											counter.put (counter.item + 1)
										end)
		end

	counter: CELL [INTEGER]
			--
		once
			create Result.put (0)
		end

end
