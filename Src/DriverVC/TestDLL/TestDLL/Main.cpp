# include <iostream>
#include <windows.h>
# include <string>
#include "gov_WeightInfoUpload.h"

using namespace std; 

void link_string2struct(string& value, str_info& info)
{
	info.lpbuf = (void*)(value.c_str());	
	info.nsize = static_cast<uint8_t>(value.length());

}
int main() {
	gov_WeightInfoUpload_func upload_func;
	HMODULE dll_handle =  LoadLibrary("gov_WeightInfoUpload.dll");

	if (dll_handle != NULL)
	{
		if ((upload_func = (gov_WeightInfoUpload_func) GetProcAddress(dll_handle, "epgov_WeightInfoUpload")) != 0)
		{
			string s_token("57da9a9249ad64146273edea3010118077e3");
			string s_manifest_no("350201201709080001");
			string s_computer_id("COMPUTER98001");
			string s_credential_num("20081209882");
			string s_commodity("炉渣");
			string s_plate_number("晋A98001");
			string s_company_delivery("发货公司名");
			string s_company_receipt("收货公司名");

			str_info token;	
			link_string2struct(s_token, token);

			str_info manifest_no;	
			link_string2struct(s_manifest_no, manifest_no);

			str_info computer_id;	
			link_string2struct(s_computer_id, computer_id);		

			str_info credential_num;
			link_string2struct(s_credential_num, credential_num);		

			str_info commodity;
			link_string2struct(s_commodity, commodity);		

			str_info plate_number;
			link_string2struct(s_plate_number, plate_number);		

			str_info company_delivery;
			link_string2struct(s_company_delivery, company_delivery);		

			str_info company_receipt;
			link_string2struct(s_company_receipt, company_receipt);		

			weight_info gross_weight;
			gross_weight.weight = 200;
			gross_weight.weight_bridge_num = 1;
			GetSystemTime(&gross_weight.weight_time);
			gross_weight.weight_time.wMinute -= 30;

			weight_info tare_weight;
			tare_weight.weight = 100;
			tare_weight.weight_bridge_num = 1;
			GetSystemTime(&tare_weight.weight_time);

			upload_func(&token, &manifest_no, &computer_id, 123, &credential_num, &commodity, &plate_number, &company_delivery, &company_receipt, &gross_weight, &tare_weight);

			
		}
		FreeLibrary(dll_handle);
	}

	
	string str1 = "yesterday once more"; 
	string str2 ("my heart go on"); 
	string str3 (str1,6); // = day once more 
	string str4 (str1,6,3); // = day 
	char ch_music[] = {"Roly-Poly"}; 
	string str5 = ch_music; // = Roly-Poly 
	string str6 (ch_music); // = Roly-Poly
	string str7 (ch_music,4); // = Roly 
	string str8 (10,'i'); // = iiiiiiii 
	string str9 (ch_music+5, ch_music+9); // = Poly
	str9.~string(); 
	cout<<str9<<endl; // 测试输出 getchar();
	cout << "---the end ----"<<endl;
	return 0; }
