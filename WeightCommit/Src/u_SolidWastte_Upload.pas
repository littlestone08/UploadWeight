unit u_SolidWastte_Upload;

interface
uses
  Classes, SysUtils, Math, SolidWasteService, Json, StrUtils, u_WeightComm;

  function SolidWastte_Desc(RetCode: Byte): String;

  Function SolidWaste_Auth(const AuthInfo: TWeightAuth): Integer;
  Function SolidWaste_Commit(const CommitInfo: TWeightInfo): Integer;
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
    {$IFDEF EMU_NET}
      Result:= 1;
    {$ELSE}
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
    {$ENDIF}
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

  Function SolidWaste_Auth(const AuthInfo: TWeightAuth): Integer;
  var
    jso: TJSONObject;
    jsoBody: TJSONObject;
    EscapedBody: String;
  begin
    Result:= -1;

    jso:= TJSONObject.Create;
    try
      jsoBody:= TJSONObject.Create;
      with jsoBody do
      begin

        AddPair('mainifestNo', AuthInfo.MainfestNo);
        AddPair('plateNumber', AuthInfo.PlateNum);
        AddPair('driverIdentityCardNo', AuthInfo.DriverIDC);
        AddPair('driverName', AuthInfo.DriverName);
      end;

      jso.AddPair('token','1a523260ca71c085f4e2655ec524ec54cd74a0deee91fcaa21181d'+
                          '7470e121af6e2cbd74418c0487e141f65879003a509db79fe196e5'+
                          '7e2b5d6486a10cecdc2bf9ec06ae4f90cf9903a3146dbfcbb758e3'+
                          'a1b35d18cc4954a22c7c62ba18357eca7c264387cf94cfc87203b9'+
                          '3f382b05e92fb75ce90833fd7f3d2938dbfd08fe');
      jso.AddPair('msgType', '10001');

      EscapedBody:= jsoBody.ToString;
      EscapedBody:= ReplaceText(EscapedBody, '"', '''');
      jso.AddPair('msgBody', EscapedBody);


      Result:= SolidWastte_Upload(jso.ToString);
      With MultiLineLog do
      begin
        AddLine('----------�ύ����----------');
        Log(jso.ToString);
        AddLine('----------������: ' + SolidWastte_Desc(Result) + '----------');
        Flush;
      end;

    finally
      jso.Free;
    end;

  end;

  Function SolidWaste_Commit(const CommitInfo: TWeightInfo): Integer;
  var
    jso: TJSONObject;
    jsoBody: TJSONObject;
    Ret: Integer;
    EscapedBody: String;
  begin
    Result:= -1;

    jso:= TJSONObject.Create;
    try
      jsoBody:= TJSONObject.Create;
      with jsoBody do
      begin
        AddPair('mainifestNo', CommitInfo.Auth.MainfestNo);
        AddPair('plateNumber', CommitInfo.Auth.PlateNum);
        AddPair('driverIdentityCardNo', CommitInfo.Auth.DriverIDC);
        AddPair('driverName', CommitInfo.Auth.DriverName);

        AddPair('grossWeight', Format('%.2f', [CommitInfo.Mesure.Gross.Wegiht_KG]));
        AddPair('grossWeightWeighingTime', FormatDateTime('YYYY-MM-DD HH:NN:SS', CommitInfo.Mesure.Gross.WegihtTime));
        AddPair('tare', Format('%.2f', [CommitInfo.Mesure.Tare.Wegiht_KG]));
        AddPair('tareWeighingTime', FormatDateTime('YYYY-MM-DD HH:NN:SS', CommitInfo.Mesure.Tare.WegihtTime));

        AddPair('rem', CommitInfo.Mesure.Note);
      end;

      jso.AddPair('token','1a523260ca71c085f4e2655ec524ec54cd74a0deee91fcaa21181d'+
                          '7470e121af6e2cbd74418c0487e141f65879003a509db79fe196e5'+
                          '7e2b5d6486a10cecdc2bf9ec06ae4f90cf9903a3146dbfcbb758e3'+
                          'a1b35d18cc4954a22c7c62ba18357eca7c264387cf94cfc87203b9'+
                          '3f382b05e92fb75ce90833fd7f3d2938dbfd08fe');
      jso.AddPair('msgType', '10002');


      EscapedBody:= jsoBody.ToString;
      EscapedBody:= ReplaceText(EscapedBody, '"', '''');
      jso.AddPair('msgBody', EscapedBody);

      Ret:= SolidWastte_Upload(jso.ToString);

      With MultiLineLog do
      begin
        AddLine('----------�ύ����----------');
        Log(jso.ToString);
        AddLine('----------������: ' + Ret.ToString + '----------');
        Flush;
      end;
    finally
      jso.Free;
    end;
  end;
initialization
finalization
  if g_RetPaire <> NIl then
    FreeAndNil(g_RetPaire);
end.
