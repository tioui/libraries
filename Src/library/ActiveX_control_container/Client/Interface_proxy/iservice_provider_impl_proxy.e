indexing
	description: "Implemented `IServiceProvider' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	ISERVICE_PROVIDER_IMPL_PROXY

inherit
	ISERVICE_PROVIDER_INTERFACE

	ECOM_QUERIABLE

creation
	make_from_other,
	make_from_pointer

feature {NONE}  -- Initialization

	make_from_pointer (cpp_obj: POINTER) is
			-- Make from pointer
		do
			initializer := ccom_create_iservice_provider_impl_proxy_from_pointer(cpp_obj)
			item := ccom_item (initializer)
		end

feature -- Basic Operations

	query_service (guid_service: ECOM_GUID; riid: ECOM_GUID; ppv_object: CELL [ECOM_INTERFACE]) is
			-- No description available.
			-- `guid_service' [in].  
			-- `riid' [in].  
			-- `ppv_object' [out].  
		do
			ccom_query_service (initializer, guid_service.item, riid.item, ppv_object)
		end

feature {NONE}  -- Implementation

	delete_wrapper is
			-- Delete wrapper
		do
			ccom_delete_iservice_provider_impl_proxy(initializer)
		end

feature {NONE}  -- Externals

	ccom_query_service (cpp_obj: POINTER; guid_service: POINTER; riid: POINTER; ppv_object: CELL [ECOM_INTERFACE]) is
			-- No description available.
		external
			"C++ [ecom_control_library::IServiceProvider_impl_proxy %"ecom_control_library_IServiceProvider_impl_proxy_s.h%"](GUID *,GUID *,EIF_OBJECT)"
		end

	ccom_delete_iservice_provider_impl_proxy (a_pointer: POINTER) is
			-- Release resource
		external
			"C++ [delete ecom_control_library::IServiceProvider_impl_proxy %"ecom_control_library_IServiceProvider_impl_proxy_s.h%"]()"
		end

	ccom_create_iservice_provider_impl_proxy_from_pointer (a_pointer: POINTER): POINTER is
			-- Create from pointer
		external
			"C++ [new ecom_control_library::IServiceProvider_impl_proxy %"ecom_control_library_IServiceProvider_impl_proxy_s.h%"](IUnknown *)"
		end

	ccom_item (cpp_obj: POINTER): POINTER is
			-- Item
		external
			"C++ [ecom_control_library::IServiceProvider_impl_proxy %"ecom_control_library_IServiceProvider_impl_proxy_s.h%"]():EIF_POINTER"
		end

end -- ISERVICE_PROVIDER_IMPL_PROXY

