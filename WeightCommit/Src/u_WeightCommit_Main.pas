unit u_WeightCommit_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, u_FrameUart, u_frame_MainfestVerify,
  Vcl.AppEvnts, u_FrameMain;

type
  TfrmWeightCommit = class(TForm)
    ApplicationEvents1: TApplicationEvents;
    frameMain1: TframeMain;
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure FormCreate(Sender: TObject);
    procedure frameMain1actDBData22UIExecute(Sender: TObject);
    procedure frameWeightInfo1btnCommitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWeightCommit: TfrmWeightCommit;

implementation
uses
  u_Log;


{$R *.dfm}

procedure TfrmWeightCommit.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
begin
  Log(Format('����[%s]�쳣: %s', [E.ClassName, E.ToString]));
end;

procedure TfrmWeightCommit.FormCreate(Sender: TObject);
begin
  self.DoubleBuffered:= True;
end;

procedure TfrmWeightCommit.frameMain1actDBData22UIExecute(Sender: TObject);
begin
  frameMain1.actDBData22UIExecute(Sender);

end;

procedure TfrmWeightCommit.frameWeightInfo1btnCommitClick(Sender: TObject);
begin
  frameMain1.actDoCommitExecute(Sender);

end;

end.
