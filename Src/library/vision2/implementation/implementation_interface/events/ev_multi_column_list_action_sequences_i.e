note
	description:
		"Action sequences for EV_MULTI_COLUMN_LIST_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_MULTI_COLUMN_LIST_ACTION_SEQUENCES_I


feature -- Event handling

	select_actions: EV_MULTI_COLUMN_LIST_ROW_SELECT_ACTION_SEQUENCE
			-- Actions to be performed
		do
			if attached select_actions_internal as l_result then
				Result := l_result
			else
				create Result
				select_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	select_actions_internal: detachable EV_MULTI_COLUMN_LIST_ROW_SELECT_ACTION_SEQUENCE
			-- Implementation of once per object `select_actions'.
		note
			option: stable
		attribute
		end

feature -- Event handling

	deselect_actions: EV_MULTI_COLUMN_LIST_ROW_SELECT_ACTION_SEQUENCE
			-- Actions to be performed
		do
			if attached deselect_actions_internal as l_result then
				Result := l_result
			else
				create Result
				deselect_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	deselect_actions_internal: detachable EV_MULTI_COLUMN_LIST_ROW_SELECT_ACTION_SEQUENCE
			-- Implementation of once per object `deselect_actions'.
		note
			option: stable
		attribute
		end

feature -- Event handling

	column_title_click_actions: EV_COLUMN_ACTION_SEQUENCE
			-- Actions to be performed
		do
			if attached column_title_click_actions_internal as l_result then
				Result := l_result
			else
				create Result
				column_title_click_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	column_title_click_actions_internal: detachable EV_COLUMN_ACTION_SEQUENCE
			-- Implementation of once per object `column_title_click_actions'.
		note
			option: stable
		attribute
		end

feature -- Event handling

	column_resized_actions: EV_COLUMN_ACTION_SEQUENCE
			-- Actions to be performed
		do
			if attached column_resized_actions_internal as l_result then
				Result := l_result
			else
				create Result
				column_resized_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	column_resized_actions_internal: detachable EV_COLUMN_ACTION_SEQUENCE
			-- Implementation of once per object `column_resized_actions'.
		note
			option: stable
		attribute
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




end











