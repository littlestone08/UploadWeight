object frmWeightCommit: TfrmWeightCommit
  Left = 0
  Top = 0
  Caption = #21361#24223#35745#37327#25552#20132
  ClientHeight = 589
  ClientWidth = 1136
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  inline frameMain1: TframeMain
    Left = 0
    Top = 0
    Width = 1136
    Height = 589
    Align = alClient
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 0
    ExplicitWidth = 1062
    ExplicitHeight = 578
    inherited Splitter1: TSplitter
      Height = 396
      ExplicitHeight = 385
    end
    inherited Splitter2: TSplitter
      Left = 1133
      Height = 396
      ExplicitLeft = 784
      ExplicitHeight = 385
    end
    inherited ToolBar: TToolBar
      Width = 1136
      ExplicitWidth = 1062
    end
    inherited StatusBar: TStatusBar
      Top = 570
      Width = 1136
      ExplicitTop = 559
      ExplicitWidth = 1062
    end
    inherited pnlBottom: TPanel
      Top = 589
      Width = 1136
      ExplicitTop = 578
      ExplicitWidth = 1062
    end
    inherited pnlDB: TPanel
      Height = 396
      ExplicitHeight = 385
    end
    inherited pnlRight: TPanel
      Left = 1136
      Height = 396
      ExplicitLeft = 1062
      ExplicitHeight = 385
    end
    inherited pnlMain: TPanel
      Width = 1130
      Height = 396
      ExplicitWidth = 1056
      ExplicitHeight = 385
      inherited Panel1: TPanel
        Width = 1128
        ExplicitWidth = 1054
        inherited Splitter3: TSplitter
          Left = 778
          ExplicitLeft = 778
        end
        inherited frameMainfrestVerify1: TframeMainfrestVerify
          inherited grpMainfestInfo: TGroupBox
            inherited btnAuth: TButton
              Action = frameMain1.actDoAuth
              Caption = #35748#35777
            end
          end
        end
        inherited frameWeightInfo1: TframeWeightInfo
          Width = 415
          ExplicitWidth = 415
        end
        inherited pnlWeightNum: TPanel
          Left = 781
          Width = 327
          ExplicitLeft = 781
          ExplicitWidth = 253
          inherited frameWeightNum1: TframeWeightNum
            Width = 325
            ExplicitWidth = 251
            inherited lblNum: TLabel
              Width = 325
              ExplicitWidth = 216
            end
            inherited lbWeightTime: TLabel
              Width = 325
            end
            inherited Label1: TLabel
              Width = 325
            end
          end
          inherited pnlWeightType: TPanel
            Width = 325
            ExplicitWidth = 251
          end
        end
        inherited pnlPlaceHolder: TPanel
          Left = 1108
          ExplicitLeft = 1034
        end
      end
      inherited mmoLog: TMemo
        Width = 1128
        Height = 130
        ExplicitWidth = 1054
        ExplicitHeight = 119
      end
    end
    inherited pnlTop: TPanel
      Width = 1136
      ExplicitWidth = 1062
      inherited dbgrdWeightInfo: TDBGrid
        Width = 1134
      end
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    Left = 872
    Top = 280
  end
end
