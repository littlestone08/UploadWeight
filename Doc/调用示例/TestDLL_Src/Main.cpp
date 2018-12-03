# include <iostream>
#include <windows.h>
# include <string>
#include "gov_WeightInfoUpload.h"

using namespace std; 


int main() {
	func_epgov_WeightInfo_Upload upload_func;
	func_epgov_WeightInfo_Auth auth_func;

	HMODULE dll_handle =  LoadLibrary("gov_WeightInfoUpload.dll");

	if (dll_handle != NULL)
	{
		if ((auth_func = (func_epgov_WeightInfo_Auth) GetProcAddress(dll_handle, "epgov_WeightInfo_Auth")) != 0)
		{
			int ret;
			string s_token("57da9a9249ad64146273edea3010118077e3");
			string s_manifest_no("350201201709080001");
			string s_plate_number("晋A98001");
			string s_driver_name("李四");
			string s_driver_idc("111111111111111111");
			ret = auth_func((char*)s_token.c_str(),
						(char*)s_manifest_no.c_str(),
						(char*)s_plate_number.c_str(),
						(char*)s_driver_name.c_str(),
						(char*)s_driver_idc.c_str()
			);
			printf("ret value call epgov_WeightInfo_Auth: %d\n", ret);
		};

		if ((upload_func = (func_epgov_WeightInfo_Upload) GetProcAddress(dll_handle, "epgov_WeightInfo_Upload")) != 0)
		{
			int ret;
			string s_token("57da9a9249ad64146273edea3010118077e3");
			string s_manifest_no("350201201709080001");
			string s_plate_number("晋A98001");
			string s_driver_name("李四");
			string s_driver_idc("111111111111111111");
			string s_weight_bridge_no("03");

			weight_info gross_weight;
			gross_weight.weight = 200;

			GetSystemTime(&gross_weight.weight_time);
			gross_weight.weight_time.wMinute -= 30;

			weight_info tare_weight;
			tare_weight.weight = 100;

			GetSystemTime(&tare_weight.weight_time);

			ret = upload_func((char*)s_token.c_str(), 
						(char*)s_manifest_no.c_str(), 
						(char*)s_plate_number.c_str(), 
						(char*)s_driver_name.c_str(), 
						(char*)s_driver_idc.c_str(), 
						(char*)s_weight_bridge_no.c_str(), 						
						&gross_weight, &tare_weight);
			printf("ret value call epgov_WeightInfo_Upload: %d\n", ret);

			
		}
		FreeLibrary(dll_handle);
	}
	return 0; 
}
