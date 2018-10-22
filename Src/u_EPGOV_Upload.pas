unit u_EPGOV_Upload;

interface
uses
  Classes, Windows, SysUtils;
type
  TStrInfo = Record
    Buffer: Pointer;
    nSize: Byte;
    function ToString: String;
  End;
  PStrInfo = ^TStrInfo;

  TWeightInfo = Record
    WeighingTime: TSystemTime;
    WeightBridgeNo: Byte;
    Weight: Double;
  End;
  PWeightInfo = ^TWeightInfo;

  Procedure epgov_WeightInfoUpload(
    Token     : PStrInfo;
    ManifestNo: PStrInfo;
    ComputerID: PStrInfo;
    TranType  : Byte;
    CredentialNo: PStrInfo;
    Commodity:PStrInfo;

    PlateNumber: PStrInfo;
    CompanyDelivery: PStrInfo;
    CompanyReceipt: PStrInfo;

    GrossWeight: PWeightInfo;
    TareWeight: PWeightInfo
  ); stdcall;

implementation
uses
  u_Log;


  Procedure epgov_WeightInfoUpload(
    Token     : PStrInfo;
    ManifestNo: PStrInfo;
    ComputerID: PStrInfo;
    TranType  : Byte;
    CredentialNo: PStrInfo;
    Commodity:PStrInfo;

    PlateNumber: PStrInfo;
    CompanyDelivery: PStrInfo;
    CompanyReceipt: PStrInfo;

    GrossWeight: PWeightInfo;
    TareWeight: PWeightInfo
  );
  var
    Info: string;
    s: string;
  begin
    With MultiLineLog do
    begin
      AddLine('----------------------------------------');
      AddLine(Format('Token        : %s', [Token.ToString]));
      AddLine(Format('ManifestNo   : %s', [ManifestNo.ToString]));
      AddLine(Format('ComputerID   : %s', [ComputerID.ToString]));
      AddLine(Format('TransType    : %d', [TranType]));
      AddLine(Format('CredentialNo : %s', [CredentialNo.ToString]));
      AddLine(Format('Commodity    : %s', [Commodity.ToString]));

      AddLine(Format('PlateNumber      : %s', [PlateNumber.ToString]));
      AddLine(Format('CompanyDelivery  : %s', [CompanyDelivery.ToString]));
      AddLine(Format('CompanyReceipt   : %s', [CompanyReceipt.ToString]));
      AddLine(Format('GrossWeight: ', []));

      With GrossWeight^ do
      begin

        s:= Format('%-0.4d-%-0.2d-%-0.2d %-0.2d:%-0.2d:%-0.2d',
            [WeighingTime.wYear, WeighingTime.wMonth, WeighingTime.wDay, WeighingTime.wHour, WeighingTime.wMinute, WeighingTime.wSecond]);
        AddLine(Format('               WeightTime    : %s', [s]));

        AddLine(Format('               WeightBridgeNo: %d', [WeightBridgeNo]));
        AddLine(Format('               Weight        : %.2f', [Weight]));
      end;

      AddLine(Format('TareWeight: ', []));

      With TareWeight^ do
      begin
        s:= Format('%-0.4d-%-0.2d-%-0.2d %-0.2d:%-0.2d:%-0.2d',
            [WeighingTime.wYear, WeighingTime.wMonth, WeighingTime.wDay, WeighingTime.wHour, WeighingTime.wMinute, WeighingTime.wSecond]);
        AddLine(Format('               WeightTime    : %s', [s]));

        AddLine(Format('               WeightBridgeNo: %d', [WeightBridgeNo]));
        AddLine(Format('               Weight        : %.2f', [Weight]));
      end;
      AddLine('----------------------------------------');
      Flush();
    end;
  end;
{ TStrInfo }

function TStrInfo.ToString: String;
var
  _as: AnsiString;
begin
  SetLength(_as, self.nSize);
  Move(Self.Buffer^, _as[1], nSize);
  Result:= _as;
end;

initialization

finalization

end.
