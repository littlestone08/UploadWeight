library gov_WeightInfoUpload;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,
  Classes,
  Windows,
  u_EPGOV_Upload in 'u_EPGOV_Upload.pas',
  u_EPGOV_Export in 'u_EPGOV_Export.pas',
  u_Log in 'u_Log.pas',
  PlumLogFile in 'PlumLogFile.pas';

{$R *.res}
procedure DllMain(reason: Integer);
begin
  if reason = DLL_PROCESS_DETACH then
  begin
    Log('DLL PROCESS DETACH');
  end
  else if reason = DLL_PROCESS_ATTACH then
  begin
    Log('DLL PROCESS PROCESS');
  end
  else if reason = DLL_THREAD_ATTACH then
    OutputDebugString('DLL THREAD ATTACH')
  else if reason = DLL_THREAD_DETACH then
    OutputDebugString('DLL THREAD DETACH')
  else
    OutputDebugString('DllMain');
end;

begin
  DllProc := DllMain;
  DllMain(DLL_PROCESS_ATTACH);
end.
