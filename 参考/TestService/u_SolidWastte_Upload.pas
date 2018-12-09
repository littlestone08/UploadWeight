unit u_SolidWastte_Upload;

interface
uses
  Classes, SysUtils, Math, SolidWasteService, Json, StrUtils;

  Function SolidWastte_Upload(const Info: String): Integer;
  function SolidWastte_Desc(RetCode: Byte): String;

implementation
uses
  u_Log;
var
  g_Intf: ISolidWasteService;
  g_RetPaire: JSon.TJSONObject;

  Function SolidWastte_Upload(const Info: String): Integer;
  var
    Log: IMultiLineLog;
    RetStr: String;
  begin
    try
      With MultiLineLog do
      begin
        AddLine('------------------------------------');
        AddLine('���ݣ�'#$D#$A+ Info);


        Result:= -1;
        if g_Intf = Nil then
        begin
          g_Intf:= GetISolidWasteService;
        end;

        if g_RetPaire = Nil then
        begin
          g_RetPaire:= TJSONObject.Create;
        end;

        RetStr:= g_Intf.process(Info);
        With TJSONObject.ParseJSONValue(Trim(RetStr )) as TJSONObject do
        begin
          AddLine('����ֵ��' + RetStr);

          RetStr:= (GetValue('obj') as TJSONString).Value;


          Result:= StrToIntDef(RetStr, -1);
          AddLine('����ֵ��' + IntToStr(Result));
          Free;
        end;
        AddLine('------------------------------------');
        Flush();
      end;
    except
      On E: Exception do
      begin
        u_Log.Log(Format('�����쳣: %s : %s', [E.ClassName, e.Message]));
      end;
    end;
  end;



  function SolidWastte_Desc(RetCode: Byte): String;
  const
    CONST_DESC_ARR: Array[0..7] of String = (
      '001��ִ�гɹ���֤ͨ��',
      '002���������ӿڷ����쳣',
      '003����������ȷ',
      '004����ҵ��ݱ�ʶ���Ϸ���ƽ̨�����Ψһtoken��',
      '005������������Ų�����',
      '006�����Ƽ���ʻԱ��Ϣ��ת��������Ϣ��һ��',
      '007��������Ϣ��ת��������Ϣ��һ��',
      '008����ʻԱ��Ϣ��ת��������Ϣ��һ��'
    );
  begin
    if InRange(RetCode - 1, Low(CONST_DESC_ARR), High(CONST_DESC_ARR)) then
    begin
      Result:= CONST_DESC_ARR[RetCode - 1];
    end
    else
    begin
      Result:= Format('%-0.3d: δ����ķ�����', [RetCode]);
    end;
  end;

initialization
finalization
  if g_RetPaire <> NIl then
    FreeAndNil(g_RetPaire);
end.
