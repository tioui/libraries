note
	description: "Agents for SD_TOOL_BAR_ZONE dragging issues."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_DRAGGING_AGENTS

create
	make

feature {NONE}  -- Initlization

	make (a_docking_manager: SD_DOCKING_MANAGER; a_tool_bar_zone: SD_TOOL_BAR_ZONE)
			-- Creation method.
		require
			not_void: a_docking_manager /= Void
			not_void: a_tool_bar_zone /= Void
		do
			default_create
			create internal_shared
			internal_docking_manager := a_docking_manager
			zone := a_tool_bar_zone

			init_actions
		ensure
			set: internal_docking_manager = a_docking_manager
			set: zone = a_tool_bar_zone
		end

	init_actions
			-- Initialize actions.
		do
			on_pointer_motion_agent := agent on_pointer_motion
			on_pointer_release_agent := agent on_pointer_release
			zone.tool_bar.pointer_motion_actions.extend (on_pointer_motion_agent)
			zone.tool_bar.pointer_button_release_actions.extend (on_pointer_release_agent)
		end

feature -- Agents

	on_drag_area_pressed (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Handle drag area pressed.
		do
			if not is_destroyed then
				if a_button = {EV_POINTER_CONSTANTS}.left and is_in_drag_area (a_screen_x, a_screen_y) then
					internal_pointer_pressed := True
					internal_docker_mediator := Void
					internal_shared.set_tool_bar_docker_mediator (Void)

					internal_shared.setter.before_enable_capture
					-- Following `enable_capture' will cancel pointer double press actions of SD_TOOL_BAR_TITLE_BAR on GTK.				
					zone.tool_bar.enable_capture
				end
			end
		ensure
			pointer_press_set: not is_destroyed implies
								(a_button = {EV_POINTER_CONSTANTS}.left and is_in_drag_area (a_screen_x, a_screen_y) implies internal_pointer_pressed = True)
			docker_mediaot_void: not is_destroyed implies
								(a_button = {EV_POINTER_CONSTANTS}.left and is_in_drag_area (a_screen_x, a_screen_y) implies internal_docker_mediator = Void)
		end

	on_drag_area_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Handle drag area release.
		do
			if not is_destroyed then
				if a_button = {EV_POINTER_CONSTANTS}.left and is_in_drag_area (a_screen_x, a_screen_y) then
					internal_pointer_pressed := False
					internal_docker_mediator := Void
					internal_shared.set_tool_bar_docker_mediator (Void)
					zone.tool_bar.disable_capture
					internal_shared.setter.after_disable_capture
				end
			end
		ensure
			pointer_press_set: not is_destroyed implies
								(a_button = {EV_POINTER_CONSTANTS}.left and is_in_drag_area (a_screen_x, a_screen_y) implies internal_pointer_pressed = False)
			docker_mediator_void: not is_destroyed implies
								(a_button = {EV_POINTER_CONSTANTS}.left and is_in_drag_area (a_screen_x, a_screen_y) implies internal_docker_mediator = Void)
		end

	on_drag_area_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Handle drag area motion.
		require
			not_destroyed: not is_destroyed
		local
			l_pixmaps: EV_STOCK_PIXMAPS
			l_offset_x, l_offset_y: INTEGER
		do
			if not is_destroyed then
				create l_pixmaps
				if internal_docker_mediator = Void then
					if zone.drag_area_rectangle.has_x_y (a_x, a_y) then
						zone.tool_bar.set_pointer_style (l_pixmaps.sizeall_cursor)
						setted := True
					elseif setted then
						zone.tool_bar.set_pointer_style (l_pixmaps.standard_cursor)
						setted := False
					end
				end
				if internal_pointer_pressed then
					if internal_docker_mediator = Void then
						-- Capture is alreadyed enable when `on_drag_area_pressed'
						zone.tool_bar.set_pointer_style (l_pixmaps.sizeall_cursor)

						create internal_docker_mediator.make (zone, internal_docking_manager)
						internal_docker_mediator.start_drag (a_screen_x, a_screen_y)

						if zone.is_floating then
							l_offset_x := a_screen_x - zone.floating_tool_bar.screen_x
							l_offset_y := a_screen_y - zone.floating_tool_bar.screen_y
						else
							l_offset_x := a_screen_x - zone.tool_bar.screen_x
							l_offset_y := a_screen_y - zone.tool_bar.screen_y
							if l_offset_x < 0 then
								l_offset_x := 0
							end
							if l_offset_y < 0 then
								l_offset_y := 0
							end
						end
						internal_docker_mediator.set_offset (zone.is_floating, l_offset_x, l_offset_y)
						internal_docker_mediator.cancel_actions.extend (agent on_cancel)
					end
				end
			end
		ensure
			capture_enable: not is_destroyed implies
							(internal_pointer_pressed and (zone.drag_area_rectangle.has_x_y (a_x, a_y) or zone.is_floating)
							implies internal_docker_mediator /= Void)
			-- We can't not guaranntee caller have capture on GTK, since we disable it temporty when floating from docking(or docking from floating).
		end

	on_drag_area_pointer_double_press (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Handle pointer double press actions.
		do
			if not is_destroyed then
				if not zone.is_floating then
					if zone.drag_area_rectangle.has_x_y (a_x, a_y) then
						zone.assistant.floating_last_state
					end
				end
			end
		end

feature -- Query

	is_in_drag_area (a_screen_x, a_screen_y: INTEGER): BOOLEAN
			-- If `a_screen_x' and `a_screen_y' in drag area?
		require
			not_destroyed: not is_destroyed
		local
			l_in_docking_gripper_area, l_in_floating_tool_bar: BOOLEAN
		do
			l_in_docking_gripper_area := zone.drag_area_rectangle.has_x_y (a_screen_x - zone.tool_bar.screen_x, a_screen_y - zone.tool_bar.screen_y)
			if zone.is_floating then
				l_in_floating_tool_bar := zone.floating_tool_bar.internal_title_bar.drag_rectangle.has_x_y (a_screen_x, a_screen_y)
			end
			debug ("docking")
				print ("%N SD_TOOL_BAR_DRAGGING_AGENTS is_in_drag_area: l_in_docking_gripper_area " + l_in_docking_gripper_area.out + "; l_in_floating_tool_bar " + l_in_floating_tool_bar.out)
			end
			Result := l_in_docking_gripper_area or l_in_floating_tool_bar
		end

	is_destroyed: BOOLEAN
			-- If Current destroyed?

feature -- Command

	destroy
			-- Clear references
		do
			zone.tool_bar.pointer_motion_actions.prune_all (on_pointer_motion_agent)
			zone.tool_bar.pointer_button_release_actions.prune_all (on_pointer_release_agent)
			internal_docking_manager := Void
			is_destroyed := True
		ensure
			destroyed: is_destroyed
		end

feature {NONE} -- Implementation functions

	on_cancel
			-- Handle user cancel dragging events.
		local
			l_pixmaps: EV_STOCK_PIXMAPS
		do
			if not is_destroyed then
				zone.tool_bar.disable_capture
				internal_shared.setter.after_disable_capture
				internal_pointer_pressed := False
				internal_docker_mediator := Void
				internal_shared.set_tool_bar_docker_mediator (Void)
				create l_pixmaps
				zone.tool_bar.set_pointer_style (l_pixmaps.standard_cursor)
			end
		ensure
			disable_capture: not is_destroyed implies not zone.tool_bar.has_capture
			not_pointer_pressed: not is_destroyed implies not internal_pointer_pressed
			cleared: not is_destroyed implies (internal_shared.tool_bar_docker_mediator_cell.item = Void and internal_docker_mediator = Void)
		end

	on_pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Handle pointer motion.
		do
			if not is_destroyed then
				if internal_docker_mediator /= Void then
					internal_docker_mediator.on_pointer_motion (a_screen_x, a_screen_y)
				end
			end
		ensure
			pointer_motion_forwarded:
		end

	on_pointer_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Handle pointer release.
		do
			if not is_destroyed then
				if internal_docker_mediator /= Void and a_button = {EV_POINTER_CONSTANTS}.left then
					internal_docker_mediator.apply_change (a_screen_x, a_screen_y)
					on_cancel
				end
			end
		ensure
			disable_capture: not is_destroyed implies
								((internal_docker_mediator /= Void and a_button = {EV_POINTER_CONSTANTS}.left) implies not zone.tool_bar.has_capture)
			not_pointer_pressed: not is_destroyed implies
								(a_button = {EV_POINTER_CONSTANTS}.left and internal_docker_mediator /= Void implies not internal_pointer_pressed)
			cleared: not is_destroyed implies
								(a_button = {EV_POINTER_CONSTANTS}.left implies internal_shared.tool_bar_docker_mediator_cell.item = Void)
		end

feature {NONE} -- Implementation attributes

	setted: BOOLEAN
		-- If pointer style setted?

	internal_shared: SD_SHARED
			-- All singletons.

	zone: SD_TOOL_BAR_ZONE
			-- Tool bar zone current belong to.		

	internal_docker_mediator: SD_TOOL_BAR_DOCKER_MEDIATOR
			-- Docker mediator.

	internal_pointer_pressed: BOOLEAN
			-- If pointer pressed?

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager Current belong to.

	on_pointer_motion_agent : PROCEDURE [ANY, TUPLE [INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]]
	on_pointer_release_agent: PROCEDURE [ANY, TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]];
			-- Agents registered into tool bar actions.

invariant
	not_void: internal_shared /= Void
	not_void: zone /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
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
