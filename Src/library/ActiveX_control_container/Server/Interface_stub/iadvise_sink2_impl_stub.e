indexing
	description: "Implemented `IAdviseSink2' Interface."
	Note: "Automatically generated by the EiffelCOM Wizard."

class
	IADVISE_SINK2_IMPL_STUB

inherit
	IADVISE_SINK2_INTERFACE

	ECOM_STUB

feature -- Basic Operations

	on_data_change (p_formatetc: TAG_FORMATETC_RECORD; p_stgmed: CELL [WIRE_ASYNC_STGMEDIUM_ALIAS]) is
			-- No description available.
			-- `p_formatetc' [in].  
			-- `p_stgmed' [in].  
		do
			-- Put Implementation here.
		end

	on_view_change (dw_aspect: INTEGER; lindex: INTEGER) is
			-- No description available.
			-- `dw_aspect' [in].  
			-- `lindex' [in].  
		do
			-- Put Implementation here.
		end

	on_rename (pmk: IMONIKER_INTERFACE) is
			-- No description available.
			-- `pmk' [in].  
		do
			-- Put Implementation here.
		end

	on_save is
			-- No description available.
		do
			-- Put Implementation here.
		end

	on_close is
			-- No description available.
		do
			-- Put Implementation here.
		end

	on_link_src_change (pmk: IMONIKER_INTERFACE) is
			-- No description available.
			-- `pmk' [in].  
		do
			-- Put Implementation here.
		end

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IADVISE_SINK2_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_control_library::IAdviseSink2_impl_stub %"ecom_control_library_IAdviseSink2_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- IADVISE_SINK2_IMPL_STUB

