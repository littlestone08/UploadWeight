object dmWeight: TdmWeight
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 438
  Width = 679
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=SQLite')
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
    SQL.Strings = (
      'Select * from WeightInfo')
    Left = 32
    Top = 96
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = FDQuery1
    Left = 148
    Top = 96
  end
  object FDCommand1: TFDCommand
    Connection = FDConnection1
    Left = 144
    Top = 176
  end
  object FDTable1: TFDTable
    IndexFieldNames = 'ID'
    Connection = FDConnection2
    UpdateOptions.UpdateTableName = 'WeightInfo'
    TableName = 'WeightInfo'
    Left = 240
    Top = 328
    object FDTable1ID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FDTable1MainfestNo: TWideStringField
      FieldName = 'MainfestNo'
      Origin = 'MainfestNo'
      Size = 50
    end
    object FDTable1PlateLic: TWideStringField
      FieldName = 'PlateLic'
      Origin = 'PlateLic'
      Size = 50
    end
    object FDTable1DriverName: TWideStringField
      FieldName = 'DriverName'
      Origin = 'DriverName'
      Size = 10
    end
    object FDTable1DriverIDC: TWideStringField
      FieldName = 'DriverIDC'
      Origin = 'DriverIDC'
    end
    object FDTable1WeighBridgeNo: TWideStringField
      FieldName = 'WeighBridgeNo'
      Origin = 'WeighBridgeNo'
      Size = 10
    end
    object FDTable1WeightGross: TFloatField
      FieldName = 'WeightGross'
      Origin = 'WeightGross'
    end
    object FDTable1WeightGrossTime: TDateTimeField
      FieldName = 'WeightGrossTime'
      Origin = 'WeightGrossTime'
    end
    object FDTable1WeightGrossValid: TBooleanField
      FieldName = 'WeightGrossValid'
      Origin = 'WeightGrossValid'
    end
    object FDTable1WeightTare: TFloatField
      FieldName = 'WeightTare'
      Origin = 'WeightTare'
    end
    object FDTable1WeightTareTime: TDateTimeField
      FieldName = 'WeightTareTime'
      Origin = 'WeightTareTime'
    end
    object FDTable1WeightTareValid: TBooleanField
      FieldName = 'WeightTareValid'
      Origin = 'WeightTareValid'
    end
    object FDTable1Note: TWideStringField
      FieldName = 'Note'
      Origin = 'Note'
      Size = 100
    end
  end
  object FDConnection2: TFDConnection
    Params.Strings = (
      
        'Database=D:\WORK170908\upload\WeightCommit\Src\Win32\Debug\SQLTe' +
        'st.sdb'
      'DriverID=SQLite')
    Left = 320
    Top = 328
  end
end
