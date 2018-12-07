program WeightCommit;

uses
  Vcl.Forms,
  u_WeightCommit_Main in 'u_WeightCommit_Main.pas' {frmWeightCommit},
  u_frame_MainfestVerify in 'u_frame_MainfestVerify.pas' {frameMainfrestVerify: TFrame},
  u_FrameUart in 'u_FrameUart.pas' {frameUart: TFrame},
  u_Frame_WeightInfo in 'u_Frame_WeightInfo.pas' {frameWeightInfo: TFrame},
  u_DMWeight in 'u_DMWeight.pas' {dmWeight: TDataModule},
  SolidWasteService in 'SolidWasteService.pas',
  u_WeightComm in 'u_WeightComm.pas',
  u_SolidWastte_Upload in 'u_SolidWastte_Upload.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmWeight, dmWeight);
  Application.CreateForm(TfrmWeightCommit, frmWeightCommit);
  Application.Run;
end.
