unit UProduto;

interface

uses
  Generics.Collections, FireDAC.Comp.Client, System.SysUtils;

type
  TProduto = class
  private
    FCodigo: Integer;
    FDescricao: String;
    FPreco: Currency;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Descricao: String read FDescricao write FDescricao;
    property Preco: Currency read FPreco write FPreco;
    constructor Create; overload;
    constructor Create(ACodigo: Integer; ADescricao: String; APreco: Currency); overload;
    class function ListProdutos: TList<TProduto>;
  end;

implementation

{ TProduto }

uses UDMDados;

constructor TProduto.Create(ACodigo: Integer; ADescricao: String; APreco: Currency);
begin
  FCodigo := ACodigo;
  FDescricao := ADescricao;
  FPreco := APreco;
end;

constructor TProduto.Create;
begin

end;

class function TProduto.ListProdutos: TList<TProduto>;
var
  _qry: TFDQuery;
begin
  _qry := TFDQuery.Create(nil);
  Result := TList<TProduto>.Create;
  try
    try
      _qry.Connection := DMDados.FDConn;
      _qry.SQL.Add('SELECT CODIGO, DESCRICAO, PRECO FROM TESTEDELPHI.PRODUTOS ORDER BY CODIGO');
      _qry.Open;
      _qry.First;
      while not _qry.Eof do
      begin
        Result.Add(TProduto.Create(_qry.Fields[0].AsInteger, _qry.Fields[1].AsString, _qry.Fields[2].AsCurrency));
        _qry.Next;
      end;
    except
      raise Exception.Create('Erro ao carrear os produtos.');
    end;
  finally
    _qry.DisposeOf;
  end;
end;

end.
