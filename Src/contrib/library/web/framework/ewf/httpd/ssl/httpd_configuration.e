note
	description: "Standalone server configuration (ssl supported)."
	date: "$Date$"
	revision: "$Revision$"

class
	HTTPD_CONFIGURATION

inherit
	HTTPD_CONFIGURATION_I
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Create a new instance and set ssl protocol to tls_1_2.
		do
			Precursor
			set_secure_protocol_to_tls_1_2
		ensure then
			secure_protocol_set: secure_protocol = {SSL_PROTOCOL}.tls_1_2
		end

feature -- Access

	Server_details: STRING_8 = "Server: Standalone Eiffel Server (secure)"

	has_secure_support: BOOLEAN = True
			-- Precursor		

feature -- SSL Helpers

	set_secure_protocol_to_ssl_2_or_3
			-- Set `ssl_protocol' with `Ssl_23'.
			-- Protocol not supported anymore.
		obsolete
			"Use set_secure_protocol_to_tls_1_2 [2017-06-23]."
		local
			err: DEVELOPER_EXCEPTION
		do
			create err
			err.set_description ("SSL_2 or SSL_3 are not supported anymore, upgrate to TLS set_secure_protocol_to_tls_1_2")
			err.raise
		end

	set_secure_protocol_to_tls_1_0
			-- Set `secure_protocol' with `Tls_1_0'.
		do
			set_secure_protocol ({SSL_PROTOCOL}.Tls_1_0)
		end

	set_secure_protocol_to_tls_1_1
			-- Set `secure_protocol' with `Tls_1_1'.
		do
			set_secure_protocol ({SSL_PROTOCOL}.Tls_1_1)
		end

	set_secure_protocol_to_tls_1_2
			-- Set `secure_protocol' with `Tls_1_2'.
		do
			set_secure_protocol ({SSL_PROTOCOL}.Tls_1_2)
		end

	set_secure_protocol_to_dtls_1_0
			-- Set `secure_protocol' with `Dtls_1_0'.
		do
			set_secure_protocol ({SSL_PROTOCOL}.Dtls_1_0)
		end


note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
