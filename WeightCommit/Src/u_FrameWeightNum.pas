unit u_FrameWeightNum;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TframeWeightNum = class(TFrame)
    lblNum: TLabel;
    lbWeightTime: TLabel;
    tmrCheckOutDated: TTimer;
    Label1: TLabel;
    procedure tmrCheckOutDatedTimer(Sender: TObject);
  private
    FSampleTime: TDateTime;
    FSampleWeight: Single;

    procedure SetSampleWeight(const Value: Single);
    function GetWeightOutofdated: Boolean;
    Procedure UpdateRenderColor;
    Procedure UpdateRender;
    { Private declarations }
  public
    { Public declarations }
    Constructor Create(AOwner: TComponent); Override;
    Property SampleWeight: Single read FSampleWeight write SetSampleWeight;
    Property SampleTime: TDateTime read FSampleTime;
    Property WeightOutofdated: Boolean Read GetWeightOutofdated;
  end;

implementation
uses
  DateUtils;

{$R *.dfm}

const
  CONST_VALID_COLOR: TColor = clGreen;
  CONST_INVALID_COLOR: TColor = clRed;
{ TframeWeightNum }

procedure TframeWeightNum.UpdateRender;
begin
  lblNum.Caption:= Format('%8.2f', [self.FSampleWeight]);
  lbWeightTime.Caption:= FormatDateTime('YYYY-MM-DD HH:NN:SS', Now);
  UpdateRenderColor;
end;

procedure TframeWeightNum.UpdateRenderColor;
var
  AColor: TColor;
begin
  if WeightOutofdated then
    AColor:= CONST_INVALID_COLOR
  else
    AColor:= CONST_VALID_COLOR;
  if lblNum.Font.Color <> AColor then
    lblNum.Font.Color:= AColor;
end;

constructor TframeWeightNum.Create(AOwner: TComponent);
begin
  inherited;
  SetSampleWeight(0);
end;



function TframeWeightNum.GetWeightOutofdated: Boolean;
begin
  Result:= SecondSpan(NOw(), FSampleTime) >= 2;
end;



procedure TframeWeightNum.SetSampleWeight(const Value: Single);
begin
  FSampleWeight := Value;
  FSampleTime:= Now();

  UpdateRender();
end;

procedure TframeWeightNum.tmrCheckOutDatedTimer(Sender: TObject);
begin
  UpdateRenderColor();
end;

end.
