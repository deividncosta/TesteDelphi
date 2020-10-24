unit UCliente;

interface

uses
  Generics.Collections, FireDAC.Comp.Client, System.SysUtils;

type
  TCliente = class
  private
    FCodigo: Integer;
    FNome: String;
    FCidade: String;
    FUF: String;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Nome: String read FNome write FNome;
    property Cidade: String read FCidade write FCidade;
    property UF: String read FUF write FUF;
    constructor Create; overload;
    constructor Create(ACodigo: Integer; ANome, ACidade, AUF: String); overload;
    class function ListCliente: TList<TCliente>;
  end;

implementation

{ TCliente }

uses UDMDados;

constructor TCliente.Create(ACodigo: Integer; ANome, ACidade, AUF: String);
begin
  FCodigo := ACodigo;
  FNome := ANome;
  FCidade := ACidade;
  FUF := AUF;
end;

constructor TCliente.Create;
begin

end;

class function TCliente.ListCliente: TList<TCliente>;
var
  _qry: TFDQuery;
begin
  _qry := TFDQuery.Create(nil);
  Result := TList<TCliente>.Create;
  try
    try
      _qry.Connection := DMDados.FDConn;
      _qry.SQL.Add('SELECT CODIGO, NOME, CIDADE, UF FROM TESTEDELPHI.CLIENTES ORDER BY CODIGO');
      _qry.Open;
      _qry.First;
      while not _qry.Eof do
      begin
        Result.Add(TCliente.Create(_qry.Fields[0].AsInteger, _qry.Fields[1].AsString, _qry.Fields[2].AsString, _qry.Fields[3].AsString));
        _qry.Next;
      end;
    except
      raise Exception.Create('Erro ao carregar os clientes.');
    end;
  finally
    _qry.DisposeOf;
  end;
end;

end.
