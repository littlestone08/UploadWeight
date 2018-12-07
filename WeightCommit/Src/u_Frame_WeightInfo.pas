unit u_Frame_WeightInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, u_WeightComm,
  Vcl.ExtCtrls;

type
  TframeWeightInfo = class(TFrame)
    grpWeightInfo: TGroupBox;
    lbl1: TLabel;
    Label4: TLabel;
    edtWeighBridgeNo: TEdit;
    grpWeightData: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    edtGrossWeight: TEdit;
    edtGrossWeightTime: TEdit;
    btnCommit: TButton;
    Label5: TLabel;
    Label6: TLabel;
    edtTareWeight: TEdit;
    edtTareWeightTime: TEdit;
    grpNote: TGroupBox;
    edtNote: TMemo;
  private
    function GetWeightMeasure: TWeightMeasure;
    procedure SetWeightMeasure(const Value: TWeightMeasure);
    { Private declarations }
  public
    { Public declarations }
    Property WeightMeasure: TWeightMeasure read GetWeightMeasure write SetWeightMeasure;
  end;

implementation
uses
  CnCommon;

{$R *.dfm}

{ TframeWeightInfo }
function _StrToDateTime(ADateTimeStr: String): TDateTime;
var
  FSetting : TFormatSettings;

begin
  FSetting := TFormatSettings.Create(LOCALE_USER_DEFAULT);
  FSetting.ShortDateFormat:='yyyy-MM-dd';
  FSetting.DateSeparator:='-';
  //FSetting.TimeSeparator:=':';  //加入FSetting.TimeSeparator:=':';后，毫秒部分读取失败,这个BUG还有吗?
  FSetting.LongTimeFormat:='hh:mm:ss.zzz';
  Result:= StrToDateTime(ADateTimeStr, FSetting);
end;



function TframeWeightInfo.GetWeightMeasure: TWeightMeasure;
begin
  Result.WeightBridge:= edtWeighBridgeNo.Text;
  Result.Note:= edtNote.Text;

  Result.Gross.Wegiht_KG:= StrToFloatDef(edtGrossWeight.Text, 0);
  Result.Gross.WegihtTime:= _StrToDateTime(edtGrossWeightTime.Text);
  Result.Gross.Valid:= Trim(edtGrossWeight.Text) <> '';

  Result.Tare.Wegiht_KG:= StrToFloatDef(edtTareWeight.Text, 0);
  Result.Tare.WegihtTime:= _StrToDateTime(edtGrossWeightTime.Text);
  Result.Tare.Valid:= Trim(edtTareWeight.Text) <> '';
end;

procedure TframeWeightInfo.SetWeightMeasure(const Value: TWeightMeasure);
begin
  edtWeighBridgeNo.Text:= Value.WeightBridge;
  edtNote.Text:= Value.Note;

  if Value.Gross.Valid then
  begin
    edtGrossWeight.Text:= Format('.2f', [Value.Gross.Wegiht_KG]);
    edtGrossWeightTime.Text:= FormatDateTime('', Value.Gross.WegihtTime);
  end
  else
  begin
    edtGrossWeight.Text:= '';
    edtGrossWeightTime.Text:= '';
  end;

  if Value.Tare.Valid then
  begin
    edtTareWeight.Text:= Format('.2f', [Value.Tare.Wegiht_KG]);
    edtTareWeightTime.Text:= FormatDateTime('', Value.Tare.WegihtTime);
  end
  else
  begin
    edtTareWeight.Text:= '';
    edtTareWeightTime.Text:= '';
  end;
end;

initialization


end.
