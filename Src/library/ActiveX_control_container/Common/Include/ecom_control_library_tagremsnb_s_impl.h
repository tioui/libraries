/*-----------------------------------------------------------
"Automatically generated by the EiffelCOM Wizard."Added Record tagRemSNB
	ulCntStr: ULONG
			-- No description available.
	ulCntChar: ULONG
			-- No description available.
	rgString: Pointed Type
			-- No description available.
	
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_TAGREMSNB_S_IMPL_H__
#define __ECOM_CONTROL_LIBRARY_TAGREMSNB_S_IMPL_H__

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagRemSNB_s.h"

#include "ecom_grt_globals_control_interfaces2.h"

#ifdef __cplusplus
extern "C" {
#endif



#ifdef __cplusplus

#define ccom_tag_rem_snb_ul_cnt_str(_ptr_) (EIF_INTEGER)(ULONG)(((ecom_control_library::tagRemSNB *)_ptr_)->ulCntStr)

#define ccom_tag_rem_snb_set_ul_cnt_str(_ptr_, _field_) ((((ecom_control_library::tagRemSNB *)_ptr_)->ulCntStr) = (ULONG)_field_)

#define ccom_tag_rem_snb_ul_cnt_char(_ptr_) (EIF_INTEGER)(ULONG)(((ecom_control_library::tagRemSNB *)_ptr_)->ulCntChar)

#define ccom_tag_rem_snb_set_ul_cnt_char(_ptr_, _field_) ((((ecom_control_library::tagRemSNB *)_ptr_)->ulCntChar) = (ULONG)_field_)

#define ccom_tag_rem_snb_rg_string(_ptr_) (EIF_REFERENCE)(rt_ce.ccom_ce_pointed_short (((ecom_control_library::tagRemSNB *)_ptr_)->rgString, NULL))

#define ccom_tag_rem_snb_set_rg_string(_ptr_, _field_) (grt_ce_control_interfaces2.ccom_free_memory_pointed_290(((ecom_control_library::tagRemSNB *)_ptr_)->rgString), (((ecom_control_library::tagRemSNB *)_ptr_)->rgString) = rt_ec.ccom_ec_pointed_short (eif_access (_field_), NULL))

#endif
#ifdef __cplusplus
}
#endif

#endif