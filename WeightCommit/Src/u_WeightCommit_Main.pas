unit u_WeightCommit_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, u_FrameUart, u_frame_MainfestVerify;

type
  TfrmWeightCommit = class(TForm)
    frameUart1: TframeUart;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWeightCommit: TfrmWeightCommit;

implementation

{$R *.dfm}

end.
