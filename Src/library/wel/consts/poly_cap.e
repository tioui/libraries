indexing
	description: "Polygonal capabilities (PC) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_POLYGONAL_CAPABILITIES_CONSTANTS

feature -- Access

	Pc_none: INTEGER is
			-- Supports no polygons
		external
			"C [macro <wel.h>]"
		alias
			"PC_NONE"
		end

	Pc_polygon: INTEGER is
			-- Supports alternate fill polygons
		external
			"C [macro <wel.h>]"
		alias
			"PC_POLYGON"
		end

	Pc_rectangle: INTEGER is
			-- Supports rectangles
		external
			"C [macro <wel.h>]"
		alias
			"PC_RECTANGLE"
		end

	Pc_windpolygon: INTEGER is
			-- Supports winding number fill polygons
		external
			"C [macro <wel.h>]"
		alias
			"PC_WINDPOLYGON"
		end

	Pc_scanline: INTEGER is
			-- Supports scan lines
		external
			"C [macro <wel.h>]"
		alias
			"PC_SCANLINE"
		end

	Pc_wide: INTEGER is
			-- Supports wide borders
		external
			"C [macro <wel.h>]"
		alias
			"PC_WIDE"
		end

	Pc_styled: INTEGER is
			-- Supports styled borders
		external
			"C [macro <wel.h>]"
		alias
			"PC_STYLED"
		end

	Pc_widestyled: INTEGER is
			-- Supports wide, styled borders
		external
			"C [macro <wel.h>]"
		alias
			"PC_WIDESTYLED"
		end

	Pc_interiors: INTEGER is
			-- Supports interiors
		external
			"C [macro <wel.h>]"
		alias
			"PC_INTERIORS"
		end

end -- class WEL_POLYGONAL_CAPABILITIES_CONSTANTS

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
