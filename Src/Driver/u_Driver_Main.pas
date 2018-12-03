unit u_Driver_Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type

  TStrInfo = AnsiString;
  PStrInfo = PAnsiChar;

  TWeightInfo = Record
    WeighingTime: TSystemTime;
    Weight: Double;
  End;
  PWeightInfo = ^TWeightInfo;

//  Tepgov_WeightInfoUpload = Procedure (
//    Token     : PStrInfo;
//    ManifestNo: PStrInfo;
//
//    ComputerID: PStrInfo;
//    TranType  : Byte;
//    CredentialNo: PStrInfo;
//    Commodity:PStrInfo;
//
//    PlateNumber: PStrInfo;
//    CompanyDelivery: PStrInfo;
//    CompanyReceipt: PStrInfo;
//
//    GrossWeight: PWeightInfo;
//    TareWeight: PWeightInfo
//  ); stdcall;


  Tepgov_WeightInfo_Upload = Procedure (
    Token     : PStrInfo;
    ManifestNo: PStrInfo;

    PlateNumber: PStrInfo;
    DriverName : PStrInfo;
    DriverIdentityCardNo: PStrInfo;

    WeightBridgeNo: PStrInfo;

    GrossWeight: PWeightInfo;
    TareWeight: PWeightInfo
  ); stdcall;

  Tepgov_WeightInfo_Auth = Function (
    Token     : PStrInfo;
    ManifestNo: PStrInfo;

    PlateNumber: PStrInfo;
    DriverName : PStrInfo;
    DriverIdentityCardNo: PStrInfo
  ): Integer; stdcall;


  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    FHandle: THandle;
    FUploadProc: Tepgov_WeightInfo_Upload;
    FAuthProc: Tepgov_WeightInfo_Auth;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  g_ComputerID: Integer;
implementation

{$R *.dfm}

{ TStrInfo }


procedure TForm1.Button1Click(Sender: TObject);
var
    Token     : TStrInfo;
    ManifestNo: TStrInfo;

    PlateNumber: TStrInfo;
    DriverName: TStrInfo;
    DriverIdentityCardNo: TStrInfo;

    WeightBridgeNo: TStrInfo;

    GrossWeight: TWeightInfo;
    TareWeight: TWeightInfo;
begin

  Token:= '57da9a9249ad64146273edea3010118077e3';
  ManifestNo:= '350201201709080001';
  PlateNumber:= '冀A234563';
  DriverName:= '张三';
  DriverIdentityCardNo:= '000000000000000000';
  WeightBridgeNo:= '09';

  With GrossWeight do
  begin
    DateTimeToSystemTime(Now() - 0.01, WeighingTime);
    Weight:= 200;
  end;

  With TareWeight do
  begin
    DateTimeToSystemTime(Now(), WeighingTime);
    Weight:= 100;
  end;
  FUploadProc(PAnsiChar(Token),
              PAnsiChar(ManifestNo),
              PAnsiChar(PlateNumber),
              PAnsiChar(DriverName),
              PAnsiChar(DriverIdentityCardNo),
              PAnsiChar(WeightBridgeNo),
              @GrossWeight, @TareWeight);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
    Token     : TStrInfo;
    ManifestNo: TStrInfo;

    PlateNumber: TStrInfo;
    DriverName: TStrInfo;
    DriverIdentityCardNo: TStrInfo;

    WeightBridgeNo: TStrInfo;

    GrossWeight: TWeightInfo;
    TareWeight: TWeightInfo;
begin

  Token:= '57da9a9249ad64146273edea3010118077e3';
  ManifestNo:= '350201201709080001';
  PlateNumber:= '冀A234563';
  DriverName:= '张三';
  DriverIdentityCardNo:= '000000000000000000';

  With GrossWeight do
  begin
    DateTimeToSystemTime(Now() - 0.01, WeighingTime);
    Weight:= 200;
  end;

  With TareWeight do
  begin
    DateTimeToSystemTime(Now(), WeighingTime);
    Weight:= 100;
  end;
  FAuthProc(PAnsiChar(Token),
              PAnsiChar(ManifestNo),
              PAnsiChar(PlateNumber),
              PAnsiChar(DriverName),
              PAnsiChar(DriverIdentityCardNo)
);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FHandle:= LoadLibrary('gov_WeightInfoUpload.dll');
  if FHandle <> 0 then
  begin
    FUploadProc:= GetProcAddress(FHandle, 'epgov_WeightInfo_Upload');
    FAuthProc:= GetProcAddress(FHandle, 'epgov_WeightInfo_Auth');
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeLibrary(FHandle);
end;

end.
