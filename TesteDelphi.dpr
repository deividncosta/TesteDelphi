program TesteDelphi;

uses
  System.StartUpCopy,
  FMX.Forms,
  unPrincipal in 'unPrincipal.pas' {frmPrincipal},
  UCliente in 'UCliente.pas',
  UProduto in 'UProduto.pas',
  UVenda in 'UVenda.pas',
  UDMDados in 'UDMDados.pas' {DMDados: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDMDados, DMDados);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
