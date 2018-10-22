unit u_Driver_Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type

  TStrInfo = Record
    Buffer: Pointer;
    nSize: Byte;
  End;
  PStrInfo = ^TStrInfo;

  TWeightInfo = Record
    WeighingTime: TSystemTime;
    WeightBridgeNo: Byte;
    Weight: Double;
  End;
  PWeightInfo = ^TWeightInfo;

  Tepgov_WeightInfoUpload = Procedure (
    Token     : PStrInfo;
    ManifestNo: PStrInfo;

    ComputerID: PStrInfo;
    TranType  : Byte;
    CredentialNo: PStrInfo;
    Commodity:PStrInfo;

    PlateNumber: PStrInfo;
    CompanyDelivery: PStrInfo;
    CompanyReceipt: PStrInfo;

    GrossWeight: PWeightInfo;
    TareWeight: PWeightInfo
  ); stdcall;

  TForm1 = class(TForm)
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FHandle: THandle;
    FProc: Tepgov_WeightInfoUpload;
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

    ComputerID: TStrInfo;
    TranType  : Byte;
    CredentialNo: TStrInfo;
    Commodity:TStrInfo;

    PlateNumber: TStrInfo;
    CompanyDelivery: TStrInfo;
    CompanyReceipt: TStrInfo;

    GrossWeight: TWeightInfo;
    TareWeight: TWeightInfo;
var
    s_Token     : AnsiString;
    s_ManifestNo: AnsiString;

    s_ComputerID: AnsiString;

    s_CredentialNo: AnsiString;
    s_Commodity:AnsiString;

    s_PlateNumber: AnsiString;
    s_CompanyDelivery: AnsiString;
    s_CompanyReceipt: AnsiString;

begin

  s_Token:= '57da9a9249ad64146273edea3010118077e3';
  With Token do
  begin
    Buffer:= PAnsiChar(s_Token);
    nSize:= Length(s_Token);
  end;

  s_ManifestNo:= '350201201709080001';
  With ManifestNo  do
  begin
    Buffer:= PAnsiChar(s_ManifestNo);
    nSize:= Length(s_ManifestNo);
  end;

  s_ComputerID:= '¼ÆËã»ú' + IntToStr(g_ComputerID);
  With ComputerID do
  begin
    Buffer:= PAnsiChar(s_ComputerID);
    nSize:= Length(s_ComputerID);
  end;

  s_CredentialNo:= 'Ìá»õµ¥'+ IntToStr(g_ComputerID * 2);
  With CredentialNo do
  begin
    Buffer:= PAnsiChar(s_CredentialNo);
    nSize:= Length(s_CredentialNo);
  end;

  s_Commodity:= '·ÏÂ¯Ôü';
  With Commodity do
  begin
    Buffer:= PAnsiChar(s_Commodity);
    nSize:= Length(s_Commodity);
  end;
  s_PlateNumber:= '¼½A234563';
  With PlateNumber do
  begin
    Buffer:= PAnsiChar(s_PlateNumber);
    nSize:= Length(s_PlateNumber);
  end;

  s_CompanyDelivery:= 'ºªµ¦ÌìÌú';
  With CompanyDelivery do
  begin
    Buffer:= PAnsiChar(s_CompanyDelivery);
    nSize:= Length(s_CompanyDelivery);
  end;

  s_CompanyReceipt:= 'ºªµ¦²âÊÔ';
  With CompanyReceipt do
  begin
    Buffer:= PAnsiChar(s_CompanyReceipt);
    nSize:= Length(s_CompanyReceipt);
  end;

  With GrossWeight do
  begin
    DateTimeToSystemTime(Now() - 0.01, WeighingTime);
    WeightBridgeNo:= 1;
    Weight:= 200;
  end;

  With TareWeight do
  begin
    DateTimeToSystemTime(Now(), WeighingTime);
    WeightBridgeNo:= 1;
    Weight:= 100;
  end;
  FProc(@Token, @ManifestNo, @ComputerID, 1, @CredentialNo, @Commodity, @PlateNumber, @CompanyDelivery, @CompanyReceipt, @GrossWeight, @TareWeight);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FHandle:= LoadLibrary('gov_WeightInfoUpload.dll');
  if FHandle <> 0 then
  begin
    FProc:= GetProcAddress(FHandle, 'epgov_WeightInfoUpload');
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeLibrary(FHandle);
end;

end.
