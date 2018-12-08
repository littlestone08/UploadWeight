unit u_WeightCommit_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, u_FrameUart, u_frame_MainfestVerify,
  Vcl.AppEvnts;

type
  TfrmWeightCommit = class(TForm)
    frameUart1: TframeUart;
    ApplicationEvents1: TApplicationEvents;
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
