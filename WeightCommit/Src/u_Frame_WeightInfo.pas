unit u_Frame_WeightInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, u_WeightComm,
  Vcl.ExtCtrls, Math;

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
    Label1: TLabel;
    edtPureWeight: TEdit;
    Label7: TLabel;
    edtPureWeightTime: TEdit;
    procedure edtGrossWeightChange(Sender: TObject);
    procedure edtTareWeightChange(Sender: TObject);
  private
    FData: TWeightMeasure;
    Procedure DoTryUpdatePureWeight();
    function GetWeightMeasure: TWeightMeasure;
    procedure SetWeightMeasure(const Value: TWeightMeasure);
    Procedure UI2Data;
    Procedure Data2UI;
    { Private declarations }
  public
    { Public declarations }
    Constructor Create(AOwner: TComponent); Override;
    Procedure UpdateUIGrossWeight(Value: Single);
    Procedure UpdateUITareWeight(Value: Single);
    Procedure UIClear;
    Property WeightMeasure: TWeightMeasure read GetWeightMeasure write SetWeightMeasure;

  end;

  function _StrToDateTime(ADateTimeStr: String): TDateTime;
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



constructor TframeWeightInfo.Create(AOwner: TComponent);
begin
  inherited;
  Data2UI;
end;

procedure TframeWeightInfo.Data2UI;
begin
  edtWeighBridgeNo.Text:= FData.WeightBridge;
  edtNote.Text:= FData.Note;

  if FData.Gross.Valid then
  begin
    edtGrossWeight.Text:= Format('%.2f', [FData.Gross.Wegiht]);
    edtGrossWeightTime.Text:= FormatDateTime('YYYY-MM-DD HH:NN:SS', FData.Gross.WegihtTime);
  end
  else
  begin
    edtGrossWeight.Text:= '';
    edtGrossWeightTime.Text:= '';
  end;

  if FData.Tare.Valid then
  begin
    edtTareWeight.Text:= Format('%.2f', [FData.Tare.Wegiht]);
    edtTareWeightTime.Text:= FormatDateTime('YYYY-MM-DD HH:NN:SS', FData.Tare.WegihtTime);
  end
  else
  begin
    edtTareWeight.Text:= '';
    edtTareWeightTime.Text:= '';
  end;
end;

procedure TframeWeightInfo.DoTryUpdatePureWeight;

begin

 TThread.CreateAnonymousThread(
    procedure ()
    begin
      sleep(100);
      TThread.Synchronize(Nil,
        procedure ()
        var
          CurrWeight: TWeightMeasure;
        begin
          CurrWeight:= GetWeightMeasure;
          if CurrWeight.Gross.Valid and CurrWeight.Tare.Valid then
          begin
            edtPureWeight.Text:= Format('%.2f', [CurrWeight.Gross.Wegiht - CurrWeight.Tare.Wegiht]);
            edtPureWeightTime.Text:= FormatDateTime('YYYY-MM-DD HH:NN:SS',
              Max(CurrWeight.Gross.WegihtTime, CurrWeight.Tare.WegihtTime));
          end
          else
          begin
            edtPureWeight.Text:= '';
            edtPureWeightTime.Text:= '';
          end;
        end
      )
    end).start;
end;

procedure TframeWeightInfo.edtGrossWeightChange(Sender: TObject);
begin
  DoTryUpdatePureWeight();
end;

procedure TframeWeightInfo.edtTareWeightChange(Sender: TObject);
begin
  DoTryUpdatePureWeight();
end;

function TframeWeightInfo.GetWeightMeasure: TWeightMeasure;
begin
  UI2Data;
  Result:= FData;
end;

procedure TframeWeightInfo.SetWeightMeasure(const Value: TWeightMeasure);
begin
  FData:= Value;
  Data2UI;
end;

procedure TframeWeightInfo.UI2Data;
begin
  FData.WeightBridge:= edtWeighBridgeNo.Text;
  FData.Note:= edtNote.Text;

  FData.Gross.Valid:= (Trim(edtGrossWeight.Text) <> '') and (Trim(edtGrossWeightTime.Text) <> '');
  if FData.Gross.Valid then
  begin
    FData.Gross.Wegiht:= StrToFloatDef(edtGrossWeight.Text, 0);
    FData.Gross.WegihtTime:= _StrToDateTime(edtGrossWeightTime.Text);
  end;

  FData.Tare.Valid:= (Trim(edtTareWeight.Text) <> '') and (Trim(edtTareWeightTime.Text) <> '');
  if FData.Tare.Valid then
  begin
    FData.Tare.Wegiht:= StrToFloatDef(edtTareWeight.Text, 0);
    FData.Tare.WegihtTime:= _StrToDateTime(edtGrossWeightTime.Text);
  end;

end;

procedure TframeWeightInfo.UIClear;
begin
  edtWeighBridgeNo.Text:= '';
  edtNote.Text:= '';

  if FData.Gross.Valid then
  begin
    edtGrossWeight.Text:= '';
    edtGrossWeightTime.Text:= '';
  end
  else
  begin
    edtGrossWeight.Text:= '';
    edtGrossWeightTime.Text:= '';
  end;

  if FData.Tare.Valid then
  begin
    edtTareWeight.Text:= '';
    edtTareWeightTime.Text:= '';
  end
  else
  begin
    edtTareWeight.Text:= '';
    edtTareWeightTime.Text:= '';
  end;
end;

procedure TframeWeightInfo.UpdateUIGrossWeight(Value: Single);
begin
  edtGrossWeight.Text:= Format('%.2f', [Value]);
  edtGrossWeightTime.Text:= FormatDateTime('YYYY-MM-DD HH:NN:SS', Now());
end;

procedure TframeWeightInfo.UpdateUITareWeight(Value: Single);
begin
  edtTareWeight.Text:= Format('%.2f', [Value]);
  edtTareWeightTime.Text:= FormatDateTime('YYYY-MM-DD HH:NN:SS', Now());
end;

initialization


end.
