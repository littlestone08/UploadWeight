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
  Log(Format('·¢Éú[%s]Òì³£: %s', [E.ClassName, E.ToString]));
end;

end.
