indexing
	description: "Objects that represent an EV_TITLED_WINDOW.%
		%The original version of this class was generated by EiffelBuild."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEXT_PANEL_IMP

inherit
	CONSTANTS

feature -- Access

	widget: EV_HORIZONTAL_BOX
		-- `Result' is widget with which `Current' is implemented

-- This class is the implementation of an EV_TITLED_WINDOW generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize is
			-- Initialize `Current'.
		do
			initialize_constants
			
				-- Create all widgets.
			create main_vbox
			create inner_hbox
			create margin_container
			create editor_viewport
			create editor_drawing_area
			create horizontal_scrollbar
			create scroll_vbox
			create vertical_scrollbar
			create scroll_cell
			
				-- Build_widget_structure.
			widget.extend (main_vbox)
			main_vbox.extend (inner_hbox)
			inner_hbox.extend (margin_container)
			inner_hbox.extend (editor_viewport)
			editor_viewport.extend (editor_drawing_area)
			main_vbox.extend (horizontal_scrollbar)
			widget.extend (scroll_vbox)
			scroll_vbox.extend (vertical_scrollbar)
			scroll_vbox.extend (scroll_cell)
			
			main_vbox.disable_item_expand (horizontal_scrollbar)
			inner_hbox.disable_item_expand (margin_container)
			editor_viewport.set_item_width (10)
			editor_viewport.set_item_height (10)
			editor_drawing_area.set_minimum_width (10)
			editor_drawing_area.set_minimum_height (10)
			horizontal_scrollbar.value_range.adapt (create {INTEGER_INTERVAL}.make (0, 1))
			horizontal_scrollbar.set_step (5)
			scroll_vbox.disable_item_expand (scroll_cell)
			vertical_scrollbar.disable_sensitive
			vertical_scrollbar.value_range.adapt (create {INTEGER_INTERVAL}.make (0, 1))
			widget.disable_item_expand (scroll_vbox)
			
				--Connect events.
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Basic operation

	show is
			-- Show `Current'.
		do
			widget.show
		end

feature -- Access

	horizontal_scrollbar: EV_HORIZONTAL_SCROLL_BAR
	vertical_scrollbar: EV_VERTICAL_SCROLL_BAR
	main_vbox: EV_VERTICAL_BOX
	scroll_vbox: EV_VERTICAL_BOX
	inner_hbox: EV_HORIZONTAL_BOX
	margin_container: EV_CELL
	scroll_cell: EV_CELL
	editor_viewport: EV_VIEWPORT
	editor_drawing_area: EV_DRAWING_AREA

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			-- Re-implement if you wish to enable checking
			-- for `Current'.
			Result := True
		end
	
	user_initialization is
			-- Feature for custom initialization, called at end of `initialize'.
		deferred
		end
	
end -- class TEXT_PANEL_IMP
