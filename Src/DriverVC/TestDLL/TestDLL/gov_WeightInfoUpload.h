//#ifndef _GOV_WEIGHTINFO_UPLOAD_H_
//#define _GOV_WEIGHTINFO_UPLOAD_H_
#include <cstdint>
#include <windows.h>

typedef struct {
	void* lpbuf;
	uint8_t nsize;
}str_info, *ptr_str_info;

typedef struct{
	_SYSTEMTIME weight_time;
	uint8_t		weight_bridge_num;
	double		weight;
} weight_info, *ptr_weight_info;

typedef void  (WINAPI *gov_WeightInfoUpload_func)(
	ptr_str_info token,
	ptr_str_info manifest_no,
	ptr_str_info computer_id,
	uint8_t		 tran_type,
	ptr_str_info credential_n,
	ptr_str_info commodity,

	ptr_str_info plate_number,
	ptr_str_info company_delivery,
	ptr_str_info company_receipt,
	ptr_weight_info gross_weight,
	ptr_weight_info tare_weight
	); 
