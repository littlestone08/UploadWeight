object frmWeightCommit: TfrmWeightCommit
  Left = 0
  Top = 0
  Caption = #21361#24223#35745#37327#25552#20132
  ClientHeight = 578
  ClientWidth = 1062
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
    Width = 1062
    Height = 578
    Align = alClient
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 0
    ExplicitWidth = 1062
    ExplicitHeight = 578
    inherited Splitter1: TSplitter
      Height = 385
      ExplicitHeight = 385
    end
    inherited Splitter2: TSplitter
      Left = 1059
      Height = 385
      ExplicitLeft = 784
      ExplicitHeight = 385
    end
    inherited ToolBar: TToolBar
      Width = 1062
      ExplicitWidth = 1062
    end
    inherited StatusBar: TStatusBar
      Top = 559
      Width = 1062
      ExplicitTop = 559
      ExplicitWidth = 1062
    end
    inherited pnlBottom: TPanel
      Top = 578
      Width = 1062
      ExplicitTop = 578
      ExplicitWidth = 1062
    end
    inherited pnlDB: TPanel
      Height = 385
      ExplicitHeight = 385
    end
    inherited pnlRight: TPanel
      Left = 1062
      Height = 385
      ExplicitLeft = 1062
      ExplicitHeight = 385
    end
    inherited pnlMain: TPanel
      Width = 1056
      Height = 385
      ExplicitWidth = 1056
      ExplicitHeight = 385
      inherited Panel1: TPanel
        Width = 1054
        ExplicitWidth = 1054
        inherited Splitter3: TSplitter
          Left = 778
          ExplicitLeft = 778
        end
        inherited frameWeightInfo1: TframeWeightInfo
          Width = 415
          ExplicitWidth = 415
        end
        inherited frameWeightNum1: TframeWeightNum
          Left = 781
          Width = 272
          ExplicitLeft = 781
          ExplicitWidth = 272
          inherited lblNum: TLabel
            Width = 216
          end
          inherited lbWeightTime: TLabel
            Width = 272
          end
        end
      end
      inherited mmoLog: TMemo
        Width = 1054
        Height = 119
        ExplicitWidth = 1054
        ExplicitHeight = 119
      end
    end
    inherited pnlTop: TPanel
      Width = 1062
      ExplicitWidth = 1062
      inherited dbgrdWeightInfo: TDBGrid
        Width = 1060
      end
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnException = ApplicationEvents1Exception
    Left = 872
    Top = 280
  end
end
