unit u_FrameMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Spin, CnClasses, CnRS232, ExtCtrls,
  Buttons, ToolWin, ImgList, ActnList, CnRS232Dialog, Actions,
  DB, Grids, DBGrids,
  u_Frame_WeightInfo, u_DMWeight, SolidWasteService,
  u_frame_MainfestVerify, u_WeightComm, u_FrameUart;

type

  TframeMain = class(TframeUart)
    pnlDB: TPanel;
    pnlMain: TPanel;
    pnlLog: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    pnlBottom: TPanel;
    pnlTop: TPanel;
    frameWeightInfo1: TframeWeightInfo;
    dbgrdWeightInfo: TDBGrid;
    frameMainfrestVerify1: TframeMainfrestVerify;
    Panel1: TPanel;
    actDoAuth: TAction;
    mmoLog: TMemo;
    actDBData22UI: TAction;
    procedure HandleReceiveDataProc(Sender: TObject; Buffer: Pointer;
      BufferLength: Word);
    procedure FormCreate(Sender: TObject);
    procedure actRefreshPort1Execute(Sender: TObject);
    procedure actSetupUartUpdate(Sender: TObject);
    procedure actSetupUartExecute(Sender: TObject);
    procedure actPortOpenCloseUpdate(Sender: TObject);
    procedure actPortOpenCloseExecute(Sender: TObject);
    procedure actDoAuthExecute(Sender: TObject);
    procedure actDoAuthUpdate(Sender: TObject);
    procedure dbgrdWeightInfoDblClick(Sender: TObject);
    procedure actDBData22UIExecute(Sender: TObject);
  Private
    FRS232: TCnRS232;
    FRS232Dialog: TCnRS232Dialog;
    FBuff: AnsiString;
    Procedure UpdateStatusText;
  private
    { Private declarations }
      Procedure HandleLogProc(const Str: String);
  public
    { Public declarations }
    Constructor Create(AOwner: TComponent);Override;
    Procedure ProcessBuffer(var Buf: AnsiString); Virtual; Abstract;
    Property RS232: TCnRS232 Read FRS232;
  end;

implementation
uses
  u_Log, u_SolidWastte_Upload, StrUtils, Registry, TypInfo;

{$R *.dfm}
const
  SERIAL_PORT_SECT = 'SerialPort';

procedure TframeMain.actDBData22UIExecute(Sender: TObject);
var
  AInfo: TWeightInfo;
begin
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
  if Sender is TAction then
  begin
    TAction(Sender).Enabled:= (frameMainfrestVerify1.edtMainfestNo.Text <> '') and
      (Not dmWeight.DB_MainfestExist(frameMainfrestVerify1.edtMainfestNo.Text));
  end;
end;

procedure TframeMain.actPortOpenCloseExecute(Sender: TObject);
begin
//  self
  if self.FRS232.Connected then
  begin
    FRS232.StopComm
  end
  else
  begin
    FRS232.CommName:= self.cbbComPort.Text;

    FRS232.WriteToIni(ChangeFileExt(ParamStr(0), '.ini'), SERIAL_PORT_SECT);
    try
      FRS232.StartComm;

    except
      on E: Exception do
        ShowMessage(Format('串口%s无法打开:'#10#13#10#13 +
          '%s: %s', [FRS232.CommName, E.ClassName, E.Message]));
    end;
  end;
  UpdateStatusText;
end;


procedure TframeMain.actPortOpenCloseUpdate(Sender: TObject);
begin
  actPortOpenClose.Enabled:= (FRS232 <> Nil) and (self.cbbComPort.Items.Count > 0);
  if (FRS232 <> Nil) then
  begin
    if FRS232.Connected then
      actPortOpenClose.Caption:= '关闭'
    else
      actPortOpenClose.Caption:= '打开';
  end
  else
  begin
    actPortOpenClose.Caption:= '无串口'
  end;
end;

procedure TframeMain.actRefreshPort1Execute(Sender: TObject);
var
  Names, Values: TStrings;
  i: Integer;
var
  Reg: TRegistry;
begin
  Reg:= TRegistry.Create;
  Names:= TStringList.Create;
  Values:= TStringList.Create;
  try
    Reg.RootKey:= HKEY_LOCAL_MACHINE;
    Reg.OpenKey('HARDWARE\DEVICEMAP\SERIALCOMM',  False);
    Reg.GetValueNames(Names);
    for i := 0 to Names.Count - 1 do
      Values.Add(Reg.ReadString(Names[i]));
    cbbComPort.Items.Assign(values);

    cbbComPort.Enabled:= cbbComPort.Items.Count > 0;

    if cbbComPort.Items.Count > 0 then
      cbbComPort.ItemIndex:= 0
    else
      cbbComPort.Text:= '无串口';

  finally
    Values.Free;
    Names.Free;
    Reg.Free;
  end;
end;



procedure TframeMain.actSetupUartExecute(Sender: TObject);
begin
  FRS232Dialog.CommName:= FRS232.CommName;
  FRS232Dialog.CommConfig:= self.FRS232.CommConfig;
  if FRS232Dialog.Execute then
  begin
    FRS232.CommConfig:= FRS232Dialog.CommConfig;
  end;
end;

procedure TframeMain.actSetupUartUpdate(Sender: TObject);
begin
  actSetupUart.Enabled:= Not self.FRS232.Connected
    and (FRS232 <> Nil)
    and (self.cbbComPort.Items.Count > 0);
end;



constructor TframeMain.Create(AOwner: TComponent);
begin
  inherited;
  u_Log.g_dele_Log_Proc:= HandleLogProc;
  FRS232:= TCnRS232.Create(Self);
  if FileExists(ChangeFileExt(ParamStr(0), '.ini')) then
    FRS232.ReadFromIni(ChangeFileExt(ParamStr(0), '.ini'), SERIAL_PORT_SECT);
  FRS232Dialog:= TCnRS232Dialog.Create(Self);
  FRS232.OnReceiveData:= HandleReceiveDataProc;
  self.actRefreshPort1Execute(Nil);
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
  actDBData22UI.Execute;
end;

procedure TframeMain.FormCreate(Sender: TObject);
begin
  actRefreshPort1Execute(nil);
end;



procedure TframeMain.HandleLogProc(const Str: String);
begin
  mmoLog.Lines.Add(Str);
end;

procedure TframeMain.HandleReceiveDataProc(Sender: TObject; Buffer: Pointer;
  BufferLength: Word);
var
  tmp: AnsiString;
begin
  SetLength(tmp, BufferLength);
  Move(Buffer^, PAnsiChar(tmp)^, BufferLength);
  FBuff:= FBuff + tmp;
  ProcessBuffer(FBuff);
end;


procedure TframeMain.UpdateStatusText;
var
  LStatusStr: String;
begin
  if self.FRS232.Connected then
  begin
    LStatusStr:= self.FRS232.CommName +'打开, ' +
      IntToStr(self.FRS232.CommConfig.BaudRate)+', ';

    if Not FRS232.CommConfig.ParityCheck then
      LStatusStr:= LStatusStr + 'N, '
    else
      LStatusStr:= LStatusStr + GetEnumName(TypeInfo(TParity), Ord(self.FRS232.CommConfig.Parity)) + ',';

    LStatusStr:= LStatusStr + GetEnumName(TypeInfo(TByteSize), Ord(self.FRS232.CommConfig.ByteSize)) + ',';
    LStatusStr:= LStatusStr + GetEnumName(TypeInfo(TStopBits), Ord(self.FRS232.CommConfig.StopBits));
    self.StatusBar.Panels[0].Text:= LStatusStr;
  end
  else
  begin
    self.StatusBar.Panels[0].Text:= FRS232.CommName + '关闭';
  end;
end;

end.
