unit u_FrameMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, u_FrameUart, System.Actions,
  Vcl.ActnList, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ToolWin, Data.DB, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, u_Frame_WeightInfo, u_frame_MainfestVerify, u_WeightComm,
  u_FrameWeightNum;

type
  TframeMain = class(TframeUart)
    pnlBottom: TPanel;
    pnlDB: TPanel;
    pnlRight: TPanel;
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
    Splitter3: TSplitter;
    frameWeightNum1: TframeWeightNum;
    pnlWeightNum: TPanel;
    pnlWeightType: TPanel;
    rbGross: TRadioButton;
    rbTare: TRadioButton;
    actSelGrossWeight: TAction;
    btnSample: TButton;
    actSampleWeight: TAction;
    actSelTareWeight: TAction;
    pnlPlaceHolder: TPanel;
    actDoCommit: TAction;
    procedure actDoAuthExecute(Sender: TObject);
    procedure actDBData22UIExecute(Sender: TObject);
    procedure actDoAuthUpdate(Sender: TObject);
    procedure dbgrdWeightInfoDblClick(Sender: TObject);
    procedure actSelGrossWeightExecute(Sender: TObject);
    procedure actSampleWeightUpdate(Sender: TObject);
    procedure actSampleWeightExecute(Sender: TObject);
    procedure actDoCommitExecute(Sender: TObject);
    procedure frameMainfrestVerify1edtMainfestNoChange(Sender: TObject);
  private
    { Private declarations }
    Procedure HandleLogProc(const Str: String);
    Procedure DoRecvWeightData(Weight: Single);
    Procedure DoCheckSelWeight(Sender: TObject);
    Procedure DoMainrestChanged;
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
  u_DMWeight, u_SolidWastte_Upload, u_Log, PlumUtils, AnsiStrings;

procedure TframeMain.actDBData22UIExecute(Sender: TObject);
var
  AInfo: TWeightInfo;
begin
  inherited;
  if dmWeight.DB_2Record(AInfo) then
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

procedure TframeMain.actDoCommitExecute(Sender: TObject);
var
  MainfestNo: String;
  BridgeNoEmpty: Boolean;
  NewBridgeNo: String;
  WeightInfo: TWeightInfo;
  WeightUpdated: Integer;
  CommitRet: Integer;
begin
  inherited;
  WeightUpdated:= 0;
  MainfestNo:= frameMainfrestVerify1.edtMainfestNo.Text;
  NewBridgeNo:= frameWeightInfo1.edtWeighBridgeNo.Text;

  dmWeight.FDQuery1.DisableControls;
  try
    if dmWeight.DB_Mainfest2Record(MainfestNo, WeightInfo) then
    begin
      BridgeNoEmpty:= WeightInfo.Mesure.WeightBridge = '';
      if BridgeNoEmpty and (NewBridgeNo <> '') then
      begin
        dmWeight.DB_UpdateBridgeNo(MainfestNo, NewBridgeNo);
      end;
      if rbGross.Checked and (Not WeightInfo.Mesure.Gross.Valid) then
      begin
        Inc(WeightUpdated);
        dmWeight.DB_SaveGross(MainfestNo,
            StrToFloat(frameWeightInfo1.edtGrossWeight.Text),
            _StrToDateTime(frameWeightInfo1.edtGrossWeightTime.Text))
      end
      else
      if rbTare.Checked and (Not WeightInfo.Mesure.Tare.Valid) then
      begin
        Inc(WeightUpdated);
        dmWeight.DB_SaveTare(MainfestNo,
            StrToFloat(frameWeightInfo1.edtTareWeight.Text),
            _StrToDateTime(frameWeightInfo1.edtTareWeightTime.Text))
      end;

      dmWeight.FDQuery1.Refresh;
      dmWeight.FDQuery1.Locate(CONST_FIELDNAME_MAINFESTNO, MainfestNo);
      dmWeight.DB_Mainfest2Record(MainfestNo, WeightInfo);

      Log(Format('更新了%s 的 %d 条重量数据', [MainfestNo, WeightUpdated]));
      DoCheckSelWeight(Nil);
      if (WeightUpdated = 1) and WeightInfo.Mesure.Gross.Valid and WeightInfo.Mesure.Tare.Valid then
      begin
        Log('数据采集完成，准备提交');
        CommitRet:= u_SolidWastte_Upload.SolidWaste_Commit(WeightInfo);
        if CommitRet = 1 then
        begin
          u_log.Log('提交成功，更新提交标志....');
          dmWeight.DB_SetMainfestCommited(WeightInfo.Auth.MainfestNo);
          u_log.Log('标志提交完成');
        end
        else
        begin
          u_log.Log('提交失败，请重新提交。');
        end;
      end;
    end;
  finally
    dmWeight.FDQuery1.EnableControls;
  end;
end;

procedure TframeMain.actSampleWeightExecute(Sender: TObject);
begin
  inherited;

  if rbGross.Checked then
  begin
    frameWeightInfo1.edtGrossWeight.Text:= frameWeightNum1.lblNum.Caption;
    frameWeightInfo1.edtGrossWeightTime.Text:= frameWeightNum1.lbWeightTime.Caption;
  end
  else if rbTare.Checked then
  begin
    frameWeightInfo1.edtTareWeight.Text:= frameWeightNum1.lblNum.Caption;
    frameWeightInfo1.edtTareWeightTime.Text:= frameWeightNum1.lbWeightTime.Caption;
  end;
end;

procedure TframeMain.actSampleWeightUpdate(Sender: TObject);
var
  Selected: Integer;
  WeightInfo: TWeightInfo;
begin
  inherited;
  //毛重和皮重只且只有一项是选中的才可以进行操作
  Selected:= 0;
  if rbGross.Checked then
    Inc(Selected);
  if rbTare.Checked then
    Inc(Selected);
  if Sender = actSampleWeight then
  begin
    TAction(Sender).Enabled:= (Selected = 1) and (rbGross.Enabled or rbTare.Enabled) and
      dmWeight.DB_Mainfest2Record(frameMainfrestVerify1.edtMainfestNo.Text, WeightInfo) and
      Not frameWeightNum1.WeightOutofdated;
  end;
end;

procedure TframeMain.actSelGrossWeightExecute(Sender: TObject);
begin
  inherited;
  DoCheckSelWeight(Sender);
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

  pnlWeightNum.BevelOuter:= bvNone;
  //pnlWeightType.BevelOuter:= bvNone;
  pnlPlaceHolder.BevelOuter:= bvNone;

  //禁止重量手动输入
  frameWeightInfo1.grpWeightData.Enabled:= False;
  lOG('载入完成');
end;

procedure TframeMain.dbgrdWeightInfoDblClick(Sender: TObject);
begin
  inherited;
  actDBData22UIExecute(Nil);
end;

procedure TframeMain.DoCheckSelWeight(Sender: TObject);
var
  DBWeightInfo: TWeightInfo;
begin
  //检测到的重量是什么类型的检查。
  //1 如果数据库中联单不存在，则两者都可以选
  //2 如果数据库联单存在，　则只能选择数据库中无效的选项，
  //      如果有效项只有一项，则自动选中这一项。

  if dmWeight.DB_Mainfest2Record(frameMainfrestVerify1.edtMainfestNo.Text, DBWeightInfo) then
  begin
    frameWeightInfo1.WeightMeasure:= DBWeightInfo.Mesure;

    rbGross.Enabled:= Not DBWeightInfo.Mesure.Gross.Valid;
    rbTare.Enabled := Not DBWeightInfo.Mesure.Tare.Valid;

    if rbGross.Enabled <> rbTare.Enabled then
    begin
      rbGross.Checked:= rbGross.Enabled;
      rbTare.Checked:= rbTare.Enabled;
    end;
  end
  else
  begin
    frameWeightInfo1.UIClear;
    rbGross.Enabled:= True;
    rbGross.Enabled:= True;
  end;
end;

procedure TframeMain.DoMainrestChanged;
begin
  {TODO: 根据联单有无及情况更新界面数据}
  DoCheckSelWeight(Nil);
end;

procedure TframeMain.DoRecvWeightData(Weight: Single);
begin
  frameWeightNum1.SampleWeight:= Weight;
end;

procedure TframeMain.frameMainfrestVerify1edtMainfestNoChange(Sender: TObject);
begin
  inherited;
  DoMainrestChanged();
end;

procedure TframeMain.HandleLogProc(const Str: String);
begin
  mmoLog.Lines.Add(Str);
end;

procedure TframeMain.ProcessBuffer(var Buf: AnsiString);
  function SearchFrameHead: Boolean;
  const
    const_head_str: Array[0..0] of AnsiString = (
      #$02
    );
  var
    i: Integer;
    newLen: Integer;
  var
    Head_Str: AnsiString;
  begin
    Result:= False;
    Head_Str:= const_head_str[0];

    i:=  Pos(Head_Str, Buf);
    if i > 0 then
    begin
      newLen:= Length(Buf) - i + 1;
      System.Move((PAnsiChar(Buf) + i - 1)^, PAnsiChar(Buf)^, newLen);
      SetLength(Buf, newLen);
      Result:= True;
    end
    else
    begin
      Buf:= '';
    end;
  end;

  function GetVerify(Ptr: PByte): Byte;
  var
    i: Integer;
  begin
    Result:= 0;
    for i := 0 to 7 do
    begin
      Result:= Result xor Ptr^;
      Inc(Ptr);
    end;
  end;
  Procedure ProcessData;
  var
    NumStr: AnsiString;
    SignStr: AnsiChar;
    DotPosStr: AnsiChar;

    Num: Single;
    DotPos: Integer;
  begin
    SetLength(NumStr, 6);
    SignStr:= Buf[2];
    Move(Buf[3], NumStr[1], 6);
    DotPosStr:= Buf[9];
    try
      if SignStr in [#$2B, #$2D] then
      begin
        Num:= StrToInt(String(NumStr));
        DotPos:= StrToInt(String(DotPosStr));
        While(DotPos > 0) do
        begin
          Num:= Num / 10;
          Dec(DotPos);
        end;
        if SignStr = #$2D then
          Num:= -Num;
        DoRecvWeightData(Num);
      end
      else
      begin
        raise Exception.Create('符号位不能识别');
      end;
    except
      on E: Exception do
      begin
        With MultiLineLog do
        begin
          AddLine('数据解析失败: ');
          AddLine(Format('%s: %s', [E.ClassName, E.Message]));
          AddLine(Format('数据: %s', [Buf2Hex(Buf)]));
        end;
      end;
    end;
  end;
var
  FrameLen: Byte;
begin
  inherited;
  //共12字节
  //起始　符号字节　N6 N5 N4 N3 N2 N1 DOTPOS  XOR     结束
  // 02   2B        30 30 32 30 30 30  32    31 42   03
  // 校验方法：前九个字节进行XOR，得到一字节，转换成2字节ASC码
  FrameLen:= 12;
  while (Length(Buf) >= 12) and (SearchFrameHead()) do
  begin
    if Length(Buf) >= FrameLen then
    begin
      if FrameLen < 50{最长帧长不超过50} then
      begin
        if Length(Buf) >= FrameLen {连头尾算在内的总长度字节} then
        begin
          if (GetVerify(@Buf[2]) = StrToIntDef('$' + String( Buf[10] + Buf[11]), $00)){ or True{不校验} and
            (Buf[12] = #$03)  //帧尾正确
          then
          begin
            ProcessData;
            Buf:= RightStr(Buf, Length(buf) - FrameLen);
          end
          else
          begin
            Buf:= RightStr(Buf, Length(buf) - 1);
          end;
        end
        else
        begin
          break;  ///等数据
        end;
      end
      else
      begin
        Buf:= RightStr(Buf, Length(buf) - 1);
      end;
    end
    else
    begin
      break;  ///等数据
    end;
  end;
end;


end.
