program TestService;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  SolidWasteService in 'SolidWasteService.pas',
  u_SolidWastte_Upload in 'u_SolidWastte_Upload.pas',
  PlumLogFile in 'D:\WORK170908\upload\Src\PlumLogFile.pas',
  u_Log in 'D:\WORK170908\upload\Src\u_Log.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
