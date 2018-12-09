inherited frameMain: TframeMain
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 174
    Height = 100
    ExplicitTop = -142
    ExplicitHeight = 435
  end
  object Splitter2: TSplitter [1]
    Left = 440
    Top = 174
    Height = 100
    Align = alRight
    ExplicitTop = -142
    ExplicitHeight = 435
  end
  inherited StatusBar: TStatusBar
    ExplicitTop = 509
    ExplicitWidth = 1082
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
  object pnlRight: TPanel [6]
    Left = 440
    Top = 174
    Width = 0
    Height = 100
    Align = alRight
    TabOrder = 4
  end
  object pnlMain: TPanel [7]
    Left = 3
    Top = 174
    Width = 437
    Height = 100
    Align = alClient
    TabOrder = 5
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 435
      Height = 264
      Align = alTop
      TabOrder = 0
      object Splitter3: TSplitter
        Left = 765
        Top = 1
        Height = 262
        ExplicitLeft = 872
        ExplicitTop = 120
        ExplicitHeight = 100
      end
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
        Width = 402
        Height = 262
        Align = alLeft
        TabOrder = 1
        ExplicitLeft = 363
        ExplicitTop = 1
        ExplicitWidth = 402
        ExplicitHeight = 262
        inherited grpWeightInfo: TGroupBox
          inherited Label4: TLabel
            Font.Color = clGrayText
            ParentFont = False
          end
        end
      end
      inline frameWeightNum1: TframeWeightNum
        Left = 768
        Top = 1
        Width = 305
        Height = 262
        Align = alClient
        Color = clBlack
        ParentBackground = False
        ParentColor = False
        TabOrder = 2
        ExplicitLeft = 768
        ExplicitTop = 1
        ExplicitWidth = 305
        ExplicitHeight = 262
        inherited lblNum: TLabel
          Left = 27
          Top = 90
          Width = 249
          Height = 72
          Align = alNone
          Anchors = [akLeft, akRight]
          ExplicitLeft = 27
          ExplicitTop = 90
        end
        inherited lbWeightTime: TLabel
          Top = 238
          Width = 305
          ExplicitLeft = 181
          ExplicitTop = 238
        end
      end
    end
    object mmoLog: TMemo
      Left = 1
      Top = 265
      Width = 435
      Height = 69
      Align = alClient
      ScrollBars = ssBoth
      TabOrder = 1
      ExplicitHeight = 233
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
      Width = 1080
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
