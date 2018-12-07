unit u_DMWeight;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.SQLite, u_WeightComm;

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
    Function DB_InsertAuthInfo(const Value: TWeightAuth): Integer;
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


  {�鿴��}
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
    Add('ID integer PRIMARY KEY,'); //Integer ����, ͬʱ��Ϊ����
    Add('Name string(10),');        //������ 10 ���ַ��� String ����
    Add('Age byte,');               //Byte ����
    Add('Note text,');              //Memo ����
    Add('Picture blob');            //Blob(������)����
    Add(')');
  end;
  FDCommand1.Active := True;


  {�鿴��}
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

function TdmWeight.DB_InsertAuthInfo(const Value: TWeightAuth): Integer;
begin
  Result:= -1;

  FDQuery1.DisableControls();
  try
    if Not FDQuery1.Locate(CONST_FIELDNAME_MAINFESTNO, Value.MainfestNo) then
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
      raise Exception.Create('��֤����������Ѿ���֤����' + Value.MainfestNo);
    End;
  finally
    FDQuery1.EnableControls();
  end;
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
  ListAdd('MainfestNo'      ,'��������'       , 15);
  ListAdd('PlateLic'        ,'���ƺ�'         , 30);
  ListAdd('DriverName'      , '��ʻԱ����'    , 10);
  ListAdd('DriverIDC'       ,'��ʻԱ���֤��' , 20);
  ListAdd('WeighBridgeNo'   ,'�ذ����'       , 5);
  ListAdd('WeightGross'     ,'ë��'           , 10);
  ListAdd('WeightGrossTime' ,'ë��ʱ��'       , 20);
  ListAdd('WeightTareValid' ,'Ƥ����Ч'       , 2 );
  ListAdd('WeightTare'      ,'Ƥ��'           , 10);
  ListAdd('WeightTareTime'  ,'Ƥ��ʱ��'       , 20);
  ListAdd('WeightGrossvalid','ë����Ч'      , 2);
  ListAdd('Note'            ,'��ע'           , 50);



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
