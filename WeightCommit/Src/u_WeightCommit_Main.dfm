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
  inline frameUart1: TframeUart
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
      ExplicitHeight = 450
    end
    inherited Splitter2: TSplitter
      Left = 728
      Height = 385
      ExplicitLeft = 583
      ExplicitHeight = 450
    end
    inherited ToolBar: TToolBar
      Width = 1062
      ExplicitWidth = 312
    end
    inherited StatusBar: TStatusBar
      Top = 559
      Width = 1062
      ExplicitTop = 559
      ExplicitWidth = 1062
    end
    inherited pnlDB: TPanel
      Height = 385
      ExplicitHeight = 385
    end
    inherited pnlMain: TPanel
      Width = 725
      Height = 385
      ExplicitWidth = 520
      ExplicitHeight = 385
      inherited frameWeightInfo1: TframeWeightInfo
        Width = 518
        ExplicitWidth = 518
      end
    end
    inherited pnlLog: TPanel
      Left = 731
      Height = 385
      ExplicitLeft = 526
      ExplicitHeight = 385
    end
    inherited pnlBottom: TPanel
      Top = 559
      Width = 1062
      ExplicitTop = 559
      ExplicitWidth = 1062
    end
    inherited pnlTop: TPanel
      Width = 1062
      ExplicitWidth = 1062
      inherited dbgrdWeightInfo: TDBGrid
        Width = 1060
      end
    end
  end
end
