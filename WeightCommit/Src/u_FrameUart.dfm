object frameUart: TframeUart
  Left = 0
  Top = 0
  Width = 443
  Height = 293
  Align = alClient
  BiDiMode = bdLeftToRight
  ParentBiDiMode = False
  TabOrder = 0
  object Splitter1: TSplitter
    Left = 0
    Top = 174
    Height = 100
    ExplicitLeft = 56
    ExplicitTop = 288
  end
  object Splitter2: TSplitter
    Left = 165
    Top = 174
    Height = 100
    Align = alRight
    ExplicitLeft = 632
    ExplicitTop = 13
    ExplicitHeight = 556
  end
  object ToolBar: TToolBar
    Left = 0
    Top = 0
    Width = 443
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
    Top = 274
    Width = 443
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
  end
  object pnlDB: TPanel
    Left = 3
    Top = 174
    Width = 0
    Height = 100
    Align = alLeft
    TabOrder = 2
  end
  object pnlMain: TPanel
    Left = 3
    Top = 174
    Width = 162
    Height = 100
    Align = alClient
    TabOrder = 3
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 812
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
        Width = 448
        Height = 262
        Align = alClient
        TabOrder = 1
        ExplicitLeft = 363
        ExplicitTop = 1
        ExplicitWidth = 376
        ExplicitHeight = 262
        inherited grpWeightInfo: TGroupBox
          inherited Label4: TLabel
            Font.Color = clGrayText
            ParentFont = False
          end
        end
      end
    end
  end
  object pnlLog: TPanel
    Left = 168
    Top = 174
    Width = 275
    Height = 100
    Align = alRight
    TabOrder = 4
    object mmoLog: TMemo
      Left = 1
      Top = 1
      Width = 273
      Height = 443
      Align = alClient
      ScrollBars = ssBoth
      TabOrder = 0
      ExplicitHeight = 98
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 274
    Width = 443
    Height = 0
    Align = alBottom
    Caption = 'pnlBottom'
    TabOrder = 5
  end
  object pnlTop: TPanel
    Left = 0
    Top = 19
    Width = 443
    Height = 155
    Align = alTop
    Caption = 'pnlBottom'
    TabOrder = 6
    object dbgrdWeightInfo: TDBGrid
      Left = 1
      Top = 1
      Width = 1093
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
      OnDblClick = dbgrdWeightInfoDblClick
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
    object actDBData22UI: TAction
      Caption = 'actDBData22UI'
      OnExecute = actDBData22UIExecute
    end
  end
end
