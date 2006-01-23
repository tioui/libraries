indexing
	description: "Server configuration constants"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Marina Nudelman"
	date: "$Date$"
	revision: "$Revision$"

class
	EOLE_SERVER_CONFIGURATION


feature -- Access

	clsid: STRING is "{4E0EE810-891B-11d1-831F-00A02469D020}"
			-- String representation of CLSID of component
			-- Should be filled by user

	typelib_id: STRING is "{AEB9F740-B68E-11d2-B961-00403392AC95}"
			-- String representation of UUID of component's type library
			-- Should be filled by user

	dispinterface_id: STRING is "{AEB9F741-B68E-11d2-B961-00403392AC95}"
			-- String representation of UUID of dispinterface
			-- Should be filled by user

	component_name: STRING is "EiffelCOM Analyser"
			-- Component name
			-- Should be filled by user
	
	company_name: STRING is "ISE"
			-- Company name
			-- Should be filled by user

	product_name: STRING is "Example"
			-- Product name
			-- Should be filled by user

	major_version_number: INTEGER is 1
			-- Major version namber
			-- Should be filled by user

	minor_version_number: INTEGER is 0;
			-- Minor version number
			-- Should be filled by user


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


end -- class EOLE_SERVER_CONFIGURATION
