unit u_Frame_WeightInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TframeWeightInfo = class(TFrame)
    grpWeightInfo: TGroupBox;
    Label1: TLabel;
    lbl1: TLabel;
    Label4: TLabel;
    edtWeighBridgeNo: TEdit;
    edtRem: TEdit;
    grpWeightData: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    edtGrossWeight: TEdit;
    edtGrossWeightTime: TEdit;
    btnCommit: TButton;
    Label5: TLabel;
    Label6: TLabel;
    edtTareWeight: TEdit;
    edtTareWeightTime: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
