note
	description: "[
		Constants for all xebra classes.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XU_CONSTANTS

feature -- Xebra

	Version: STRING = "Community Preview 1.0"

feature -- Files

	Webapp_config_file: STRING = "config.wapp"
	Taglib_config_file: STRING = "config.taglib"
	Extension_melted: STRING = ".melted"
	Extension_ecf: STRING = ".ecf"
	Extension_xeb: STRING = ".xeb"
	Extension_xrpc: STRING = ".xrpc"
	Dir_svn: STRING = ".svn"
	Dir_eifgen: STRING = "EIFGENs"
	Dir_w_code: STRING = "W_code"
	Dir_f_code: STRING = "F_code"


feature -- Network

	Cmd_server_port: INTEGER = 55002
	Http_server_port: INTEGER = 55001
	Max_tcp_clients: INTEGER = 100
	Socket_accept_timeout: INTEGER = 1000
	Socket_connect_timeout: INTEGER = 5000

feature -- Debugging

	Translator_debug_name: STRING = "XT"

feature -- Completion messages

	Successful_translation: STRING = "System translated."
	Servlet_generation_completed: STRING = "System generated."

feature -- Special Tags

	Render_attribute_name: STRING = "render"
	Css_class_attribute_name: STRING = "css_class"
	Class_attribute_name: STRING = "class"

feature -- Env vars

	Xebra_root_env: STRING = "XEBRA_DEV"
	Xebra_library_env: STRING = "XEBRA_LIBRARY"

feature -- Filenames

	Webapp_voidsafe_postfix: STRING = "-safe"
	Servlet_gen_executed_file: STRING = "sg_executed_at_time"
	Translator_executed_file: STRING = "t_executed_at_time"
	Servlet_gen_name: STRING = "servlet_gen"
	Servlets_folder_name: STRING = "servlets"
	Generated_folder_name: STRING = ".generated"
	Servlet_gen_ecf: STRING = "servlet_gen.ecf"

feature -- Response

	Response_ct_html: STRING = "text/html;charset=ascii"
	Response_ct_xml: STRING = "text/xml"
	Response_Html_start: STRING = "#H#"
	Response_content_type_start: STRING = "#CT#"

feature -- Request Message

	Request_file_upload_iis: STRING = "#FUPI#"
	Request_file_upload_apache: STRING = "#FUPA#"
	Request_file_upload_filename: STRING = "#FN#"
	Request_method_get: STRING = "GET"
	Request_method_post: STRING = "POST"
	Request_http: STRING = "HTTP/"
	Request_http11: STRING = "HTTP/1.1"
	Request_http10: STRING = "HTTP/1.0"
	Request_space: STRING = " "
	Request_questionmark: STRING = "?"
	Request_hi: STRING = "#HI#"
	Request_ho: STRING = "#HO#"
	Request_end: STRING = "#E#"
	Request_se: STRING = "#SE#"
	Request_t_name: STRING = "#$#"
	Request_t_value: STRING = "#%%#"
	Request_arg: STRING = "#A#"
	Request_content_type: STRING = "Content-Type"
	Request_ct_form: STRING = "application/x-www-form-urlencoded"
	Request_post_too_big: STRING = "#PTB#"

feature -- Cookie Order

	Cookie_uuid: STRING = "Xuuid"
	Cookie_start: STRING = "#C#"
	Cookie_end: STRING = "#CE#"
	Cookie_eq: STRING = "="
	Cookie_sqp: STRING = "; "
	Cookie_sq: STRING = ";"
	Cookie_max_age: STRING = "Max-Age="
	Cookie_path: STRING = "Path="
	Cookie_version: STRING = "Version="
	Cookie_domain: STRING = "Domain="
	Cookie_secure: STRING = "Secure"
	Cookie_comment: STRING = "Comment="

feature -- Webapp

	Initial_session_length: NATURAL = 60

feature -- Time

	Two_seconds_in_nanoseconds: NATURAL = 2000000000

feature -- Translator

	Folder_replacement_string: STRING = "___"


note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
