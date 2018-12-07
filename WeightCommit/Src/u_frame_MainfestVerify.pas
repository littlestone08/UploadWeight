unit u_frame_MainfestVerify;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, u_WeightComm;

type
  TframeMainfrestVerify = class(TFrame)
    edtMainfestNo: TEdit;
    lbl1: TLabel;
    edtPlateNo: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtDriverIDC: TEdit;
    Label3: TLabel;
    edtDriverName: TEdit;
    grpDriverInfo: TGroupBox;
    grpMainfestInfo: TGroupBox;
    Label4: TLabel;
    btnAuth: TButton;
  private
    function GetWeightAuth: TWeightAuth;
    procedure SetWeightAuth(const Value: TWeightAuth);
    { Private declarations }
  public
    { Public declarations }
    Property WeightAuth: TWeightAuth Read GetWeightAuth Write SetWeightAuth;
  end;

implementation

{$R *.dfm}

{ TframeMainfrestVerify }

function TframeMainfrestVerify.GetWeightAuth: TWeightAuth;
begin
  Result.MainfestNo:= edtMainfestNo.Text;
  Result.PlateNum:= edtPlateNo.Text;
  Result.DriverName:= edtDriverName.Text;
  Result.DriverIDC:= edtDriverIDC.Text;
end;

procedure TframeMainfrestVerify.SetWeightAuth(const Value: TWeightAuth);
begin
  edtMainfestNo.Text:= Value.MainfestNo;
  edtPlateNo.Text:= Value.PlateNum;
  edtDriverName.Text:= Value.DriverName;
  edtDriverIDC.Text:= Value.DriverIDC;
end;

end.
