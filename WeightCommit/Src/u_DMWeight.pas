unit u_DMWeight;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.SQLite;

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
    Procedure CheckOpenDB;
    Procedure CheckOpenDB2;
    Procedure UpdateFieldDisplay();
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

var
  dmWeight: TdmWeight;

implementation
uses
  System.Generics.Collections ,CnCommon;
const
  CONST_DBFILENAME  = 'SQLTest.sdb';
  CONST_TABLENAME  = 'WeightInfo';

{$R *.dfm}

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
                              'ID integer PRIMARY KEY,'     +
                              'MainfestNo string(500), '     +
                              'PlateLic string(50), '       +
                              'DriverName string(10), '     +
                              'DriverIDC string(20), '      +
                              'WeighBridgeNo string(10), '  +
                              'WeightGross float, '         +
                              'WeightGrossTime DATETIME, '  +
                              'WeightGrossValid bit default 0, '    +
                              'WeightTare float, '          +
                              'WeightTareTime DATETIME, '   +
                              'WeightTareValid bit default 0, '     +
                              'Note string(100)'            +
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
