inherited frameMain: TframeMain
  Width = 1119
  Height = 622
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 174
    Height = 429
    ExplicitTop = -142
    ExplicitHeight = 435
  end
  object Splitter2: TSplitter [1]
    Left = 1116
    Top = 174
    Height = 429
    Align = alRight
    ExplicitLeft = 440
    ExplicitTop = -142
    ExplicitHeight = 435
  end
  inherited ToolBar: TToolBar
    Width = 1119
  end
  inherited StatusBar: TStatusBar
    Top = 603
    Width = 1119
  end
  object pnlBottom: TPanel [4]
    Left = 0
    Top = 622
    Width = 1119
    Height = 0
    Align = alBottom
    Caption = 'pnlBottom'
    TabOrder = 2
    ExplicitTop = 293
    ExplicitWidth = 443
  end
  object pnlDB: TPanel [5]
    Left = 3
    Top = 174
    Width = 0
    Height = 429
    Align = alLeft
    TabOrder = 3
    ExplicitHeight = 100
  end
  object pnlRight: TPanel [6]
    Left = 1116
    Top = 174
    Width = 0
    Height = 429
    Align = alRight
    TabOrder = 4
    ExplicitLeft = 440
    ExplicitHeight = 100
  end
  object pnlMain: TPanel [7]
    Left = 3
    Top = 174
    Width = 1113
    Height = 429
    Align = alClient
    TabOrder = 5
    ExplicitWidth = 437
    ExplicitHeight = 100
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 1111
      Height = 264
      Align = alTop
      TabOrder = 0
      ExplicitWidth = 435
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
        inherited grpMainfestInfo: TGroupBox
          inherited btnAuth: TButton
            Action = actDoAuth
          end
        end
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
          inherited btnCommit: TButton
            Action = actDoCommit
          end
        end
      end
      object pnlWeightNum: TPanel
        Left = 768
        Top = 1
        Width = 323
        Height = 262
        Align = alClient
        TabOrder = 2
        ExplicitWidth = 250
        inline frameWeightNum1: TframeWeightNum
          Left = 1
          Top = 49
          Width = 321
          Height = 212
          Align = alClient
          Color = clBlack
          ParentBackground = False
          ParentColor = False
          TabOrder = 0
          ExplicitLeft = 1
          ExplicitTop = 49
          ExplicitWidth = 248
          ExplicitHeight = 212
          inherited lblNum: TLabel
            Width = 280
            Transparent = True
            ExplicitWidth = 266
          end
          inherited lbWeightTime: TLabel
            Top = 175
            Width = 321
            ExplicitTop = 175
          end
          inherited Label1: TLabel
            Top = 199
            Width = 321
            ExplicitTop = 199
          end
        end
        object pnlWeightType: TPanel
          Left = 1
          Top = 1
          Width = 321
          Height = 48
          Align = alTop
          TabOrder = 1
          ExplicitWidth = 248
          object rbGross: TRadioButton
            Left = 32
            Top = 16
            Width = 57
            Height = 17
            Action = actSelGrossWeight
            TabOrder = 0
          end
          object rbTare: TRadioButton
            Left = 121
            Top = 16
            Width = 73
            Height = 17
            Action = actSelTareWeight
            TabOrder = 1
          end
          object btnSample: TButton
            Left = 200
            Top = 11
            Width = 75
            Height = 25
            Action = actSampleWeight
            TabOrder = 2
          end
        end
      end
      object pnlPlaceHolder: TPanel
        Left = 1091
        Top = 1
        Width = 19
        Height = 262
        Align = alRight
        TabOrder = 3
        ExplicitLeft = 415
      end
    end
    object mmoLog: TMemo
      Left = 1
      Top = 265
      Width = 1111
      Height = 163
      Align = alClient
      ScrollBars = ssBoth
      TabOrder = 1
      ExplicitWidth = 435
      ExplicitHeight = 116
    end
  end
  object pnlTop: TPanel [8]
    Left = 0
    Top = 19
    Width = 1119
    Height = 155
    Align = alTop
    Caption = 'pnlBottom'
    TabOrder = 6
    ExplicitWidth = 443
    object dbgrdWeightInfo: TDBGrid
      Left = 1
      Top = 1
      Width = 1117
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
    object actSelGrossWeight: TAction
      Caption = #27611#37325
      OnExecute = actSelGrossWeightExecute
      OnUpdate = actSelGrossWeightUpdate
    end
    object actSelTareWeight: TAction
      Caption = #30382#37325
      OnExecute = actSelGrossWeightExecute
      OnUpdate = actSelTareWeightUpdate
    end
    object actSampleWeight: TAction
      Caption = #37319#38598#37325#37327
      OnExecute = actSampleWeightExecute
      OnUpdate = actSampleWeightUpdate
    end
    object actDoCommit: TAction
      Caption = #20445#23384#25552#20132
      OnExecute = actDoCommitExecute
    end
  end
end
