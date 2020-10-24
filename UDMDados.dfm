object DMDados: TDMDados
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 169
  Width = 350
  object FDConn: TFDConnection
    Params.Strings = (
      'Database=TESTEDELPHI'
      'User_Name=root'
      'Password=1234abc@'
      'Server=127.0.0.1'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 64
    Top = 48
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 248
    Top = 17
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 128
    Top = 16
  end
  object FDQryPedido: TFDQuery
    Connection = FDConn
    Left = 152
    Top = 96
  end
end
