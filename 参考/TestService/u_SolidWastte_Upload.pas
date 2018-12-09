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
        AddLine('数据：'#$D#$A+ Info);


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
          AddLine('返回值：' + RetStr);

          RetStr:= (GetValue('obj') as TJSONString).Value;


          Result:= StrToIntDef(RetStr, -1);
          AddLine('解析值：' + IntToStr(Result));
          Free;
        end;
        AddLine('------------------------------------');
        Flush();
      end;
    except
      On E: Exception do
      begin
        u_Log.Log(Format('发生异常: %s : %s', [E.ClassName, e.Message]));
      end;
    end;
  end;



  function SolidWastte_Desc(RetCode: Byte): String;
  const
    CONST_DESC_ARR: Array[0..7] of String = (
      '001：执行成功验证通过',
      '002：服务器接口发生异常',
      '003：参数不正确',
      '004：企业身份标识不合法（平台分配的唯一token）',
      '005：电子联单编号不存在',
      '006：车牌及驾驶员信息与转移联单信息不一致',
      '007：车牌信息与转移联单信息不一致',
      '008：驾驶员信息与转移联单信息不一致'
    );
  begin
    if InRange(RetCode - 1, Low(CONST_DESC_ARR), High(CONST_DESC_ARR)) then
    begin
      Result:= CONST_DESC_ARR[RetCode - 1];
    end
    else
    begin
      Result:= Format('%-0.3d: 未定义的返回码', [RetCode]);
    end;
  end;

initialization
finalization
  if g_RetPaire <> NIl then
    FreeAndNil(g_RetPaire);
end.
