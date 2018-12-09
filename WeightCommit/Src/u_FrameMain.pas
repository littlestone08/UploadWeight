unit u_FrameMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, u_FrameUart, System.Actions,
  Vcl.ActnList, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ToolWin, Data.DB, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, u_Frame_WeightInfo, u_frame_MainfestVerify, u_WeightComm;

type
  TframeMain = class(TframeUart)
    pnlBottom: TPanel;
    pnlDB: TPanel;
    pnlLog: TPanel;
    mmoLog: TMemo;
    pnlMain: TPanel;
    Panel1: TPanel;
    frameMainfrestVerify1: TframeMainfrestVerify;
    frameWeightInfo1: TframeWeightInfo;
    pnlTop: TPanel;
    dbgrdWeightInfo: TDBGrid;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    actDoAuth: TAction;
    procedure actDoAuthExecute(Sender: TObject);
    procedure actDBData22UIExecute(Sender: TObject);
    procedure actDoAuthUpdate(Sender: TObject);
    procedure dbgrdWeightInfoDblClick(Sender: TObject);
  private
    { Private declarations }
    Procedure HandleLogProc(const Str: String);
  public
    { Public declarations }
    Constructor Create(AOwner: TComponent); Override;
    Procedure ProcessBuffer(var Buf: AnsiString); Override;
  end;

var
  frameMain: TframeMain;

implementation

{$R *.dfm}

uses
  u_DMWeight, u_SolidWastte_Upload, u_Log;

procedure TframeMain.actDBData22UIExecute(Sender: TObject);
var
  AInfo: TWeightInfo;
begin
  inherited;
  if dmWeight.DB_Curr2Record(AInfo) then
  begin
    self.frameMainfrestVerify1.WeightAuth:= AInfo.Auth;
    self.frameWeightInfo1.WeightMeasure:= AInfo.Mesure;
  end;
end;



procedure TframeMain.actDoAuthExecute(Sender: TObject);
var
  AuthInfo: TWeightAuth;
  Ret: Integer;
begin
  inherited;
  AuthInfo:= frameMainfrestVerify1.WeightAuth;
  Ret:= u_SolidWastte_Upload.SolidWaste_Auth(AuthInfo);
  if Ret = 1 then
  begin
    u_log.Log('认证成功，准备保存到数据库....');
    dmWeight.DB_InsertAuthInfo(AuthInfo);
    u_log.Log('数据库保存完成。');
  end
  else
  begin
    u_log.Log('认证失败，请重新认证。');
  end;
end;

procedure TframeMain.actDoAuthUpdate(Sender: TObject);
begin
  inherited;
  if Sender is TAction then
  begin
    TAction(Sender).Enabled:= (frameMainfrestVerify1.edtMainfestNo.Text <> '') and
      (Not dmWeight.DB_MainfestExist(frameMainfrestVerify1.edtMainfestNo.Text));
  end;
end;

constructor TframeMain.Create(AOwner: TComponent);
begin
  inherited;
  u_Log.g_dele_Log_Proc:= HandleLogProc;
  {$IFDEF FILL_TEST_DATA}
  With frameMainfrestVerify1 do
  begin
    edtMainfestNo.Text:= '350201201709080001';
    edtPlateNo.Text:= '沪AAAAAA';
    edtDriverName.Text:= '张三';
    edtDriverIDC.Text:= '320123456789012345';
  end;
  With frameWeightInfo1 do
  begin
    edtGrossWeight.Text:= '5000';
    edtGrossWeightTime.Text:= '2016-09-05 11:11:38';
    edtTareWeight.Text:= '4000';
    edtTareWeightTime.Text:= '2016-09-05 12:11:38';
    edtNote.Text:= 'rem';
    edtWeighBridgeNo.Text:= '02';
  end;
  {$ENDIF}
end;

procedure TframeMain.dbgrdWeightInfoDblClick(Sender: TObject);
begin
  inherited;
  actDBData22UIExecute(Nil);
end;

procedure TframeMain.HandleLogProc(const Str: String);
begin
  mmoLog.Lines.Add(Str);
end;

procedure TframeMain.ProcessBuffer(var Buf: AnsiString);
begin
  inherited;

end;

end.
