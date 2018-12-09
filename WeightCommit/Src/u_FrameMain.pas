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
    procedure actDoAuthExecute(Sender: TObject);
    procedure actDBData22UIExecute(Sender: TObject);
    procedure actDoAuthUpdate(Sender: TObject);
    procedure dbgrdWeightInfoDblClick(Sender: TObject);
  private
    { Private declarations }
    Procedure HandleLogProc(const Str: String);
    Procedure DoRecvWeightData(Weight: Single);
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
  u_DMWeight, u_SolidWastte_Upload, u_Log, PlumUtils, StrUtils;

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
    u_log.Log('��֤�ɹ���׼�����浽���ݿ�....');
    dmWeight.DB_InsertAuthInfo(AuthInfo);
    u_log.Log('���ݿⱣ����ɡ�');
  end
  else
  begin
    u_log.Log('��֤ʧ�ܣ���������֤��');
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
    edtPlateNo.Text:= '��AAAAAA';
    edtDriverName.Text:= '����';
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

procedure TframeMain.DoRecvWeightData(Weight: Single);
begin
  frameWeightNum1.SampleWeight:= Weight;
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
        Num:= StrToInt(NumStr);
        DotPos:= StrToInt(DotPosStr);
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
        raise Exception.Create('����λ����ʶ��');
      end;
    except
      on E: Exception do
      begin
        With MultiLineLog do
        begin
          AddLine('���ݽ���ʧ��: ');
          AddLine(Format('%s: %s', [E.ClassName, E.Message]));
          AddLine(Format('����: %s', [Buf2Hex(Buf)]));
        end;
      end;
    end;
  end;
var
  FrameLen: Byte;
begin
  inherited;
  //��12�ֽ�
  //��ʼ�������ֽڡ�N6 N5 N4 N3 N2 N1 DOTPOS  XOR     ����
  // 02   2B        30 30 32 30 30 30  32    31 42   03
  // У�鷽����ǰ�Ÿ��ֽڽ���XOR���õ�һ�ֽڣ�ת����2�ֽ�ASC��
  FrameLen:= 12;
  while (Length(Buf) >= 12) and (SearchFrameHead()) do
  begin
    if Length(Buf) >= FrameLen then
    begin
      if FrameLen < 50{�֡��������50} then
      begin
        if Length(Buf) >= FrameLen {��ͷβ�����ڵ��ܳ����ֽ�} then
        begin
          if (GetVerify(@Buf[2]) = StrToIntDef('$' + Buf[10] + Buf[11], $00)){ or True{��У��} and
            (Buf[12] = #$03)  //֡β��ȷ
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
          break;  ///������
        end;
      end
      else
      begin
        Buf:= RightStr(Buf, Length(buf) - 1);
      end;
    end
    else
    begin
      break;  ///������
    end;
  end;
end;


end.
