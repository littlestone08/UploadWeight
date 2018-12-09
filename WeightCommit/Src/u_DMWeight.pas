unit u_DMWeight;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.SQLite, u_WeightComm,
  Variants;

type
  TdmWeight = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDQuery1: TFDQuery;
    DataSource1: TDataSource;
    FDCommand1: TFDCommand;
    FDTable1: TFDTable;
    FDConnection2: TFDConnection;
    FDTable1ID: TIntegerField;
    FDTable1MainfestNo: TWideStringField;
    FDTable1PlateLic: TWideStringField;
    FDTable1DriverName: TWideStringField;
    FDTable1DriverIDC: TWideStringField;
    FDTable1WeighBridgeNo: TWideStringField;
    FDTable1WeightGross: TFloatField;
    FDTable1WeightGrossTime: TDateTimeField;
    FDTable1WeightGrossValid: TBooleanField;
    FDTable1WeightTare: TFloatField;
    FDTable1WeightTareTime: TDateTimeField;
    FDTable1WeightTareValid: TBooleanField;
    FDTable1Note: TWideStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    function CheckNullDef(const Value: Variant; ValueIfNull: Variant): Variant;
    Procedure CheckOpenDB;
    Procedure CheckOpenDB2;
    Procedure UpdateFieldDisplay();
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    Function DB_InsertAuthInfo(const Value: TWeightAuth): Integer;
    Function DB_MainfestExist(const MainfestNo: String): Boolean;
    Function DB_2Record(var Value: TWeightInfo): Boolean; Overload;
//    Function DB_2Record(const MainfestNo: String; var Value: TWeightInfo): Boolean; Overload;
    function DB_Mainfest2Record(const MainfestNo: String;
          var Value: TWeightInfo): Boolean;
//    Function DB_Mainfest2Record(const MainfestNum: String; var Value: TWeightInfo): Boolean;
  end;

var
  dmWeight: TdmWeight;

implementation
uses
  System.Generics.Collections ,CnCommon;
const
  CONST_DBFILENAME  = 'SQLTest.sdb';
  CONST_TABLENAME  = 'WeightInfo';

const
  CONST_FIELDNAME_ID          = 'ID';
  CONST_FIELDNAME_MAINFESTNO  = 'MainfestNo';
  CONST_FIELDNAME_PLATELIC    = 'PlateLic';
  CONST_FIELDNAME_DRIVERNAME  = 'DriverName';
  CONST_FIELDNAME_DRIVERIDC   = 'DriverIDC';
  CONST_FIELDNAME_WEIGHTBRIDGENO = 'WeighBridgeNo';
  CONST_FIELDNAME_WEIGHTGROSS = 'WeightGross';
  CONST_FIELDNAME_WEIGHTGROSSTIME = 'WeightGrossTime';
  CONST_FIELDNAME_WEIGHTGROSSVALID = 'WeightGrossValid';
  CONST_FIELDNAME_WEIGHTARE   = 'WeightTare';
  CONST_FIELDNAME_WEIGHTTARETIME = 'WeightTareTime';
  CONST_FIELDNAME_WEIGHTTAREVALID = 'WeightTareValid';
  CONST_FIELDNAME_NOTE        = 'Note';


{$R *.dfm}



function TdmWeight.CheckNullDef(const Value: Variant;
  ValueIfNull: Variant): Variant;
begin
  if VarIsNull(Value) then
    Result:= ValueIfNull
  else
    Result:= Value;
end;

procedure TdmWeight.CheckOpenDB;
const
  dbPath = '.\'  + CONST_DBFILENAME;
//var
//  dbPath: String;
//begin
//   dbPath:= AppPath + '\WeightInfo.sdb';
var
  Tables: TStringList;
begin

    with FDConnection1 do begin
      Params.Add('DriverID=SQLite');
      Params.Add('Database=' + dbPath);
      Connected := True;
    end;

    Tables:= TStringList.Create;
    try
      FDConnection1.GetTableNames('', '', '', Tables);
      if Tables.IndexOf(CONST_TABLENAME) < 0 then
      begin
        FDConnection1.ExecSQL('CREATE TABLE ' + CONST_TABLENAME + ' ('    +
                              CONST_FIELDNAME_ID +' integer PRIMARY KEY,'     +
                              CONST_FIELDNAME_MAINFESTNO  + ' string(500), '     +
                              CONST_FIELDNAME_PLATELIC    + ' string(50), '       +
                              CONST_FIELDNAME_DRIVERNAME  + ' string(10), '     +
                              CONST_FIELDNAME_DRIVERIDC   + ' string(20), '      +
                              CONST_FIELDNAME_WEIGHTBRIDGENO +' string(10), '  +
                              CONST_FIELDNAME_WEIGHTGROSS + ' float, '         +
                              CONST_FIELDNAME_WEIGHTGROSSTIME +' DATETIME, '  +
                              CONST_FIELDNAME_WEIGHTGROSSVALID + ' bit default 0, '    +
                              CONST_FIELDNAME_WEIGHTARE + ' float, '          +
                              CONST_FIELDNAME_WEIGHTTARETIME + ' DATETIME, '   +
                              CONST_FIELDNAME_WEIGHTTAREVALID +' bit default 0, '     +
                              CONST_FIELDNAME_NOTE + ' string(100)'            +
                              ')');
      end;

    finally
      Tables.Free;
    end;


  {查看表}
  FDQuery1.Open('SELECT * FROM WeightInfo');
  UpdateFieldDisplay();
end;

procedure TdmWeight.CheckOpenDB2;
const
  dbPath = '.\SQLiteTest.sdb';
begin
  if FileExists(dbPath) then
    DeleteFile(dbPath);

  with FDConnection1 do begin
    Params.Add('DriverID=SQLite');
    Params.Add('Database=' + dbPath);
    Connected := True;
  end;

  with FDCommand1.CommandText do begin
    Add('CREATE TABLE MyTable(');
    Add('ID integer PRIMARY KEY,'); //Integer 类型, 同时设为主键
    Add('Name string(10),');        //能容下 10 个字符的 String 类型
    Add('Age byte,');               //Byte 类型
    Add('Note text,');              //Memo 类型
    Add('Picture blob');            //Blob(二进制)类型
    Add(')');
  end;
  FDCommand1.Active := True;


  {查看表}
  //FDQuery1.Open('SELECT * FROM MyTable');
  //UpdateFieldDisplay();
end;

constructor TdmWeight.Create(AOwner: TComponent);
begin
  inherited;
  CheckOpenDB();
//  CheckOpenDB2();
end;

procedure TdmWeight.DataModuleCreate(Sender: TObject);
begin
//   CREATE TABLE testtable (
//	[ID] INTEGER PRIMARY KEY,
//	[OtherID] INTEGER NULL,
//    	[Name] VARCHAR (255),
//	[Number] FLOAT,
//	[notes] BLOB,
//	[picture] BLOB COLLATE NOCASE)
//---------------------
end;

function TdmWeight.DB_2Record(var Value: TWeightInfo): Boolean;
begin
  Result:= False;

  if FDQuery1.Active and (FDQuery1.RecNo > 0) then
  begin
////    Value.Auth.MainfestNo:= FDQuery1.FieldByName(CONST_FIELDNAME_MAINFESTNO).Value;
////    Value.Auth.PlateNum:= FDQuery1.FieldByName(CONST_FIELDNAME_PLATELIC).Value;
////    Value.Auth.DriverName:= FDQuery1.FieldByName(CONST_FIELDNAME_DRIVERNAME).Value;
////    Value.Auth.DriverIDC:= FDQuery1.FieldByName(CONST_FIELDNAME_DRIVERIDC).Value;
//
//    Value.Auth.MainfestNo:= FDQuery1[CONST_FIELDNAME_MAINFESTNO];
//    Value.Auth.PlateNum:= FDQuery1[CONST_FIELDNAME_PLATELIC];
//    Value.Auth.DriverName:= FDQuery1[CONST_FIELDNAME_DRIVERNAME];
//    Value.Auth.DriverIDC:= FDQuery1[CONST_FIELDNAME_DRIVERIDC];
//
//
//    Value.Mesure.WeightBridge:= CheckNullDef(FDQuery1[CONST_FIELDNAME_WEIGHTBRIDGENO], '');
//
//
//    Value.Mesure.Gross.Valid:= FDQuery1[CONST_FIELDNAME_WEIGHTGROSSVALID];
//    if Value.Mesure.Gross.Valid then
//    begin
//      Value.Mesure.Gross.Wegiht_KG:= FDQuery1[CONST_FIELDNAME_WEIGHTGROSS];
//      Value.Mesure.Gross.WegihtTime:= FDQuery1[CONST_FIELDNAME_WEIGHTGROSSTIME];
//    end;
//
//    Value.Mesure.Tare.Valid:= FDQuery1[CONST_FIELDNAME_WEIGHTTAREVALID];
//    if Value.Mesure.Tare.Valid then
//    begin
//      Value.Mesure.Tare.Wegiht_KG:= FDQuery1[CONST_FIELDNAME_WEIGHTARE];
//      Value.Mesure.Tare.WegihtTime:= FDQuery1[CONST_FIELDNAME_WEIGHTTARETIME];
//    end;
//
//    value.Mesure.Note:= CheckNullDef(FDQuery1[CONST_FIELDNAME_NOTE], '');;
//    Result:= True;
    Result:= DB_Mainfest2Record(FDQuery1[CONST_FIELDNAME_MAINFESTNO], Value);
  end;
end;

//function TdmWeight.DB_2Record(const MainfestNo: String;
//  var Value: TWeightInfo): Boolean;
////var
////  bs: TBookmark;
//begin
//  Result:= False;
//  FDQuery1.DisableControls;
//  try
////    bs:= FDQuery1.Bookmark;
//
//    if FDQuery1.Locate(CONST_FIELDNAME_MAINFESTNO, MainfestNo) then
//    begin
//      Result:= DB_2Record(Value);
//    end;
////    FDQuery1.GotoBookmark(bs);
//  finally
//    FDQuery1.EnableControls;
//  end;
//end;

function TdmWeight.DB_InsertAuthInfo(const Value: TWeightAuth): Integer;

begin
  Result:= -1;

  FDQuery1.DisableControls();
  try
    if not DB_MainfestExist(Value.MainfestNo) then
    begin
      FDQuery1.Append();
      FDQuery1.FieldByName(CONST_FIELDNAME_MAINFESTNO).Value:= Value.MainfestNo;
      FDQuery1.FieldByName(CONST_FIELDNAME_PLATELIC).Value:= Value.PlateNum;
      FDQuery1.FieldByName(CONST_FIELDNAME_DRIVERNAME).Value:= Value.DriverName;
      FDQuery1.FieldByName(CONST_FIELDNAME_DRIVERIDC).Value:= Value.DriverIDC;
      FDQuery1.Post;
      Result:= 0;
    end
    else
    Begin
      raise Exception.Create('认证的联单编号已经认证过：' + Value.MainfestNo);
    End;
  finally
    FDQuery1.EnableControls();
  end;
end;



function TdmWeight.DB_Mainfest2Record(const MainfestNo: String;
  var Value: TWeightInfo): Boolean;
var
  V: Variant;
begin
  Result:= False;

  if FDQuery1.Active and (FDQuery1.RecNo > 0) then
  begin
    V:= FDQuery1.Lookup(CONST_FIELDNAME_MAINFESTNO, MainfestNo,
      CONST_FIELDNAME_MAINFESTNO  + '; ' +
      CONST_FIELDNAME_PLATELIC    + '; ' +
      CONST_FIELDNAME_DRIVERNAME  + '; ' +
      CONST_FIELDNAME_DRIVERIDC   + '; ' +

      CONST_FIELDNAME_WEIGHTBRIDGENO  + '; ' +

      CONST_FIELDNAME_WEIGHTGROSSVALID  + '; ' +
      CONST_FIELDNAME_WEIGHTGROSS       + '; ' +
      CONST_FIELDNAME_WEIGHTGROSSTIME   + '; ' +

      CONST_FIELDNAME_WEIGHTTAREVALID  + '; ' +
      CONST_FIELDNAME_WEIGHTARE       + '; ' +
      CONST_FIELDNAME_WEIGHTTARETIME   + '; ' +

      CONST_FIELDNAME_NOTE
      );


    if Not VarIsNull(V) then
    begin
      Value.Auth.MainfestNo:= V[0];
      Value.Auth.PlateNum:= V[1];
      Value.Auth.DriverName:= V[2];
      Value.Auth.DriverIDC:= V[3];

      Value.Mesure.WeightBridge:= CheckNullDef(V[4], '');

      Value.Mesure.Gross.Valid:= V[5];
      if Value.Mesure.Gross.Valid then
      begin
        Value.Mesure.Gross.Wegiht_KG:= V[6];
        Value.Mesure.Gross.WegihtTime:= V[7];
      end;

      Value.Mesure.Tare.Valid:= V[8];
      if Value.Mesure.Tare.Valid then
      begin
        Value.Mesure.Tare.Wegiht_KG:= V[9];
        Value.Mesure.Tare.WegihtTime:= V[10];
      end;

      Value.Mesure.Note:= CheckNullDef(V[11], '');;

      Result:= True;
    end;

  end;
end;

function TdmWeight.DB_MainfestExist(const MainfestNo: String): Boolean;
begin
  Result:= Not VarIsNull(FDQuery1.Lookup(CONST_FIELDNAME_MAINFESTNO, MainfestNo, CONST_FIELDNAME_ID));
end;

procedure TdmWeight.UpdateFieldDisplay();
type
  TFieldDispInfo = Record
    FieldName: String;
    DisplayLabel: String;
    DisplayWidth: Integer;
  end;
var
  AList: TArray<TFieldDispInfo>;
  Procedure ListAdd(AName: string; ADisplayText: String; DisplayWidth: Integer);
  var
    AItem: TFieldDispInfo;
  begin
    AItem.FieldName:= AName;
    AItem.DisplayLabel:= ADisplayText;
    AItem.DisplayWidth:= DisplayWidth;

    Insert(AItem, AList, 0);
  end;
var
  i: Integer;
  AFieldName: String;
  AField: TField;

begin
  ListAdd('ID'              ,'ID'             , 5);
  ListAdd('MainfestNo'      ,'联单编码'       , 15);
  ListAdd('PlateLic'        ,'车牌号'         , 30);
  ListAdd('DriverName'      , '驾驶员姓名'    , 10);
  ListAdd('DriverIDC'       ,'驾驶员身份证号' , 20);
  ListAdd('WeighBridgeNo'   ,'地磅编号'       , 5);
  ListAdd('WeightGross'     ,'毛重'           , 10);
  ListAdd('WeightGrossTime' ,'毛重时间'       , 20);
  ListAdd('WeightTareValid' ,'皮重有效'       , 2 );
  ListAdd('WeightTare'      ,'皮重'           , 10);
  ListAdd('WeightTareTime'  ,'皮重时间'       , 20);
  ListAdd('WeightGrossvalid','毛重有效'      , 2);
  ListAdd('Note'            ,'备注'           , 50);



  for i := 0 to Length(AList) - 1 do
  begin
    AField:= FDQuery1.FindField(AList[i].FieldName);
    if AField <> nil then
    begin
      AField.DisplayLabel:= AList[i].DisplayLabel;
      AField.DisplayWidth:= AList[i].DisplayWidth;
    end;
  end;
end;

end.
