indexing
	description: "Dib colors (DIB) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DIB_COLORS_CONSTANTS

feature -- Access

	Dib_rgb_colors: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"DIB_RGB_COLORS"
		end

	Dib_pal_colors: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"DIB_PAL_COLORS"
		end

end -- class WEL_DIB_COLORS_CONSTANTS

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
