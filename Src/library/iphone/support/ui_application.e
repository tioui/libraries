note
	description: "[
		Represent the current application object responsible of event handling. To get an instance, you need
		to use {SHARED_UI_APPLICATION}.application.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	UI_APPLICATION

inherit
	UI_OBJECT

create {SHARED_UI_APPLICATION}
	make_from_pointer

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
