unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  StrUtils,
  Dialogs, StdCtrls, Soap.InvokeRegistry, Soap.Rio, Soap.SOAPHTTPClient;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    MemoOut: TMemo;
    HTTPRIO1: THTTPRIO;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation


{$R *.dfm}

uses ComObj, json, SolidWasteService, u_SolidWastte_Upload;

{ �˺�����Ҫ ComObj ��Ԫ��֧�� }
{ ���� JsCode ��Ҫִ�е� Js ����; ���� JsVar ��Ҫ���صı��� }
function RunJs(const JsCode, JsVar: string): string;
var
  script: OleVariant;
begin
  try
    script := CreateOleObject('scriptControl');
    script.Language := 'javaScript';
    script.ExecuteStatement(JsCode);
    Result := script.Eval(JsVar);
  except
    Result := '';
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  s: string;
begin
  s := RunJs(Memo1.Text, 'str');
  ShowMessage(s);
end;

//ʹ��ϵͳ�Դ���JSON������
const
  // ��ʾ�õ�JSON
  jsonString = ' {"name":"����", "age":19, "like":["��Ϸ","����"]}';

procedure TForm1.Button2Click(Sender: TObject);
var
  JSONObject: TJSONObject; // JSON��
  i: Integer; // ѭ������
  temp: string; // ��ʱʹ�ñ���
  jsonArray: TJSONArray; // JSON�������
begin
  try
    { ���ַ�������JSON }
    JSONObject := TJSONObject.ParseJSONValue(Trim(jsonString)) as TJSONObject;
    if JSONObject.Count > 0 then
    begin
      { 1,����JSON���� }
      MemoOut.Lines.Add('����JSON���ݣ�' + #13#10);
      MemoOut.Lines.Add('JSON����������' + IntToStr(JSONObject.Count));
      for i := 0 to JSONObject.Count - 1 do
      begin
        if i = 0 then
        begin
          temp := JSONObject.Get(i).ToString + #13#10;;
        end
        else
        begin
          temp := temp + JSONObject.Get(i).ToString + #13#10;
        end;
      end;
      { output the JSON to console as String }
      MemoOut.Lines.Add(temp);
      MemoOut.Lines.Add('------------------------------');
      { 2,��Ԫ�ؽ���JSON���� }
      MemoOut.Lines.Add('��Ԫ�ؽ���JSON���ݣ�' + #13#10);
      temp := 'name = ' + JSONObject.Values['name'].ToString + #13#10;

      MemoOut.Lines.Add(temp);
      // json����
      if JSONObject.GetValue('like') is TJSONArray then
      begin
        jsonArray := TJSONArray(JSONObject.GetValue('like'));;
        if jsonArray.Count > 0 then
        begin
          // �õ�JSON�����ַ���
          temp := 'like = ' + JSONObject.GetValue('like').ToString + #13#10;
          // ѭ��ȡ��JSON������ÿ��Ԫ��
          for i := 0 to jsonArray.Size - 1 do
          begin
            temp := temp + IntToStr(i + 1) + ' : ' + jsonArray.Items[i]
              .Value + #13#10;
          end;
        end;
        MemoOut.Lines.Add(temp);
      end;
    end
    else
    begin
      temp := 'û�����ݣ�';
      MemoOut.Lines.Add(temp);
    end;
  finally
    JSONObject.Free;
  end;

end;

procedure TForm1.Button3Click(Sender: TObject);
var
  jso: TJSONObject;
  jsoBody: TJSONObject;
  Ret: Integer;
  EscapedBody: String;
begin

  jso:= TJSONObject.Create;
  try
    jsoBody:= TJSONObject.Create;
    with jsoBody do
    begin
      AddPair('mainifestNo', '350201201709080001');
      AddPair('plateNumber', '��AAAAAA');
      AddPair('driverIdentityCardNo', '320123456789012345');
      AddPair('driverName', '����');
    end;

    jso.AddPair('token', '57da9a9249ad64146273edea3010118077e3');
    jso.AddPair('msgType', '10001');
    //Caption:= (jso.Values['msgType'] as TJsonString).value;

    EscapedBody:= jsoBody.ToString;
    EscapedBody:= ReplaceText(EscapedBody, '"', '''');
    MemoOut.Lines.Add(EscapedBody);

    //EscapedBody:= StrUtils.ReplaceText(EscapedBody, '\"', '''');
    jso.AddPair('msgBody', EscapedBody);

    //MemoOut.Lines.Add(jso.ToJSON());
    //------------------
    MemoOut.Lines.Add(jso.ToString());

    Ret:= SolidWastte_Upload(jso.ToString);
    MemoOut.Lines.Add(SolidWastte_Desc(Ret));

    //---------------------


  finally
    jso.Free;
  end;

//  Intf:= GetISolidWasteService;
//  Ret:= Intf.process('here is a test');
//  MemoOut.Lines.Add(Ret);
end;


end.
