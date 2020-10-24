unit unPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts, FMX.Objects, System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Edit, FMX.Ani, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.TabControl, System.Actions,
  FMX.ActnList;

type
  TfrmPrincipal = class(TForm)
    lytTopo: TLayout;
    lytRodape: TLayout;
    lytGrid: TLayout;
    StyleBook1: TStyleBook;
    rectFundoTopo: TRectangle;
    rectRodape: TRectangle;
    circleLogo1: TCircle;
    circleLogo2: TCircle;
    txtTitulo: TText;
    txtNome: TText;
    RectAnimation1: TRectAnimation;
    rectTituloGrid: TRectangle;
    txtProduto: TText;
    rectBtnAdd: TRectangle;
    AnimationAdd: TColorAnimation;
    txtAdd: TText;
    gridPedido: TStringGrid;
    rectVlTotal: TRectangle;
    txtVlTotal: TText;
    rectProduto: TRectangle;
    edtProduto: TEdit;
    AnimationProduto: TColorAnimation;
    rectQuantidade: TRectangle;
    edtQuantidade: TEdit;
    AnimationQuantidade: TColorAnimation;
    rectPreco: TRectangle;
    edtPreco: TEdit;
    AnimationPreco: TColorAnimation;
    FDMemCliente: TFDMemTable;
    FDMemClienteCodigo: TIntegerField;
    FDMemClienteNome: TStringField;
    FDMemClienteCidade: TStringField;
    FDMemClienteUF: TStringField;
    FDMemProduto: TFDMemTable;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    FDMemProdutoPreco: TCurrencyField;
    FDMemPedido: TFDMemTable;
    FDMemPedidoCliente: TIntegerField;
    FDMemPedidoDescricao: TStringField;
    FDMemPedidoQuantidade: TIntegerField;
    FDMemPedidoUnitario: TCurrencyField;
    FDMemPedidoTotal: TCurrencyField;
    FDMemPedidoCodigo: TIntegerField;
    ColumnCodigo: TIntegerColumn;
    ColumnDescricao: TStringColumn;
    ColumnQuantidade: TIntegerColumn;
    ColumnUnitario: TCurrencyColumn;
    ColumnTotal: TCurrencyColumn;
    FDMemPedidoGUID: TStringField;
    ColumnGUID: TStringColumn;
    rectGravar: TRectangle;
    AnimationGravar: TColorAnimation;
    txtGravar: TText;
    txtStatus: TText;
    TimerStatus: TTimer;
    tabControlEditar: TTabControl;
    tabEditar: TTabItem;
    TabNumero: TTabItem;
    rectEditar: TRectangle;
    AnimationEditar: TColorAnimation;
    txtEdiatar: TText;
    rectClient: TRectangle;
    edtCliente: TEdit;
    AnimationCliente: TColorAnimation;
    rectNumeroPedido: TRectangle;
    edtNumeroPedido: TEdit;
    AnimationNumeroPedido: TColorAnimation;
    TabExcluir: TTabItem;
    recExcluir: TRectangle;
    AnimationExcluir: TColorAnimation;
    txtExcluir: TText;
    actListEditar: TActionList;
    TabVazio: TTabItem;
    actVazio: TChangeTabAction;
    actEditar: TChangeTabAction;
    actNumero: TChangeTabAction;
    actExcluir: TChangeTabAction;
    procedure rectClientMouseEnter(Sender: TObject);
    procedure rectClientMouseLeave(Sender: TObject);
    procedure rectQuantidadeMouseEnter(Sender: TObject);
    procedure rectQuantidadeMouseLeave(Sender: TObject);
    procedure rectProdutoMouseEnter(Sender: TObject);
    procedure rectProdutoMouseLeave(Sender: TObject);
    procedure edtPrecoMouseEnter(Sender: TObject);
    procedure edtPrecoMouseLeave(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtClienteKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure edtClienteClick(Sender: TObject);
    procedure rectBtnAddClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure gridPedidoCellDblClick(const Column: TColumn; const Row: Integer);
    procedure rectGravarClick(Sender: TObject);
    procedure TimerStatusTimer(Sender: TObject);
    procedure edtNumeroPedidoMouseEnter(Sender: TObject);
    procedure edtNumeroPedidoMouseLeave(Sender: TObject);
    procedure edtClienteChangeTracking(Sender: TObject);
    procedure rectEditarClick(Sender: TObject);
    procedure edtNumeroPedidoClick(Sender: TObject);
    procedure recExcluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarClientes;
    procedure CarregarProdutos;
    function SomenteNumero(Key: Char; Texto: String; IsDecimal: Boolean = False): Char;
    function CalcularTotalPedido: Currency;
    procedure CarregarGrid;
    procedure CarregarPedido(const CODIGO: Integer);
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses UCliente, UProduto, UVenda, UDMDados;

{$REGION 'Animações'}

procedure TfrmPrincipal.rectProdutoMouseEnter(Sender: TObject);
begin
  AnimationProduto.StartValue := TAlphaColorRec.White;
  AnimationProduto.StopValue  := TAlphaColorRec.Black;
  AnimationProduto.Start;
end;

procedure TfrmPrincipal.rectProdutoMouseLeave(Sender: TObject);
begin
  AnimationProduto.StopValue   := TAlphaColorRec.White;
  AnimationProduto.StartValue  := TAlphaColorRec.Black;
  AnimationProduto.Start;
end;

procedure TfrmPrincipal.rectQuantidadeMouseEnter(Sender: TObject);
begin
  AnimationQuantidade.StartValue := TAlphaColorRec.White;
  AnimationQuantidade.StopValue  := TAlphaColorRec.Black;
  AnimationQuantidade.Start;
end;

procedure TfrmPrincipal.rectQuantidadeMouseLeave(Sender: TObject);
begin
  AnimationQuantidade.StopValue   := TAlphaColorRec.White;
  AnimationQuantidade.StartValue  := TAlphaColorRec.Black;
  AnimationQuantidade.Start;
end;

procedure TfrmPrincipal.edtClienteChangeTracking(Sender: TObject);
begin
  if (tabControlEditar.ActiveTab = TabVazio) then
  begin
    if (Trim(edtCliente.Text) <> '') then
      actEditar.Execute
    else
      actVazio.Execute;
  end;
end;

procedure TfrmPrincipal.edtClienteClick(Sender: TObject);
begin
  if txtAdd.Text = 'Atualizar registro' then
    Exit;
  TEdit(Sender).Text := '';
  FDMemPedido.Active := True;
  FDMemPedido.EmptyDataSet;
  gridPedido.RowCount := 0;
  txtVlTotal.Text := 'R$ 0,00';
  actVazio.Execute;
end;

procedure TfrmPrincipal.edtClienteKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if ((KeyChar = #0) and (Key = 13)) then
  begin
    if Trim(TEdit(Sender).Text) = '' then
      Exit;
    if TEdit(Sender).Name = 'edtCliente' then
    begin
      FDMemCliente.Filtered := False;
      FDMemCliente.Filter := 'CODIGO = ' + Trim(edtCliente.Text);
      FDMemCliente.Filtered := True;
      case (FDMemCliente.FieldByName('CODIGO').AsString = '') of
        True:  edtCliente.Text := 'CLIENTE INVÁLIDO';
        False:
        begin
          edtCliente.Text := FDMemCliente.FieldByName('CODIGO').AsString + ' - ' + FDMemCliente.FieldByName('NOME').AsString;
          edtCliente.Tag  := FDMemCliente.FieldByName('CODIGO').AsInteger;
          rectGravar.Visible := True;
          rectBtnAdd.Visible := True;
          edtProduto.SetFocus;
        end;
      end;
    end
    else if TEdit(Sender).Name = 'edtProduto' then
    begin
      if (txtAdd.Text = 'Atualizar registro') then
        Exit;

      FDMemProduto.Filtered := False;
      FDMemProduto.Filter := 'CODIGO = ' + Trim(edtProduto.Text);
      FDMemProduto.Filtered := True;
      case (FDMemProduto.FieldByName('CODIGO').AsString = '') of
        True:  edtProduto.Text := 'PRODUTO INVÁLIDO';
        False:
        begin
          edtProduto.Text := FDMemProduto.FieldByName('CODIGO').AsString + ' - ' + FDMemProduto.FieldByName('DESCRICAO').AsString;
          edtProduto.Tag  := FDMemProduto.FieldByName('CODIGO').AsInteger;
          edtQuantidade.SetFocus;
        end;
      end;
    end
    else if TEdit(Sender).Name = 'edtQuantidade' then
      edtPreco.SetFocus
    else if TEdit(Sender).Name = 'edtPreco' then
    begin
      if Trim(edtPreco.Text) = '' then
        Exit;
      rectBtnAddClick(Sender);
    end
    else if TEdit(Sender).Name = 'edtNumeroPedido' then
      CarregarPedido(TEdit(Sender).Text.ToInteger);
  end
  else if KeyChar = ',' then
  begin
    if TEdit(Sender).Name = 'edtQuantidade' then
      KeyChar := ',';
  end
  else
    KeyChar := SomenteNumero(KeyChar, TEdit(Sender).Text);
end;

procedure TfrmPrincipal.edtPrecoMouseEnter(Sender: TObject);
begin
  AnimationPreco.StartValue := TAlphaColorRec.White;
  AnimationPreco.StopValue  := TAlphaColorRec.Black;
  AnimationPreco.Start;
end;

procedure TfrmPrincipal.edtPrecoMouseLeave(Sender: TObject);
begin
  AnimationPreco.StopValue   := TAlphaColorRec.White;
  AnimationPreco.StartValue  := TAlphaColorRec.Black;
  AnimationPreco.Start;
end;

procedure TfrmPrincipal.recExcluirClick(Sender: TObject);
begin
  try
    with DMDados do
    begin
      FDConn.Connected := True;
      FDConn.StartTransaction;
      FDQryPedido.Close;
      FDQryPedido.SQL.Clear;
      FDQryPedido.SQL.Add('DELETE FROM TESTEDELPHI.PEDIDO_DADOS_GERAIS WHERE NUMERO = :ID');
      FDQryPedido.ParamByName('ID').AsInteger := edtNumeroPedido.Text.ToInteger;
      FDQryPedido.ExecSQL;
      txtStatus.Text := 'Pedido ' + edtNumeroPedido.Text + ' excluido';
      TimerStatus.Enabled := True;
      edtNumeroPedido.Text := '';
      actVazio.Execute;
      edtCliente.Text := '';
      edtCliente.SetFocus;
    end;
  except
    raise Exception.Create('Erro ao excluir pedido');
  end;
end;

procedure TfrmPrincipal.rectBtnAddClick(Sender: TObject);
var
  GUID: TGUID;
begin
  FDMemPedido.Active := True;
  if Trim(edtProduto.Text) = '' then
  begin
    edtProduto.Text := 'INFORME O PRODUTO';
    rectProduto.Stroke.Color := TAlphaColorRec.Orangered;
    Exit;
  end
  else if Trim(edtQuantidade.Text) = '' then
  begin
    edtQuantidade.Text := 'INFORME A QUANTIDADE';
    rectQuantidade.Stroke.Color := TAlphaColorRec.Orangered;
    Exit;
  end
  else if Trim(edtPreco.Text) = '' then
  begin
    edtPreco.Text := 'INFORME O PREÇO';
    rectPreco.Stroke.Color := TAlphaColorRec.Orangered;
    Exit;
  end
  else if Trim(edtCliente.Text) = '' then
  begin
    edtCliente.Text := 'INFORME O CLIENTE';
    rectClient.Stroke.Color := TAlphaColorRec.Orangered;
    Exit;
  end;
  if txtAdd.Text = 'Atualizar registro' then
  begin
    FDMemPedido.Filtered := False;
    FDMemPedido.Filter := 'GUID = ' + QuotedStr(gridPedido.Cells[5, gridPedido.Row]);
    FDMemPedido.Filtered := True;
    if FDMemPedido.RecordCount > 0 then
    begin
      FDMemPedido.Edit;
      FDMemPedidoQuantidade.AsInteger := edtQuantidade.Text.ToInteger;
      FDMemPedidoUnitario.AsCurrency  := StrToCurr(edtPreco.Text);
      FDMemPedidoTotal.AsCurrency     := StrToCurr(edtPreco.Text) * edtQuantidade.Text.ToInteger;
      FDMemPedido.Post;
    end;
    FDMemPedido.Filtered := False;
    CarregarGrid;
  end
  else
  begin
    CreateGUID(GUID);
    FDMemPedido.AppendRecord([
      edtCliente.Tag,
      edtProduto.Tag,
      Trim(Copy(edtProduto.Text, Pos('-', edtProduto.Text) + 1, 100)),
      edtQuantidade.Text.ToInteger,
      StrToCurr(edtPreco.Text),
      StrToCurr(edtPreco.Text) * edtQuantidade.Text.ToInteger,
      GUID.ToString
      ]);
    gridPedido.RowCount := FDMemPedido.RecordCount;
    gridPedido.Cells[0, Pred(gridPedido.RowCount)] := edtProduto.Tag.ToString;
    gridPedido.Cells[1, Pred(gridPedido.RowCount)] := Trim(Copy(edtProduto.Text, Pos('-', edtProduto.Text) + 1, 100));
    gridPedido.Cells[2, Pred(gridPedido.RowCount)] := edtQuantidade.Text;
    gridPedido.Cells[3, Pred(gridPedido.RowCount)] := edtPreco.Text;
    gridPedido.Cells[4, Pred(gridPedido.RowCount)] := CurrToStr(StrToCurr(edtPreco.Text) * edtQuantidade.Text.ToInteger);
    gridPedido.Cells[5, Pred(gridPedido.RowCount)] := GUID.ToString;
  end;
  edtProduto.Text := '';
  edtQuantidade.Text := '';
  edtPreco.Text := '';
  txtVlTotal.Text := formatfloat('R$ #,##0.00', CalcularTotalPedido);
  edtProduto.SetFocus;
  txtAdd.Text := 'Adicionar Produto';
end;

procedure TfrmPrincipal.rectClientMouseEnter(Sender: TObject);
begin
  AnimationCliente.StartValue := TAlphaColorRec.White;
  AnimationCliente.StopValue  := TAlphaColorRec.Black;
  AnimationCliente.Start;
end;

procedure TfrmPrincipal.rectClientMouseLeave(Sender: TObject);
begin
  AnimationCliente.StopValue   := TAlphaColorRec.White;
  AnimationCliente.StartValue  := TAlphaColorRec.Black;
  AnimationCliente.Start;
end;
procedure TfrmPrincipal.rectEditarClick(Sender: TObject);
begin
  actNumero.Execute;
end;

procedure TfrmPrincipal.rectGravarClick(Sender: TObject);
var
  NumeroPedido: Integer;
begin
  try
    with DMDados do
    begin
      FDConn.Connected := True;
      FDConn.StartTransaction;
      FDQryPedido.Close;
      FDQryPedido.SQL.Clear;
      FDQryPedido.SQL.Add('INSERT INTO TESTEDELPHI.PEDIDO_DADOS_GERAIS(CODIGO_CLIENTE, VALOR_TOTAL)');
      FDQryPedido.SQL.Add('VALUES(:CLIENTE, :TOTAL); SELECT @@IDENTITY;');
      FDQryPedido.ParamByName('CLIENTE').AsInteger := FDMemPedidoCliente.AsInteger;
      FDQryPedido.ParamByName('TOTAL').AsCurrency  := CalcularTotalPedido;
      FDQryPedido.Open;
      NumeroPedido := FDQryPedido.Fields[0].AsInteger;
      FDQryPedido.Close;
      FDQryPedido.SQL.Clear;
      FDQryPedido.SQL.Add('INSERT INTO TESTEDELPHI.PEDIDO_PRODUTOS(NUMERO_PEDIDO, CODIGO_PRODUTO, QUANTIDADE, VALOR_UNITARIO, VALOR_TOTAL)');
      FDQryPedido.SQL.Add('VALUES(:PEDIDO, :PRODUTO, :QUANTIDADE, :UNITARIO, :TOTAL)');
      FDMemPedido.First;
      while not FDMemPedido.Eof do
      begin
        FDQryPedido.ParamByName('PEDIDO').AsInteger := NumeroPedido;
        FDQryPedido.ParamByName('PRODUTO').AsInteger := FDMemPedidoCodigo.AsInteger;
        FDQryPedido.ParamByName('QUANTIDADE').AsInteger := FDMemPedidoQuantidade.AsInteger;
        FDQryPedido.ParamByName('UNITARIO').AsCurrency  := FDMemPedidoUnitario.AsInteger;
        FDQryPedido.ParamByName('TOTAL').AsCurrency  := FDMemPedidoTotal.AsCurrency;
        FDQryPedido.ExecSQL;
        FDMemPedido.Next;
      end;
      FDConn.Commit;
      FDMemPedido.EmptyDataSet;
      CarregarGrid;
      edtProduto.Text := '';
      edtQuantidade.Text := '';
      edtPreco.Text := '';
      edtCliente.Text := '';
      edtCliente.SetFocus;
      actVazio.Execute;
      txtStatus.Text := 'Pedido ' + NumeroPedido.ToString + ' gravado!';
      TimerStatus.Enabled := True;
    end;
  except
  begin
    if DMDados.FDConn.InTransaction then
      DMDados.FDConn.Rollback;
    raise Exception.Create('Erro ao gravar pedido.');
  end;
  end;
end;

{$ENDREGION}

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  if DMDados.FDConn.Connected then
  begin
    CarregarClientes;
    CarregarProdutos;
  end;
end;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
  Control : iControl;
  MyControl : TFMXObject;
begin
  Control := frmPrincipal.focused;
  try
    if not Assigned(Control) then
      Exit;
    MyControl := TFmxObject(Control.GetObject);
    if MyControl.Name = 'gridPedido' then
    begin
      if Key = 46 then
      begin
        MessageDlg('Deseja remover o registro?', TMsgDlgType.mtWarning, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0, procedure(const AResult: TModalResult)
        begin
          if AResult = mrYes then
          begin
            FDMemPedido.Filtered := False;
            FDMemPedido.Filter := 'GUID = ' + QuotedStr(gridPedido.Cells[5, gridPedido.Row]);
            FDMemPedido.Filtered := True;
            if FDMemPedido.RecordCount > 0 then
              FDMemPedido.Delete;
            FDMemPedido.Filtered := False;
            CarregarGrid;
          end
          else
            Abort;
        end);
      end;
    end;
  finally
    MyControl := nil;
    Control := nil;
  end;
end;

procedure TfrmPrincipal.gridPedidoCellDblClick(const Column: TColumn; const Row: Integer);
begin
  txtAdd.Text := 'Atualizar registro';
  edtProduto.Text := FDMemPedidoCodigo.ToString + ' - ' + FDMemPedidoDescricao.Text;
  edtQuantidade.Text := FDMemPedidoQuantidade.ToString;
  edtPreco.Text := FDMemPedidoUnitario.ToString;
end;

function TfrmPrincipal.CalcularTotalPedido: Currency;
var
  Valor: Currency;
begin
  FDMemPedido.First;
  Valor := 0;
  while not FDMemPedido.Eof do
  begin
    Valor := Valor + FDMemPedidoTotal.AsCurrency;
    FDMemPedido.Next;
  end;
  Result := Valor;
end;

procedure TfrmPrincipal.CarregarClientes;
var
  Cliente: TCliente;
begin
  FDMemCliente.Active := True;
  for Cliente in TCliente.ListCliente do
    FDMemCliente.AppendRecord([Cliente.Codigo, Cliente.Nome, Cliente.Cidade, Cliente.UF]);
end;

procedure TfrmPrincipal.CarregarGrid;
var
  I: Integer;
begin
  FDMemPedido.First;
  gridPedido.RowCount := 0;
  gridPedido.RowCount := FDMemPedido.RecordCount;
  I := 0;
  while not FDMemPedido.Eof do
  begin
    gridPedido.Cells[0, I] := FDMemPedido.FieldByName('CODIGO').AsString;
    gridPedido.Cells[1, I] := FDMemPedido.FieldByName('DESCRICAO').AsString;
    gridPedido.Cells[2, I] := FDMemPedido.FieldByName('QUANTIDADE').AsString;
    gridPedido.Cells[3, I] := FDMemPedido.FieldByName('UNITARIO').AsString;
    gridPedido.Cells[4, I] := FDMemPedido.FieldByName('TOTAL').AsString;
    gridPedido.Cells[5, I] := FDMemPedido.FieldByName('GUID').AsString;
    Inc(I);
    FDMemPedido.Next;
  end;
  edtProduto.Text := '';
  edtQuantidade.Text := '';
  edtPreco.Text := '';
  txtVlTotal.Text := formatfloat('R$ #,##0.00', CalcularTotalPedido);
  edtProduto.SetFocus;
end;

procedure TfrmPrincipal.CarregarPedido(const CODIGO: Integer);
var
  I: Integer;
begin
  with DMDados do
  begin
    try
      FDQryPedido.Close;
      FDQryPedido.SQL.Clear;
      FDQryPedido.SQL.Add('SELECT C.CODIGO AS CODIGO_CLIENTE, C.NOME, D.CODIGO, D.DESCRICAO, A.QUANTIDADE, A.VALOR_UNITARIO, A.VALOR_TOTAL, B.VALOR_TOTAL AS TOTAL_PEDIDO FROM TESTEDELPHI.PEDIDO_PRODUTOS A');
      FDQryPedido.SQL.Add('INNER JOIN TESTEDELPHI.PEDIDO_DADOS_GERAIS B ON B.NUMERO = A.NUMERO_PEDIDO');
      FDQryPedido.SQL.Add('INNER JOIN TESTEDELPHI.CLIENTES C ON C.CODIGO = B.CODIGO_CLIENTE');
      FDQryPedido.SQL.Add('INNER JOIN TESTEDELPHI.PRODUTOS D ON D.CODIGO = A.CODIGO_PRODUTO');
      FDQryPedido.SQL.Add('WHERE A.NUMERO_PEDIDO = :ID');
      FDQryPedido.ParamByName('ID').AsInteger := CODIGO;
      FDQryPedido.Open;
      if not FDQryPedido.IsEmpty then
      begin
        FDQryPedido.First;
        edtCliente.Text := FDQryPedido.FieldByName('CODIGO_CLIENTE').AsString + ' - ' + FDQryPedido.FieldByName('NOME').AsString;
        I := 0;
        gridPedido.RowCount := FDQryPedido.RecordCount;
        while not FDQryPedido.Eof do
        begin
          gridPedido.Cells[0, I] := FDQryPedido.FieldByName('CODIGO').AsString;
          gridPedido.Cells[1, I] := FDQryPedido.FieldByName('DESCRICAO').AsString;
          gridPedido.Cells[2, I] := FDQryPedido.FieldByName('QUANTIDADE').AsString;
          gridPedido.Cells[3, I] := FDQryPedido.FieldByName('VALOR_UNITARIO').AsString;
          gridPedido.Cells[4, I] := FDQryPedido.FieldByName('VALOR_TOTAL').AsString;
          Inc(I);
          FDQryPedido.Next;
        end;
        txtVlTotal.Text := FormatFloat('R$ #,##0.00', FDQryPedido.FieldByName('TOTAL_PEDIDO').AsCurrency);
      end
      else
      begin
        txtStatus.Text := 'Pedido não encontrado';
        TimerStatus.Enabled := True;
      end;
      FDQryPedido.Close;
      rectGravar.Visible := False;
      rectBtnAdd.Visible := False;
      actExcluir.Execute;
    except
      raise Exception.Create('Erro ao carregar pedido.');
    end;
  end;
end;

procedure TfrmPrincipal.CarregarProdutos;
var
  Produto: TProduto;
begin
  FDMemProduto.Active := True;
  for Produto in TProduto.ListProdutos do
    FDMemProduto.AppendRecord([Produto.Codigo, Produto.Descricao, Produto.Preco]);
end;

function TfrmPrincipal.SomenteNumero(Key: Char; Texto: String; IsDecimal: Boolean): Char;
begin
  if not IsDecimal then
  begin
    if not ( Key in ['0'..'9', Chr(8)] ) then
      Key := #0
  end
  else
  begin
    if Key = #46 then
      Key := FormatSettings.DecimalSeparator;
    if not ( Key in ['0'..'9', Chr(8), FormatSettings.DecimalSeparator] ) then
      Key := #0
    else if (Key = FormatSettings.DecimalSeparator ) and ( Pos( Key, Texto ) > 0 ) then
      Key := #0;
  end;
  Result := Key;
end;

procedure TfrmPrincipal.TimerStatusTimer(Sender: TObject);
begin
  txtStatus.Text := '';
  TimerStatus.Enabled := False;
end;

procedure TfrmPrincipal.edtNumeroPedidoClick(Sender: TObject);
begin
  edtNumeroPedido.Text := '';
end;

procedure TfrmPrincipal.edtNumeroPedidoMouseEnter(Sender: TObject);
begin
  AnimationNumeroPedido.StartValue := TAlphaColorRec.White;
  AnimationNumeroPedido.StopValue  := TAlphaColorRec.Black;
  AnimationNumeroPedido.Start;
end;

procedure TfrmPrincipal.edtNumeroPedidoMouseLeave(Sender: TObject);
begin
  AnimationNumeroPedido.StopValue   := TAlphaColorRec.White;
  AnimationNumeroPedido.StartValue  := TAlphaColorRec.Black;
  AnimationNumeroPedido.Start;
end;

end.
