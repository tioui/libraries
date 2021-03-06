note

	description:
			"Unmanaged MEL_BULLETIN_BOARD as child of MEL_DIALOG_SHELL."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_BULLETIN_BOARD_DIALOG

inherit

	MEL_BULLETIN_BOARD
		rename
			make as bulletin_make,
			make_no_auto_unmanage as bulletin_make_no_auto_unmanage
		export
			{NONE} bulletin_make, bulletin_make_no_auto_unmanage
		redefine
			create_widget, parent, created_dialog_automatically
		end

create
	make,
	make_no_auto_unmanage

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE)
			-- Create a motif bulletin dialog widget.
		require
			name_exists: a_name /= Void
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			widget_name := a_name.to_c;
			create_widget (a_parent.screen_object, widget_name, True);
			create parent.make_from_existing (xt_parent (screen_object), a_parent);
			Mel_widgets.add (Current);
			set_default
		ensure
			nont_void_parent: parent /= Void;
			parent_set: parent.parent = a_parent;
			name_set: name.is_equal (a_name)
		end;

	make_no_auto_unmanage (a_name: STRING; a_parent: MEL_COMPOSITE)
			-- Create a motif bulletin dialog widget and
			-- set `auto_unmanage' to False.
		require
			name_exists: a_name /= Void
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			widget_name := a_name.to_c;
			create_widget (a_parent.screen_object, widget_name, False);
			create parent.make_from_existing (xt_parent (screen_object), a_parent);
			Mel_widgets.add (Current);
			set_default
		ensure
			nont_void_parent: parent /= Void;
			parent_set: parent.parent = a_parent;
			name_set: name.is_equal (a_name)
		end;

feature {NONE} -- Initialization

	create_widget (p_so: POINTER; w_name: ANY; auto_manage_flag: BOOLEAN)
			-- Create bulletin with `auto_manage_flag'.
		do
			if auto_manage_flag then
				screen_object :=
					xm_create_bulletin_board_dialog (p_so,
						$w_name, default_pointer, 0);
			else
				screen_object :=
					xm_create_bulletin_board_dialog (p_so,
						$w_name, auto_unmanage_arg, 1);
			end;
		end;

feature -- Access

	parent: MEL_DIALOG_SHELL;
			-- Dialog shell

feature {NONE} -- Implementation

	created_dialog_automatically: BOOLEAN
			-- Was the dialog shell created automatically?
		do
			Result := True
		end;

feature {NONE} -- Implementation

	xm_create_bulletin_board_dialog (a_parent, a_name, arglist: POINTER; 
				argcount: INTEGER): POINTER
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/BulletinB.h>"
		alias
			"XmCreateBulletinBoardDialog"
		end;

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




end -- class MEL_BULLETIN_BOARD_DIALOG


