object frameWeightInfo: TframeWeightInfo
  Left = 0
  Top = 0
  Width = 380
  Height = 257
  TabOrder = 0
  object grpWeightInfo: TGroupBox
    Left = 13
    Top = 14
    Width = 356
    Height = 215
    BiDiMode = bdLeftToRight
    Caption = #31216#37325#25968#25454
    ParentBiDiMode = False
    TabOrder = 0
    object lbl1: TLabel
      Left = 16
      Top = 22
      Width = 52
      Height = 13
      Caption = #22320#30917#32534#21495':'
    end
    object Label4: TLabel
      Left = 135
      Top = 23
      Width = 187
      Height = 13
      Caption = #22810#20010#22320#30917#25353#20004#20301#25968#20540#36882#22686','#22914' 01'#12289'02'
    end
    object edtWeighBridgeNo: TEdit
      Left = 80
      Top = 19
      Width = 49
      Height = 21
      ImeMode = imAlpha
      TabOrder = 0
      Text = '01'
    end
    object grpWeightData: TGroupBox
      Left = 16
      Top = 41
      Width = 193
      Height = 130
      Caption = #37325#37327#25968#25454
      TabOrder = 1
      object Label2: TLabel
        Left = 12
        Top = 22
        Width = 49
        Height = 13
        Caption = #27611#37325'(KG):'
      end
      object Label3: TLabel
        Left = 12
        Top = 46
        Width = 52
        Height = 13
        Caption = #27611#37325#26102#38388':'
      end
      object Label5: TLabel
        Left = 12
        Top = 71
        Width = 49
        Height = 13
        Caption = #30382#37325'(KG):'
      end
      object Label6: TLabel
        Left = 12
        Top = 95
        Width = 52
        Height = 13
        Caption = #30382#37325#26102#38388':'
      end
      object edtGrossWeight: TEdit
        Left = 70
        Top = 19
        Width = 107
        Height = 21
        ImeMode = imAlpha
        TabOrder = 0
      end
      object edtGrossWeightTime: TEdit
        Left = 70
        Top = 43
        Width = 107
        Height = 21
        ImeMode = imAlpha
        TabOrder = 1
      end
      object edtTareWeight: TEdit
        Left = 70
        Top = 68
        Width = 107
        Height = 21
        ImeMode = imAlpha
        TabOrder = 2
      end
      object edtTareWeightTime: TEdit
        Left = 70
        Top = 92
        Width = 107
        Height = 21
        ImeMode = imAlpha
        TabOrder = 3
      end
    end
    object btnCommit: TButton
      Left = 265
      Top = 177
      Width = 75
      Height = 25
      Caption = #25552#20132
      TabOrder = 2
    end
    object grpNote: TGroupBox
      Left = 215
      Top = 42
      Width = 128
      Height = 129
      Caption = #22791#27880
      TabOrder = 3
      object edtNote: TMemo
        Left = 3
        Top = 18
        Width = 122
        Height = 95
        TabOrder = 0
      end
    end
  end
end
