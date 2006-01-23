indexing
	description: "Objects that represent an EV_DIALOG.%
		%The original version of this class was generated by EiffelBuild."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SHOW_SELECTION_DIALOG_IMP

inherit
	EV_DIALOG
		redefine
			initialize, is_in_default_state
		end
			
	CONSTANTS
		undefine
			is_equal, default_create, copy
		end

-- This class is the implementation of an EV_DIALOG generated by EiffelBuild.
-- You should not modify this code by hand, as it will be re-generated every time
-- modifications are made to the project.

feature {NONE}-- Initialization

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_DIALOG}
			initialize_constants
			
				-- Create all widgets.
			create l_ev_vertical_box_1
			create information_list
			create l_ev_horizontal_box_1
			create l_ev_cell_1
			create close_button
			
				-- Build_widget_structure.
			extend (l_ev_vertical_box_1)
			l_ev_vertical_box_1.extend (information_list)
			l_ev_vertical_box_1.extend (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.extend (l_ev_cell_1)
			l_ev_horizontal_box_1.extend (close_button)
			
			l_ev_vertical_box_1.set_padding_width (box_padding)
			l_ev_vertical_box_1.set_border_width (box_padding)
			l_ev_vertical_box_1.disable_item_expand (l_ev_horizontal_box_1)
			l_ev_horizontal_box_1.disable_item_expand (close_button)
			close_button.set_text ("Close")
			close_button.set_minimum_width (button_width)
			set_minimum_width (300)
			set_minimum_height (200)
			set_title ("Selection")
			
				--Connect events.
			close_button.select_actions.extend (agent close_button_selected)
				-- Close the application when an interface close
				-- request is recieved on `Current'. i.e. the cross is clicked.

				-- Call `user_initialization'.
			user_initialization
		end

feature -- Access

	information_list: EV_LIST
	close_button: EV_BUTTON

feature {NONE} -- Implementation

	l_ev_cell_1: EV_CELL
	l_ev_horizontal_box_1: EV_HORIZONTAL_BOX
	l_ev_vertical_box_1: EV_VERTICAL_BOX

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
	
	close_button_selected is
			-- Called by `select_actions' of `close_button'.
		deferred
		end
	

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class SHOW_SELECTION_DIALOG_IMP
