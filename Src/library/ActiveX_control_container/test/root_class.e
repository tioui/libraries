note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	ROOT_CLASS

create
	make

feature -- Initialization

	make
			-- 
		local
			control_site: CONTROL_SITE
		do
			create control_site.make
		end
		
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




end -- ROOT_CLASS
