unit UVenda;

interface

uses
  UCliente, UProduto, Generics.Collections;

type
  TVenda = class
  private
    FCliente: TCliente;
    FProdutos: TList<TProduto>;
  public
    property Cliente: TCliente read FCliente write FCliente;
    property Produtos: TList<TProduto> read FProdutos write FProdutos;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TVenda }

constructor TVenda.Create;
begin
  FCliente := TCliente.Create;
  FProdutos := TList<TProduto>.Create;
end;

destructor TVenda.Destroy;
begin
  FCliente.DisposeOf;
  FProdutos.DisposeOf;
  inherited;
end;

end.
