unit u_EPGOV_Upload;

interface
uses
  Classes, Windows, SysUtils;
type

  PStrInfo = PAnsiChar;

  TWeightInfo = Record
    WeighingTime: TSystemTime;
    Weight: Double;
  End;

  PWeightInfo = ^TWeightInfo;

  Procedure epgov_WeightInfo_Upload(
    Token     : PStrInfo;
    ManifestNo: PStrInfo;

    PlateNumber: PStrInfo;
    DriverName : PStrInfo;
    DriverIdentityCardNo: PStrInfo;

    WeightBridgeNo: PStrInfo;

    GrossWeight: PWeightInfo;
    TareWeight: PWeightInfo
  ); stdcall;

  Function epgov_WeightInfo_Auth(
    Token     : PStrInfo;
    ManifestNo: PStrInfo;

    PlateNumber: PStrInfo;
    DriverName : PStrInfo;
    DriverIdentityCardNo: PStrInfo
  ): Integer; stdcall;
implementation
uses
  u_Log;


  Procedure epgov_WeightInfo_Upload(
    Token     : PStrInfo;
    ManifestNo: PStrInfo;

    PlateNumber: PStrInfo;
    DriverName : PStrInfo;
    DriverIdentityCardNo: PStrInfo;

    WeightBridgeNo: PStrInfo;

    GrossWeight: PWeightInfo;
    TareWeight: PWeightInfo
  );
  var
    Info: string;
    s: string;
  begin
    With MultiLineLog do
    begin
      AddLine('--------------数据上传------------------');
      AddLine(Format('Token        : %s', [Token]));
      AddLine(Format('ManifestNo   : %s', [ManifestNo]));

      AddLine(Format('PlateNumber  : %s', [PlateNumber]));
      AddLine(Format('DriverName   : %s',   [DriverName]));
      AddLine(Format('DriverIdentityCardNo: %s',   [DriverIdentityCardNo]));


      AddLine(Format('WeightBridgeNo    : %s', [WeightBridgeNo]));




      With GrossWeight^ do
      begin

        s:= Format('%-0.4d-%-0.2d-%-0.2d %-0.2d:%-0.2d:%-0.2d',
            [WeighingTime.wYear, WeighingTime.wMonth, WeighingTime.wDay, WeighingTime.wHour, WeighingTime.wMinute, WeighingTime.wSecond]);
        AddLine(Format('               WeightTime    : %s', [s]));
        AddLine(Format('               Weight        : %.2f', [Weight]));
      end;

      AddLine(Format('TareWeight: ', []));

      With TareWeight^ do
      begin
        s:= Format('%-0.4d-%-0.2d-%-0.2d %-0.2d:%-0.2d:%-0.2d',
            [WeighingTime.wYear, WeighingTime.wMonth, WeighingTime.wDay, WeighingTime.wHour, WeighingTime.wMinute, WeighingTime.wSecond]);
        AddLine(Format('               WeightTime    : %s', [s]));
        AddLine(Format('               Weight        : %.2f', [Weight]));
      end;
      AddLine('----------------------------------------');
      Flush();
    end;
  end;

  Function epgov_WeightInfo_Auth(
    Token     : PStrInfo;

    ManifestNo: PStrInfo;
    PlateNumber: PStrInfo;
    DriverName : PStrInfo;
    DriverIdentityCardNo: PStrInfo
  ): Integer;
  var
    Info: string;
    s: string;
  begin
    With MultiLineLog do
    begin
      AddLine('-------------联单验证-------------------');
      AddLine(Format('Token        : %s', [Token]));
      AddLine(Format('ManifestNo   : %s', [ManifestNo]));

      AddLine(Format('PlateNumber  : %s', [PlateNumber]));
      AddLine(Format('DriverName   : %s',   [DriverName]));
      AddLine(Format('DriverIdentityCardNo: %s',   [DriverIdentityCardNo]));
      AddLine('----------------------------------------');
      Flush();
    end;
    Result:= 0;
  end;



initialization

finalization

end.
