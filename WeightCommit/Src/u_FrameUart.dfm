object frameUart: TframeUart
  Left = 0
  Top = 0
  Width = 1001
  Height = 581
  Align = alClient
  BiDiMode = bdLeftToRight
  ParentBiDiMode = False
  TabOrder = 0
  ExplicitWidth = 443
  ExplicitHeight = 293
  object Splitter1: TSplitter
    Left = 279
    Top = 19
    Height = 543
    ExplicitLeft = 56
    ExplicitTop = 288
    ExplicitHeight = 100
  end
  object Splitter2: TSplitter
    Left = 657
    Top = 19
    Height = 543
    Align = alRight
    ExplicitLeft = 632
    ExplicitTop = 13
    ExplicitHeight = 556
  end
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 1001
    Height = 19
    AutoSize = True
    ButtonHeight = 19
    ButtonWidth = 60
    Caption = 'ToolBar'
    DrawingStyle = dsGradient
    List = True
    AllowTextButtons = True
    TabOrder = 0
    Transparent = True
    ExplicitWidth = 443
    object cbbComPort: TComboBox
      Left = 0
      Top = 0
      Width = 89
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'COM1'
      Items.Strings = (
        'COM1'
        'COM2'
        'COM3'
        'COM4')
    end
    object ToolButton1: TToolButton
      Left = 89
      Top = 0
      Action = actPortOpenClose
      Style = tbsTextButton
    end
    object tbUartRefresh: TToolButton
      Left = 148
      Top = 0
      Action = actRefreshPort1
      Style = tbsTextButton
    end
    object tblUartParam: TToolButton
      Left = 207
      Top = 0
      Action = actSetupUart
      Style = tbsTextButton
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 562
    Width = 1001
    Height = 19
    Panels = <
      item
        Width = 170
      end
      item
        Width = 50
      end
      item
        Width = 50
      end>
    ExplicitTop = 274
    ExplicitWidth = 443
  end
  object pnlDB: TPanel
    Left = 0
    Top = 19
    Width = 279
    Height = 543
    Align = alLeft
    TabOrder = 2
    object dbgrdWeightInfo: TDBGrid
      Left = 1
      Top = 1
      Width = 277
      Height = 541
      Align = alClient
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object pnlMain: TPanel
    Left = 282
    Top = 19
    Width = 375
    Height = 543
    Align = alClient
    TabOrder = 3
    ExplicitLeft = 257
    ExplicitWidth = 388
    ExplicitHeight = 255
    inline frameMainfrestNoVerify1: TframeMainfrestNoVerify
      Left = 1
      Top = 1
      Width = 373
      Height = 246
      Align = alTop
      TabOrder = 0
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 386
    end
    inline frameWeightInfo1: TframeWeightInfo
      Left = 1
      Top = 247
      Width = 373
      Height = 308
      Align = alTop
      TabOrder = 1
      ExplicitLeft = 1
      ExplicitTop = 247
      ExplicitWidth = 386
      ExplicitHeight = 308
    end
  end
  object pnlLog: TPanel
    Left = 660
    Top = 19
    Width = 341
    Height = 543
    Align = alRight
    TabOrder = 4
    ExplicitLeft = 102
    ExplicitHeight = 255
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 562
    Width = 1001
    Height = 0
    Align = alBottom
    Caption = 'pnlBottom'
    TabOrder = 5
    ExplicitTop = 274
    ExplicitWidth = 443
  end
  object pnlTop: TPanel
    Left = 0
    Top = 19
    Width = 1001
    Height = 0
    Align = alTop
    Caption = 'pnlBottom'
    TabOrder = 6
    ExplicitWidth = 443
  end
  object ActionList: TActionList
    Left = 128
    Top = 40
    object actRefreshPort1: TAction
      Caption = #21047#26032#20018#21475
      OnExecute = actRefreshPort1Execute
    end
    object actSetupUart: TAction
      Caption = #20018#21475#21442#25968
      OnExecute = actSetupUartExecute
      OnUpdate = actSetupUartUpdate
    end
    object actPortOpenClose: TAction
      Caption = #20018#21475#24320#20851
      OnExecute = actPortOpenCloseExecute
      OnUpdate = actPortOpenCloseUpdate
    end
  end
end
