note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			class_icon,
			on_menu_command,
			on_paint
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			make_top (Title)
			set_menu (main_menu)
			resize (500, 300)
		end

feature {NONE} -- Implementation

	on_menu_command (menu_id: INTEGER)
		local
			rect: WEL_RECT
			print_dialog: WEL_PRINT_DIALOG
			printer_dc: WEL_PRINTER_DC
			i: INTEGER
		do
			inspect
				menu_id
			when Cmd_exit then
				destroy
			when Cmd_print then
				create print_dialog.make
				print_dialog.disable_selection
				print_dialog.disable_selection
				print_dialog.activate (Current)
				if print_dialog.selected then
					printer_dc := print_dialog.dc
					printer_dc.start_document ("WEL Print Test")
					from
						i := print_dialog.copies
					until
						i <= 0
					loop
						printer_dc.start_page
						create rect.make (0, 0, printer_dc.width, printer_dc.height)
						draw (printer_dc, rect)
						printer_dc.end_page
						i := i - 1
					end
					printer_dc.end_document
				end
			end
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
		do
			draw (paint_dc, client_rect)
		end

	draw (a_dc: WEL_DC; a_rect: WEL_RECT)
			-- Draw the figures on the dc
		do
			a_dc.rectangle (0, 0, a_rect.width, a_rect.height)
			a_dc.ellipse (0, 0, a_rect.width, a_rect.height)
			a_dc.move_to (0, 0)
			a_dc.line_to (a_rect.width, a_rect.height)
			a_dc.move_to (a_rect.width, 0)
			a_dc.line_to (0, a_rect.height)
			a_dc.draw_centered_text ("Hello, Printer!", a_rect)
		end

	class_icon: WEL_ICON
			-- Window's icon
		once
			create Result.make_by_id (Id_ico_application)
		end

	main_menu: WEL_MENU
			-- Window's menu
		once
			create Result.make_by_id (Id_main_menu)
		ensure
			result_not_void: Result /= Void
		end

	Title: STRING = "WEL Print";
			-- Window's title

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


end -- class MAIN_WINDOW

