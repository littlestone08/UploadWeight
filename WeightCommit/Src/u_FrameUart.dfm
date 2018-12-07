object frameUart: TframeUart
  Left = 0
  Top = 0
  Width = 1018
  Height = 538
  Align = alClient
  BiDiMode = bdLeftToRight
  ParentBiDiMode = False
  TabOrder = 0
  ExplicitWidth = 443
  ExplicitHeight = 293
  object Splitter1: TSplitter
    Left = 0
    Top = 174
    Height = 345
    ExplicitLeft = 56
    ExplicitTop = 288
    ExplicitHeight = 100
  end
  object Splitter2: TSplitter
    Left = 740
    Top = 174
    Height = 345
    Align = alRight
    ExplicitLeft = 632
    ExplicitTop = 13
    ExplicitHeight = 556
  end
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 1018
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
    Top = 519
    Width = 1018
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
    Left = 3
    Top = 174
    Width = 0
    Height = 345
    Align = alLeft
    TabOrder = 2
    ExplicitHeight = 100
  end
  object pnlMain: TPanel
    Left = 3
    Top = 174
    Width = 737
    Height = 345
    Align = alClient
    TabOrder = 3
    ExplicitWidth = 162
    ExplicitHeight = 100
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 735
      Height = 264
      Align = alTop
      TabOrder = 0
      ExplicitWidth = 160
      inline frameMainfrestVerify1: TframeMainfrestVerify
        Left = 1
        Top = 1
        Width = 362
        Height = 262
        Align = alLeft
        TabOrder = 0
        ExplicitLeft = 1
        ExplicitTop = 1
        ExplicitWidth = 362
        ExplicitHeight = 262
        inherited grpMainfestInfo: TGroupBox
          inherited btnAuth: TButton
            Action = actDoAuth
          end
        end
      end
      inline frameWeightInfo1: TframeWeightInfo
        Left = 363
        Top = 1
        Width = 371
        Height = 262
        Align = alClient
        TabOrder = 1
        ExplicitLeft = 363
        ExplicitTop = 1
        ExplicitWidth = 376
        ExplicitHeight = 262
      end
    end
  end
  object pnlLog: TPanel
    Left = 743
    Top = 174
    Width = 275
    Height = 345
    Align = alRight
    TabOrder = 4
    ExplicitLeft = 168
    ExplicitHeight = 100
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 519
    Width = 1018
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
    Width = 1018
    Height = 155
    Align = alTop
    Caption = 'pnlBottom'
    TabOrder = 6
    ExplicitWidth = 443
    object dbgrdWeightInfo: TDBGrid
      Left = 1
      Top = 1
      Width = 1016
      Height = 153
      Align = alClient
      DataSource = dmWeight.DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
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
    object actDoAuth: TAction
      Caption = #32852#21333#35748#35777
      OnExecute = actDoAuthExecute
      OnUpdate = actDoAuthUpdate
    end
  end
end
