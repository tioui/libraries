note
	description: "[
					Objects that represent the Ribbon Vision2 application.%
					%The original version of this class has been generated by EiffelRibbon
																									]"
	generator: "EiffelBuild"
	date: "$Date$"
	revision: "$Revision$"

class
	RIBBON_APPLICATION

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch
			-- Create `Current', build and display `main_window',
			-- then launch the application.
		local
			l_app: EV_APPLICATION
		do
			create l_app
			create_interface_objects
			main_window.show
			l_app.launch
		end

feature {NONE} -- Implementation

	create_interface_objects
			-- <Precursor>
		do
			create main_window
			add_items_to_combo_box
			add_items_to_drop_down_gallery
		end

	add_items_to_combo_box
			-- Add items to combo box
		local
			l_list: ARRAYED_LIST [EV_RIBBON_COMBO_BOX_ITEM]
			l_item: EV_RIBBON_COMBO_BOX_ITEM
		do
			create l_list.make (1)
			create l_item
			l_item.set_label ("first item")
			l_list.extend (l_item)

			create l_item
			l_item.set_label ("second item")
			l_list.extend (l_item)

			main_window.ribbon.tab.group.combobox.set_item_source (l_list)
		end

	add_items_to_drop_down_gallery
			-- Add items to dropdown gallery
		local
			l_list: ARRAYED_LIST [EV_RIBBON_DROP_DOWN_GALLERY_ITEM]
			l_item: EV_RIBBON_DROP_DOWN_GALLERY_ITEM
			l_pixel_buffer: EV_PIXEL_BUFFER
		do
			create l_list.make (1)
			create l_item
			create l_pixel_buffer
			l_pixel_buffer.set_with_named_file ("./res/AddTableL.bmp")
			l_item.set_image (l_pixel_buffer)
			l_item.set_label ("first item")
			l_list.extend (l_item)

			create l_item
			create l_pixel_buffer
			l_pixel_buffer.set_with_named_file ("./res/Paste.bmp")
			l_item.set_image (l_pixel_buffer)
			l_item.set_label ("second item")
			l_list.extend (l_item)

			main_window.ribbon.tab.group.drop_down_gallery.set_item_source (l_list)
		end

	main_window: MAIN_WINDOW
		-- Main window of `Current'

end
