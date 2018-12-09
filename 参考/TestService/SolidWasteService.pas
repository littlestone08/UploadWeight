// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://211.90.38.54:18282/WebService/SolidWasteService?wsdl
//  >Import : http://211.90.38.54:18282/WebService/SolidWasteService?wsdl=ISolidWasteService.wsdl
//  >Import : http://211.90.38.54:18282/WebService/SolidWasteService?wsdl=ISolidWasteService.wsdl>0
// Encoding : UTF-8
// Version  : 1.0
// (2018/10/19 9:49:25 - - $Rev: 90173 $)
// ************************************************************************ //

unit SolidWasteService;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_UNQL = $0008;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]



  // ************************************************************************ //
  // Namespace : http://api.weighbridge.internet.shencai.com/
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : SolidWasteServiceImplServiceSoapBinding
  // service   : SolidWasteServiceImplService
  // port      : SolidWasteServiceImplPort
  // URL       : http://211.90.38.54:18282/WebService/SolidWasteService
  // ************************************************************************ //
  ISolidWasteService = interface(IInvokable)
  ['{4C6FB50E-23F9-5664-0A8D-F79439A6E7E1}']
    function  process(const arg0: string): string; stdcall;
  end;

function GetISolidWasteService(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): ISolidWasteService;


implementation
  uses System.SysUtils;

function GetISolidWasteService(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): ISolidWasteService;
const
  defWSDL = 'http://211.90.38.54:18282/WebService/SolidWasteService?wsdl';
  defURL  = 'http://211.90.38.54:18282/WebService/SolidWasteService';
  defSvc  = 'SolidWasteServiceImplService';
  defPrt  = 'SolidWasteServiceImplPort';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as ISolidWasteService);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


initialization
  { ISolidWasteService }
  //InvRegistry.RegisterInvokeOptions(TypeInfo(ISolidWasteService),ioDocument);
  InvRegistry.RegisterInterface(TypeInfo(ISolidWasteService), 'http://api.weighbridge.internet.shencai.com/', 'UTF-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(ISolidWasteService), '');
  InvRegistry.RegisterInvokeOptions(TypeInfo(ISolidWasteService), ioDocument);
  { ISolidWasteService.process }
  InvRegistry.RegisterMethodInfo(TypeInfo(ISolidWasteService), 'process', '',
                                 '[ReturnName="return"]', IS_OPTN or IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(ISolidWasteService), 'process', 'arg0', '',
                                '', IS_UNQL);
  InvRegistry.RegisterParamInfo(TypeInfo(ISolidWasteService), 'process', 'return', '',
                                '', IS_UNQL);

end.