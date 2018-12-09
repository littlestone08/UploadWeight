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
    ExplicitLeft = 224
    ExplicitTop = 200
    ExplicitHeight = 9
    inherited Splitter1: TSplitter
      Height = 385
    end
    inherited Splitter2: TSplitter
      Left = 784
      Height = 385
    end
    inherited ToolBar: TToolBar
      Width = 1062
    end
    inherited StatusBar: TStatusBar
      Top = 559
      Width = 1062
    end
    inherited pnlBottom: TPanel
      Top = 578
      Width = 1062
    end
    inherited pnlDB: TPanel
      Height = 385
    end
    inherited pnlLog: TPanel
      Left = 787
      Height = 385
      inherited mmoLog: TMemo
        Height = 383
      end
    end
    inherited pnlMain: TPanel
      Width = 781
      Height = 385
      inherited Panel1: TPanel
        Width = 779
        inherited frameWeightInfo1: TframeWeightInfo
          Width = 415
        end
      end
    end
    inherited pnlTop: TPanel
      Width = 1062
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
