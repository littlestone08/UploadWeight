unit u_frame_MainfestNoVerify;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TframeMainfrestNoVerify = class(TFrame)
    edtMainfestNo: TEdit;
    lbl1: TLabel;
    edtPlateNo: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    edtName: TEdit;
    grpDriverInfo: TGroupBox;
    grpMainfestInfo: TGroupBox;
    Label4: TLabel;
    btnAuth: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
