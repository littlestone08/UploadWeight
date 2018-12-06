object dmWeight: TdmWeight
  OldCreateOrder = False
  Height = 438
  Width = 679
  object FDConnection1: TFDConnection
    Left = 34
    Top = 24
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 143
    Top = 24
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 260
    Top = 24
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 344
    Top = 24
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = FDQuery1
    Left = 420
    Top = 24
  end
end
