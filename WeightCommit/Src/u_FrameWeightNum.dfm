object frameWeightNum: TframeWeightNum
  Left = 0
  Top = 0
  Width = 328
  Height = 155
  Color = clBlack
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  DesignSize = (
    328
    155)
  object lblNum: TLabel
    Left = 16
    Top = 16
    Width = 273
    Height = 102
    Alignment = taRightJustify
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoSize = False
    Caption = '00000.00'
    Color = clMaroon
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -60
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = False
    Layout = tlCenter
  end
  object lbWeightTime: TLabel
    Left = 0
    Top = 118
    Width = 328
    Height = 24
    Align = alBottom
    Alignment = taCenter
    Caption = 'lbWeightTime'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Transparent = True
    ExplicitWidth = 124
  end
  object Label1: TLabel
    Left = 0
    Top = 142
    Width = 328
    Height = 13
    Align = alBottom
    Transparent = True
    ExplicitWidth = 3
  end
  object tmrCheckOutDated: TTimer
    OnTimer = tmrCheckOutDatedTimer
    Left = 56
    Top = 40
  end
end
