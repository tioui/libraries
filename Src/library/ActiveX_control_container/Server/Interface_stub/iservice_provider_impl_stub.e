indexing
	description: "Implemented `IServiceProvider' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	ISERVICE_PROVIDER_IMPL_STUB

inherit
	ISERVICE_PROVIDER_INTERFACE

	ECOM_STUB

feature -- Basic Operations

	query_service (guid_service: ECOM_GUID; riid: ECOM_GUID; ppv_object: CELL [ECOM_INTERFACE]) is
			-- No description available.
			-- `guid_service' [in].  
			-- `riid' [in].  
			-- `ppv_object' [out].  
		do
			-- Put Implementation here.
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: ISERVICE_PROVIDER_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_control_library::IServiceProvider_impl_stub %"ecom_control_library_IServiceProvider_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- ISERVICE_PROVIDER_IMPL_STUB

