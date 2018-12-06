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
      Height = 540
      ExplicitHeight = 450
    end
    inherited Splitter2: TSplitter
      Left = 800
      Height = 540
      ExplicitLeft = 583
      ExplicitHeight = 450
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
    inherited pnlDB: TPanel
      Height = 540
      ExplicitHeight = 540
    end
    inherited pnlMain: TPanel
      Width = 543
      Height = 540
      ExplicitLeft = 257
      ExplicitTop = 19
      ExplicitWidth = 543
      ExplicitHeight = 540
    end
    inherited pnlLog: TPanel
      Left = 803
      Height = 540
      ExplicitLeft = 803
      ExplicitHeight = 540
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
    end
  end
end
