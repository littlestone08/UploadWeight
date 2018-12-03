//#ifndef _GOV_WEIGHTINFO_UPLOAD_H_
//#define _GOV_WEIGHTINFO_UPLOAD_H_
#include <cstdint>
#include <windows.h>



typedef struct{
	_SYSTEMTIME weight_time;
	double		weight;
} weight_info, *ptr_weight_info;




typedef int  (WINAPI *func_epgov_WeightInfo_Auth)(
	char* token,
	char* manifest_no,

	char* plate_number,
	char* driver,
	char* driver_identifycard_no
	); 



typedef int  (WINAPI *func_epgov_WeightInfo_Upload)(
	char* token,
	char* manifest_no,

	char* plate_number,
	char* driver,
	char* driver_identifycard_no,

	char* weight_bridge_no,

	ptr_weight_info gross_weight,
	ptr_weight_info tare_weight
	); 
