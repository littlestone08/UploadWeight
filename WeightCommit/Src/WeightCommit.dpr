program WeightCommit;

uses
  Vcl.Forms,
  u_WeightCommit_Main in 'u_WeightCommit_Main.pas' {frmWeightCommit},
  u_frame_MainfestNoVerify in 'u_frame_MainfestNoVerify.pas' {frameMainfrestNoVerify: TFrame},
  u_FrameUart in 'u_FrameUart.pas' {frameUart: TFrame},
  u_Frame_WeightInfo in 'u_Frame_WeightInfo.pas' {frameWeightInfo: TFrame},
  u_DMWeight in 'u_DMWeight.pas' {dmWeight: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmWeightCommit, frmWeightCommit);
  Application.CreateForm(TdmWeight, dmWeight);
  Application.Run;
end.
