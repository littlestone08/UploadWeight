object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 311
  ClientWidth = 834
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    834
    311)
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 32
    Top = 8
    Width = 393
    Height = 209
    Lines.Strings = (
      '//'#20363'4:'
      'Data = {"name":"'#24352#19977'", "age":19, "like":["'#28216#25103'","'#36275#29699'"]};'
      'str = Data.like[1];    //'#36275#29699
      'str = Data["like"][1]; //'#36275#29699)
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 32
    Top = 240
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object Button1: TButton
    Left = 200
    Top = 238
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 432
    Top = 238
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 3
    OnClick = Button2Click
  end
  object MemoOut: TMemo
    Left = 431
    Top = 8
    Width = 386
    Height = 209
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'MemoOut')
    ScrollBars = ssVertical
    TabOrder = 4
  end
  object Button3: TButton
    Left = 568
    Top = 238
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 5
    OnClick = Button3Click
  end
  object HTTPRIO1: THTTPRIO
    WSDLLocation = 'http://211.90.38.54:18282/WebService/SolidWasteService?wsdl'
    HTTPWebNode.UseUTF8InHeader = True
    HTTPWebNode.InvokeOptions = [soIgnoreInvalidCerts, soAutoCheckAccessPointViaUDDI]
    HTTPWebNode.WebNodeOptions = []
    Converter.Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody, soCacheMimeResponse, soUTF8EncodeXML]
    Left = 408
    Top = 152
  end
end
