inherited frameMain: TframeMain
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 174
    Height = 100
    ExplicitTop = -142
    ExplicitHeight = 435
  end
  object Splitter2: TSplitter [1]
    Left = 165
    Top = 174
    Height = 100
    Align = alRight
    ExplicitLeft = 440
    ExplicitTop = -142
    ExplicitHeight = 435
  end
  object pnlBottom: TPanel [4]
    Left = 0
    Top = 293
    Width = 443
    Height = 0
    Align = alBottom
    Caption = 'pnlBottom'
    TabOrder = 2
  end
  object pnlDB: TPanel [5]
    Left = 3
    Top = 174
    Width = 0
    Height = 100
    Align = alLeft
    TabOrder = 3
  end
  object pnlLog: TPanel [6]
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
      Height = 98
      Align = alClient
      ScrollBars = ssBoth
      TabOrder = 0
    end
  end
  object pnlMain: TPanel [7]
    Left = 3
    Top = 174
    Width = 162
    Height = 100
    Align = alClient
    TabOrder = 5
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 160
      Height = 264
      Align = alTop
      TabOrder = 0
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
      end
      inline frameWeightInfo1: TframeWeightInfo
        Left = 363
        Top = 1
        Width = 380
        Height = 262
        Align = alClient
        TabOrder = 1
        ExplicitLeft = 363
        ExplicitTop = 1
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
  object pnlTop: TPanel [8]
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
      Width = 441
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
  inherited ActionList: TActionList
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
