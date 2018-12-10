inherited frameMain: TframeMain
  Width = 1024
  Height = 581
  ExplicitWidth = 451
  ExplicitHeight = 305
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 174
    Height = 388
    ExplicitTop = -142
    ExplicitHeight = 435
  end
  object Splitter2: TSplitter [1]
    Left = 1021
    Top = 174
    Height = 388
    Align = alRight
    ExplicitLeft = 440
    ExplicitTop = -142
    ExplicitHeight = 435
  end
  inherited ToolBar: TToolBar
    Width = 1024
  end
  inherited StatusBar: TStatusBar
    Top = 562
    Width = 1024
    ExplicitTop = 286
    ExplicitWidth = 451
  end
  object pnlBottom: TPanel [4]
    Left = 0
    Top = 562
    Width = 1024
    Height = 0
    Align = alBottom
    Caption = 'pnlBottom'
    TabOrder = 2
    ExplicitTop = 286
    ExplicitWidth = 451
  end
  object pnlDB: TPanel [5]
    Left = 3
    Top = 174
    Width = 0
    Height = 388
    Align = alLeft
    TabOrder = 3
    ExplicitHeight = 112
  end
  object pnlRight: TPanel [6]
    Left = 1021
    Top = 174
    Width = 0
    Height = 388
    Align = alRight
    TabOrder = 4
    ExplicitLeft = 448
    ExplicitHeight = 112
  end
  object pnlMain: TPanel [7]
    Left = 3
    Top = 174
    Width = 1018
    Height = 388
    Align = alClient
    TabOrder = 5
    ExplicitWidth = 445
    ExplicitHeight = 112
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 1016
      Height = 264
      Align = alTop
      TabOrder = 0
      ExplicitWidth = 443
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
          inherited edtMainfestNo: TEdit
            OnChange = frameMainfrestVerify1edtMainfestNoChange
          end
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
        Width = 228
        Height = 262
        Align = alClient
        TabOrder = 2
        ExplicitWidth = 246
        inline frameWeightNum1: TframeWeightNum
          Left = 1
          Top = 49
          Width = 226
          Height = 212
          Align = alClient
          Color = clBlack
          ParentBackground = False
          ParentColor = False
          TabOrder = 0
          ExplicitLeft = 1
          ExplicitTop = 49
          ExplicitWidth = 244
          ExplicitHeight = 212
          inherited lblNum: TLabel
            Width = 185
            Transparent = True
            ExplicitWidth = 266
          end
          inherited lbWeightTime: TLabel
            Top = 175
            Width = 226
            ExplicitTop = 175
          end
          inherited Label1: TLabel
            Top = 199
            Width = 226
            ExplicitTop = 199
          end
        end
        object pnlWeightType: TPanel
          Left = 1
          Top = 1
          Width = 226
          Height = 48
          Align = alTop
          TabOrder = 1
          ExplicitWidth = 244
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
        Left = 996
        Top = 1
        Width = 19
        Height = 262
        Align = alRight
        TabOrder = 3
        ExplicitLeft = 423
      end
    end
    object mmoLog: TMemo
      Left = 1
      Top = 265
      Width = 1016
      Height = 122
      Align = alClient
      ScrollBars = ssBoth
      TabOrder = 1
      ExplicitWidth = 443
      ExplicitHeight = 86
    end
  end
  object pnlTop: TPanel [8]
    Left = 0
    Top = 19
    Width = 1024
    Height = 155
    Align = alTop
    Caption = 'pnlBottom'
    TabOrder = 6
    ExplicitWidth = 451
    object dbgrdWeightInfo: TDBGrid
      Left = 1
      Top = 1
      Width = 1022
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
    end
    object actSelTareWeight: TAction
      Caption = #30382#37325
      OnExecute = actSelGrossWeightExecute
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
