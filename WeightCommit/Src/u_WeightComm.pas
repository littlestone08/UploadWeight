unit u_WeightComm;

interface

type
  TWeightAuth = record
    MainfestNo: String;
    PlateNum: String;
    DriverName: String;
    DriverIDC: String;
  end;


  TWeightItem = record
    Wegiht_KG: Single;
    WegihtTime: TDateTime;
    Valid: Boolean;
  end;

  TWeightMeasure = record
    WeightBridge: String;
    Gross: TWeightItem;
    Tare : TWeightItem;
    Note: String;
  end;

  TWeightInfo = record
    Auth: TWeightAuth;
    Mesure: TWeightMeasure;
    Commited: Boolean;
  end;

implementation

end.
