
// INÍCIO DO CÓDIGO
// Espero que gostem.

// By Gilvandro Brandão
// WhatsApp: (81)99750-1974
// Desenvoledor Delphi

// Conta do sistema Gmail:
// Username  := 'enviaemailinfosistemas@gmail.com';
// Password  := '!@#14693939';

unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Json,
  Rest.Json, Data.DB, Datasnap.DBClient, Vcl.Mask, Vcl.DBCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, IdSMTP, IdSSLOpenSSL, IdMessage, IdText,
  IdAttachmentFile, IdExplicitTLSClientServerBase, IdTCPConnection, IdTCPClient,
  IdMessageClient, IdSMTPBase, IdBaseComponent, IdComponent, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.DApt;

type
  TForm1 = class(TForm)
    BtnBuscaCEP: TButton;
    MemoTEXTO: TMemo;
    MemoJSON: TMemo;
    MemoXML: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DSCliente: TDataSource;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    DBCEP: TDBEdit;
    Label12: TLabel;
    DBNUMERO: TDBEdit;
    Label13: TLabel;
    DBCOMPLEMENTO: TDBEdit;
    Label14: TLabel;
    DBBAIRRO: TDBEdit;
    Label15: TLabel;
    DBLOCALIDADE: TDBEdit;
    Label16: TLabel;
    DBESTADO: TDBEdit;
    Label17: TLabel;
    DBPAIS: TDBEdit;
    Label11: TLabel;
    DBLOGRADOURO: TDBEdit;
    Label9: TLabel;
    EdtBuscaCEP: TEdit;
    Bevel1: TBevel;
    BtnSalvar: TBitBtn;
    BtnEnviar: TBitBtn;
    BtnNOVO: TBitBtn;
    BtnAlterar: TBitBtn;
    IdSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL;
    IdSMTP: TIdSMTP;
    IdMessage: TIdMessage;
    Label4: TLabel;
    FDMemDados: TFDMemTable;
    FDMemDadosID: TAutoIncField;
    FDMemDadosNome: TStringField;
    FDMemDadosIdentidade: TStringField;
    FDMemDadosTelefone: TStringField;
    FDMemDadosemail: TStringField;
    FDMemDadosLogradouro: TStringField;
    FDMemDadosNumero: TStringField;
    FDMemDadosBairro: TStringField;
    FDMemDadosComplemento: TStringField;
    FDMemDadosCidade: TStringField;
    FDMemDadosCEP: TStringField;
    FDMemDadosEstado: TStringField;
    FDMemDadosPais: TStringField;
    DBENome: TDBEdit;
    DBEIDENTIDADE: TDBEdit;
    DBETELEFONE: TDBEdit;
    DBEEMAIL: TDBEdit;
    FDStanStorageJSONLink1: TFDStanStorageJSONLink;
    GridDados: TDBGrid;
    procedure BtnBuscaCEPClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnNOVOClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnEnviarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBLOGRADOUROKeyPress(Sender: TObject; var Key: Char);
    procedure DBNUMEROKeyPress(Sender: TObject; var Key: Char);
    procedure DBBAIRROKeyPress(Sender: TObject; var Key: Char);
    procedure DBCOMPLEMENTOKeyPress(Sender: TObject; var Key: Char);
    procedure DBLOCALIDADEKeyPress(Sender: TObject; var Key: Char);
    procedure DBCEPKeyPress(Sender: TObject; var Key: Char);
    procedure DBESTADOKeyPress(Sender: TObject; var Key: Char);
    procedure DBPAISKeyPress(Sender: TObject; var Key: Char);
    procedure EdtBuscaCEPKeyPress(Sender: TObject; var Key: Char);
    procedure EdtBuscaCEPExit(Sender: TObject);
    //procedure FDMemTable1AfterPost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure DBENomeKeyPress(Sender: TObject; var Key: Char);
    procedure DBEIDENTIDADEKeyPress(Sender: TObject; var Key: Char);
    procedure DBETELEFONEChange(Sender: TObject);
    procedure DBETELEFONEKeyPress(Sender: TObject; var Key: Char);
    procedure DBEEMAILKeyPress(Sender: TObject; var Key: Char);
    procedure FDMemDadosAfterPost(DataSet: TDataSet);
  private

  public
    Procedure SalvarDados;
    Procedure EnviarEmail;
    Procedure AguardarEnvio;
    function ValidaEmail(sEmail: string): boolean;
  end;

var
  Form1: TForm1;

  const
  arquivo_dados = 'DadosClientes.json';

implementation

{$R *.dfm}

uses ClienteWSClass, cep, XmlClass;


procedure TForm1.EnviarEmail;
var
  // variáveis e objetos necessários para o envio
  IdSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL;
  IdSMTP: TIdSMTP;
  IdMessage: TIdMessage;
  IdText: TIdText;
  sAnexo: string;
begin
  //Mensagem de aguarde...
  AguardarEnvio;

  // instanciação dos objetos
  IdSSLIOHandlerSocket := TIdSSLIOHandlerSocketOpenSSL.Create(Self);
  IdSMTP := TIdSMTP.Create(Self);
  IdMessage := TIdMessage.Create(Self);

  try
    //Configuração do protocolo SSL (TIdSSLIOHandlerSocketOpenSSL)
    IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
    IdSSLIOHandlerSocket.SSLOptions.Mode := sslmClient;

    //Configuração do servidor SMTP (TIdSMTP)
    IdSMTP.IOHandler := IdSSLIOHandlerSocket;
    IdSMTP.UseTLS    := utUseImplicitTLS;
    IdSMTP.AuthType  := satDefault;
    IdSMTP.Port      := 465;
    IdSMTP.Host      := 'smtp.gmail.com';
    IdSMTP.Username  := 'enviaemailinfosistemas@gmail.com';
    IdSMTP.Password  := '!@#14693939';

    //Configuração da mensagem (TIdMessage)
    IdMessage.From.Address := 'enviaemailinfosistemas@gmail.com';
    IdMessage.From.Name    := DBENome.Text;//'Nome do Remetente'
    IdMessage.ReplyTo.EMailAddresses := IdMessage.From.Address;
    IdMessage.Recipients.Add.Text := DBEEMAIL.Text;//'E-mail do cliente'
    //IdMessage.Recipients.Add.Text := 'destinatario2@email.com'; // opcional
    //IdMessage.Recipients.Add.Text := 'destinatario3@email.com'; // opcional
    IdMessage.Subject             := 'Dados Cadastrais';//'Assunto do e-mail'
    IdMessage.Encoding            := meMIME;

    //Configuração do corpo do email (TIdText)
    IdText := TIdText.Create(IdMessage.MessageParts);
    IdText.Body:= MemoTEXTO.Lines;
    IdText.ContentType := 'text/plain; charset=iso-8859-1';

    //Caminho do arquivo XML gerado (TIdAttachmentFile)
    sAnexo := ExtractFilePath(Application.ExeName) + 'cep.xml';

    if FileExists(sAnexo) then
    begin
      TIdAttachmentFile.Create(IdMessage.MessageParts, sAnexo);
    end;

    // Conexão e autenticação
    try
      IdSMTP.Connect;
      IdSMTP.Authenticate;
    except
      on E:Exception do
      begin
        MessageDlg('Erro na conexão ou autenticação: ' +
          E.Message, mtWarning, [mbOK], 0);
        Exit;
      end;
    end;

    // Envio da mensagem
    try
      IdSMTP.Send(IdMessage);
      MessageDlg('E-mail enviado com sucesso!', mtInformation, [mbOK], 0);
    except
      On E:Exception do
      begin
        MessageDlg('Erro ao enviar a mensagem: ' +
          E.Message, mtWarning, [mbOK], 0);
      end;
    end;
  finally
    // desconecta do servidor de e-mail
    IdSMTP.Disconnect;
    // libera a dll
    UnLoadOpenSSLLibrary;
    // libera objeto da memória
    FreeAndNil(IdMessage);
    FreeAndNil(IdSSLIOHandlerSocket);
    FreeAndNil(IdSMTP);

    //Limpa o campo de pesquisa de Cep
    EdtBuscaCEP.Text := '';
  end;
end;

function TForm1.ValidaEmail(sEmail: string): boolean;
const
  //FUNÇÃO PARA VALIDAR E-MAIL

  // Caracteres válidos
  ATOM_CHARS = [#33..#255] - ['(', ')', '<', '>', '@', ',', ';', ':',
                              '\', '/', '"', '.', '[', ']', #127];

  // Caracteres válidos em uma cadeia
  QUOTED_STRING_CHARS = [#0..#255] - ['"', #13, '\'];

  // Caracteres válidos em um subdominio
  LETTERS = ['A'..'Z', 'a'..'z'];
  LETTERS_DIGITS = ['0'..'9', 'A'..'Z', 'a'..'z'];
  SUBDOMAIN_CHARS = ['-', '0'..'9', 'A'..'Z', 'a'..'z'];

type
  States = (STATE_BEGIN, STATE_ATOM, STATE_QTEXT, STATE_QCHAR,
    STATE_QUOTE, STATE_LOCAL_PERIOD, STATE_EXPECTING_SUBDOMAIN,
    STATE_SUBDOMAIN, STATE_HYPHEN);
var
  State: States;
  i, n, iSubdomains: integer;
  c: char;
begin
  State := STATE_BEGIN;
  n := Length(sEmail);
  i := 1;
  iSubdomains := 1;
  while (i <= n) do
  begin
    c := sEmail[i];
    case State of
      STATE_BEGIN:
        if c in atom_chars then
          State := STATE_ATOM
        else if c = '"' then
          State := STATE_QTEXT
        else
          break;
      STATE_ATOM:
        if c = '@' then
          State := STATE_EXPECTING_SUBDOMAIN
        else if c = '.' then
          State := STATE_LOCAL_PERIOD
        else if not (c in atom_chars) then
          break;
      STATE_QTEXT:
        if c = '\' then
          State := STATE_QCHAR
        else if c = '"' then
          State := STATE_QUOTE
        else if not (c in quoted_string_chars) then
          break;
      STATE_QCHAR:
        State := STATE_QTEXT;
      STATE_QUOTE:
        if c = '@' then
          State := STATE_EXPECTING_SUBDOMAIN
        else if c = '.' then
          State := STATE_LOCAL_PERIOD
        else
          break;
      STATE_LOCAL_PERIOD:
        if c in atom_chars then
          State := STATE_ATOM
        else if c = '"' then
          State := STATE_QTEXT
        else
          break;
      STATE_EXPECTING_SUBDOMAIN:
        if c in letters then
          State := STATE_SUBDOMAIN
        else
          break;
      STATE_SUBDOMAIN:
        if c = '.' then
        begin
          Inc(iSubdomains);
          State := STATE_EXPECTING_SUBDOMAIN
        end
        else if c = '-' then
          State := STATE_HYPHEN
        else if not (c in letters_digits) then
          break;
      STATE_HYPHEN:
        if c in letters_digits then
          State := STATE_SUBDOMAIN
        else if c <> '-' then
          break;
    end;
    Inc(i);
  end;

  if i <= n then
    Result := False
  else
    Result := (State = STATE_SUBDOMAIN) and (iSubdomains >= 2);

  //se sEmail esta vazio retorna true
  if sEmail = '' then
    Result := true

end;

procedure TForm1.AguardarEnvio;
var //Mensagem de Aguarde
  F: TForm;
  MSG: Tlabel;
  Borda: TShape;
begin
  F := TForm.Create(Application);
  F.BorderStyle := bsNone;
  F.Position := poDesktopCenter;
  F.Width := 200;
  F.Height := 36; // até aqui criamos o form

  Borda := TShape.Create(Application);
  Borda.Parent := F;
  Borda.Align := alClient; // uma borda envolta do form

  MSG := Tlabel.Create(Application);
  MSG.Parent := F;
  MSG.Transparent := true;
  MSG.AutoSize := false;
  MSG.Width := 198;
  MSG.Top := 10;
  MSG.Caption := 'Enviando! Aguarde mensagem...';
  MSG.Alignment := taCenter; // label com a mensagem "Aguarde"

  F.Show;
  F.Update;

  // Aqui você coloca os procedimentos desejados
  Sleep(3000);   // exemplo de processamento, aguarda 3 segundos

  F.Free; // E finalmente libera a janela

end;

procedure TForm1.BtnAlterarClick(Sender: TObject);
begin
  //Habilita Botoes;
  BtnAlterar.Enabled := false;
  BtnSalvar.Enabled := true;
  BtnNOVO.Enabled := false;
  BtnEnviar.Enabled := false;
  BtnBuscaCEP.Enabled := true;

  DBENome.Enabled := true;
  DBEIDENTIDADE.Enabled := true;
  DBETELEFONE.Enabled := true;
  EdtBuscaCEP.Enabled := true;
  DBEEMAIL.Enabled := true;

  //Mudança de cor dos campos
  DBENome.Color := clWhite;
  DBEIDENTIDADE.Color := clWhite;
  DBETELEFONE.Color := clWhite;
  EdtBuscaCEP.Color := clYellow;
  DBEEMAIL.Color := clWhite;

  //Foco no campo do nome do cliente
  DBENome.SetFocus;

  //Abre a tabela e entra em estado de edição.
  FDMemDados.Open;
  FDMemDados.Edit;
end;

procedure TForm1.BtnEnviarClick(Sender: TObject);
begin
  if (DBCEP.Text = '')then
  begin
    ShowMessage('Informe um e-mail válido');
    exit
  end
  else
  if DBENome.Text = '' then
  begin
    ShowMessage('Impossível enviar o e-mail sem o nome do cliente');
  end
  else
  begin
    //Atualiza informações para enviar
    BtnBuscaCEPClick(Sender);

    //Habilita Botões;
    BtnAlterar.Enabled := true;
    BtnSalvar.Enabled := false;
    BtnNOVO.Enabled := true;

    //Enviar e-mail
    EnviarEmail;

   //******************************************************
   //****** PREPARAR PARA ENVIAR O E-MAIL DO SISTEMA ******
   //******************************************************

    // Se por acaso o sistema não enviar e-mail da primeira vez, deverá fazer
    // essas configurações.

    //Primeiro, a operadora de e-mail padrão desse remetente é o Gmail.
    //Para ativar a operação é necessário que a opção,permitir aplicativos
    //menos seguros da conta do Gmail esteja "ATIVADA"no seguinte endereço:
    //https://myaccount.google.com/lesssecureapps

    //Segundo, Também se faz necessário permitir acesso a conta no segunte endereço:
    //https://accounts.google.com/DisplayUnlockCaptcha

    //É necessário estar logado na conta do Google utilizada para poder configurar.

    //Dados da conta do Gmail:
    //Username  := 'enviaemailinfosistemas@gmail.com';
    //Password  := '!@#14693939';

    //Manifestação para uso do desenvolvedor.
    //https://viacep.com.br/ws/30320670/json/unicode
  end;
end;

procedure TForm1.BtnNOVOClick(Sender: TObject);
Begin
  //Habilita Botoes e campos;
  BtnAlterar.Enabled := false;
  BtnSalvar.Enabled := true;
  BtnNOVO.Enabled := false;
  BtnEnviar.Enabled := false;
  BtnBuscaCEP.Enabled := true;

  DBENome.Enabled := true;
  DBEIDENTIDADE.Enabled := true;
  DBETELEFONE.Enabled := true;
  EdtBuscaCEP.Enabled := true;
  DBEEMAIL.Enabled := true;

  DBLOGRADOURO.Enabled := false;
  DBNUMERO.Enabled := false;
  DBBAIRRO.Enabled := false;
  DBCOMPLEMENTO.Enabled := false;
  DBLOCALIDADE.Enabled := false;
  DBCEP.Enabled := false;
  DBESTADO.Enabled := false;
  DBPAIS.Enabled := false;


  //Mudança de cor dos campos
  DBENome.Color := clWhite;
  DBEIDENTIDADE.Color := clWhite;
  DBETELEFONE.Color := clWhite;
  EdtBuscaCEP.Color := clYellow;
  DBEEMAIL.Color := clWhite;

  //Insere um novo registro no banco
  FDMemDados.Append;

  //Posiciona o foco no primeiro campo
  DBENome.SetFocus;
end;

procedure TForm1.BtnSalvarClick(Sender: TObject);
begin
  if (DBEEMAIL.Text = '')then
  begin
    ShowMessage('Informe um e-mail válido');
    exit
  end;

  if DBENome.Text = '' then
  begin
    ShowMessage('Impossível salvar sem o nome do cliente');
  end
  else
  begin
    //valida e-mail
    if Not ValidaEmail(DBEEMAIL.Text) then
    Begin
     ShowMessage('Verifique e digitação, este e-mail é inválido!');
     DBEEMAIL.Color := clYellow;
     DBEEMAIL.SetFocus;
    End;

    //se o e-mail for válido
    if ValidaEmail(DBEEMAIL.Text) then
    Begin
     //Atualiza informações para o caso de alteração de registro
      BtnBuscaCEPClick(Sender);

      if (EdtBuscaCEP.Text <> '') or (DBLOGRADOURO.Text <> '') then
      begin
        //Salva Dados
        SalvarDados;

        //Habilita Botoes e campos;
        BtnAlterar.Enabled := true;
        BtnSalvar.Enabled := false;
        BtnNOVO.Enabled := true;
        BtnEnviar.Enabled := true;
        BtnBuscaCEP.Enabled := false;
        DBENome.Enabled := false;
        DBEIDENTIDADE.Enabled := false;
        DBETELEFONE.Enabled := false;
        EdtBuscaCEP.Enabled := false;
        DBEEMAIL.Enabled := false;

        //Mudança de cor dos campos
        DBENome.Color := clSilver;
        DBEIDENTIDADE.Color := clSilver;
        DBETELEFONE.Color := clSilver;
        EdtBuscaCEP.Color := clSilver;
        DBEEMAIL.Color := clSilver;

      End;
    End;
  end;
end;

procedure TForm1.SalvarDados;
begin
  //Salva registros na tabela
  FDMemDados.Post;
end;

procedure TForm1.FDMemDadosAfterPost(DataSet: TDataSet);
begin
  //Salva os registros
  FDMemDados.SaveToFile(arquivo_dados);
end;

{procedure TForm1.FDMemTable1AfterPost(DataSet: TDataSet);
begin
  //Salva os registros em arquivo
  FDMemDados.SaveToFile(arquivo_dados);
end;}

procedure TForm1.BtnBuscaCEPClick(Sender: TObject);
var
 cep, urlCep, retorno: string;
 cepObj: TCep;
 xmlObj: TXml;
begin
  //prepara a consulta
  if EdtBuscaCEP.Text <> '' then
    cep:= EdtBuscaCEP.Text
  else
    cep := DBCEP.Text;

  if cep = '' then
  begin
    ShowMessage('Informe um CEP válido');
    exit
  end
  else
  begin

    //faz a requisição
    urlCep:= 'https://viacep.com.br/ws/'+trim(cep)+'/json/unicode/';
    retorno:= TClienteWS.Get(urlCep);

    //converte o json recebido em objeto
    cepObj:= TJson.JsonToObject<TCep>(retorno);

    //exibe os dados da consulta no Memo Endereço
    MemoTEXTO.Clear;
    MemoTEXTO.Lines.Add('Nome: ' + DBENome.Text);
    MemoTEXTO.Lines.Add('Identidade: ' + DBEIDENTIDADE.Text);
    MemoTEXTO.Lines.Add('Telefone: ' + DBETELEFONE.Text);
    MemoTEXTO.Lines.Add('E-mail: ' + DBEEMAIL.Text);
    MemoTEXTO.Lines.Add('Logradouro: ' + cepObj.logradouro);
    MemoTEXTO.Lines.Add('Número: ' + cepObj.ibge);
    MemoTEXTO.Lines.Add('Bairro: ' + cepObj.bairro);
    MemoTEXTO.Lines.Add('Cidade: ' + cepObj.localidade);
    MemoTEXTO.Lines.Add('UF: ' + cepObj.uf);
    MemoTEXTO.Lines.Add('CEP: ' + cepObj.cep);
    //Memo1.Lines.Add('gia: ' + cepObj.gia);
    //Memo1.Lines.Add('unidade: ' + cepObj.unidade);

    MemoJSON.Clear;
    //exibe o objeto convertido novamente para json
    MemoJSON.Lines.Add(TJson.ObjectToJsonString(cepobj));
    //exibe o objeto convertido novamente para json (porem mais legivel)
    MemoJSON.Lines.Add(TJson.Format(TJson.ObjectToJsonObject(cepObj)));

    //criar um xml com os dados do objeto
    xmlObj:= TXml.Create('cep.xml', true);

    //monta os dados do XML
    xmlObj.SetElemento('Nome', DBENome.Text);
    xmlObj.SetElemento('Identidade', DBEIDENTIDADE.Text);
    xmlObj.SetElemento('Telefone', DBETELEFONE.Text);
    xmlObj.SetElemento('E-mail', DBEEMAIL.Text);
    xmlObj.SetElemento('logradouro', cepObj.logradouro);
    xmlObj.SetElemento('numero', cepObj.ibge);
    xmlObj.SetElemento('bairro', cepObj.bairro);
    xmlObj.SetElemento('localidade', cepObj.localidade);
    xmlObj.SetElemento('uf', cepObj.uf);
    xmlObj.SetElemento('cep', cepObj.cep);

    //cria o XML dentro da pasta do executável do projeto
    xmlObj.SalvarArquivo;

    //Popula o memoXML
    MemoXML.Text:= xmlObj.GetXmlString;

    //Popula os campos da tabela com os dados do endereço
    DBLOGRADOURO.Text := cepObj.logradouro;
    DBNUMERO.Text := cepObj.ibge;
    DBBAIRRO.Text := cepObj.bairro;
    DBLOCALIDADE.Text := cepObj.localidade;
    DBESTADO.Text := cepObj.uf;
    DBCEP.Text := cepObj.cep;
    DBPAIS.Text := 'Brasil';
    BtnBuscaCEP.Default := false;

    //Se encontrar o endereço
    if cepObj.logradouro <> '' then
    begin
      DBLOGRADOURO.Enabled := false;
      DBNUMERO.Enabled := false;
      DBBAIRRO.Enabled := false;
      DBLOCALIDADE.Enabled := false;
      DBESTADO.Enabled := false;
      DBCEP.Enabled := false;
      DBPAIS.Enabled := false;
    end
    else
    Begin
      DBLOGRADOURO.Enabled := true;
      DBNUMERO.Enabled := true;
      DBBAIRRO.Enabled := true;
      DBLOCALIDADE.Enabled := true;
      DBESTADO.Enabled := true;
      DBCEP.Enabled := true;
      DBPAIS.Enabled := true;
    End;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //Cria o banco de dados se não existir
  if FileExists(arquivo_dados) then
     FDMemDados.LoadFromFile(arquivo_dados)
  else
     FDMemDados.CreateDataSet;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   //Fecha a tabela temporária.
   FDMemDados.Close;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  //Habilita Botoes e campos;
  BtnNOVO.Enabled := TRUE;
  BtnSalvar.Enabled := false;
//  BtnEnviar.Enabled := false;
  EdtBuscaCEP.Enabled := false;
  EdtBuscaCEP.Color := clSilver;

  DBENome.Enabled := false;
  DBEIDENTIDADE.Enabled := false;
  DBETELEFONE.Enabled := false;
  EdtBuscaCEP.Enabled := false;
  DBEEMAIL.Enabled := false;
  DBLOGRADOURO.Enabled := false;
  DBNUMERO.Enabled := false;
  DBBAIRRO.Enabled := false;
  DBCOMPLEMENTO.Enabled := false;
  DBLOCALIDADE.Enabled := false;
  DBCEP.Enabled := false;
  DBESTADO.Enabled := false;
  DBPAIS.Enabled := false;

  //Redimenciona o tamanho do form
  ClientWidth := 745;//Largura
  ClientHeight := 430;//Altura

  //Checa se a Grid está com registros
  if GridDados.SelectedRows.IndexOf(FDMemDados.Bookmark) = 0 then
  begin
    BtnAlterar.Enabled := false;
    BtnEnviar.Enabled := false;
  end
  else
  begin
    BtnAlterar.Enabled := true;
    BtnEnviar.Enabled := true;
  end;

end;

procedure TForm1.DBETELEFONEChange(Sender: TObject);
begin
  if (Length(DBETELEFONE.Text) = 1) then
  begin
    if DBETELEFONE.Text[1] = '(' then
    DBETELEFONE.Text := ''
    else
    begin
     DBETELEFONE.Text := '('+DBETELEFONE.text;
     DBETELEFONE.SelStart := Length(DBETELEFONE.text);
    end;
   end;
  if Length(DBETELEFONE.Text) = 3 then
  begin
    DBETELEFONE.Text := DBETELEFONE.text + ') ';
    DBETELEFONE.SelStart := Length(DBETELEFONE.text);
   end;
  if Length(DBETELEFONE.Text) = 10 then
  begin
    DBETELEFONE.text := DBETELEFONE.text + '-';
    DBETELEFONE.SelStart := Length(DBETELEFONE.Text);
  end;
end;

procedure TForm1.DBBAIRROKeyPress(Sender: TObject; var Key: Char);
begin
   //Mudar de campo com o ENTER
   If key = #13 then
   Begin
      Key:= #0;
      Perform(Wm_NextDlgCtl,0,0);
   end;
end;

procedure TForm1.DBCEPKeyPress(Sender: TObject; var Key: Char);
begin
   //Mudar de campo com o ENTER
   If key = #13 then
   Begin
      Key:= #0;
      Perform(Wm_NextDlgCtl,0,0);
   end;
end;

procedure TForm1.DBCOMPLEMENTOKeyPress(Sender: TObject; var Key: Char);
begin
   //Mudar de campo com o ENTER
   If key = #13 then
   Begin
      Key:= #0;
      Perform(Wm_NextDlgCtl,0,0);
   end;
end;

procedure TForm1.DBENomeKeyPress(Sender: TObject; var Key: Char);
begin
   //Mudar de campo com o ENTER
   If key = #13 then
   Begin
      Key:= #0;
      Perform(Wm_NextDlgCtl,0,0);
   end;
end;

procedure TForm1.DBEEMAILKeyPress(Sender: TObject; var Key: Char);
begin
  //Pressionamento do 'ENTER'
  if key =#13 then
  begin
    selectnext(activecontrol, true, true);
    key := #0;
  end;
end;

procedure TForm1.DBEIDENTIDADEKeyPress(Sender: TObject; var Key: Char);
begin
  //Pressionamento do 'ENTER'
  if key =#13 then
  begin
    selectnext(activecontrol, true, true);
    key := #0;
  end;
  //Aceita somente números
  if ((key in ['0'..'9'] = false) and (word(key) <> vk_back)) then
  key := #0;

end;

procedure TForm1.DBESTADOKeyPress(Sender: TObject; var Key: Char);
begin
   //Mudar de campo com o ENTER
   If key = #13 then
   Begin
      Key:= #0;
      Perform(Wm_NextDlgCtl,0,0);
   end;
end;

procedure TForm1.DBETELEFONEKeyPress(Sender: TObject; var Key: Char);
begin
  //Mudar de campo com o ENTER
  If key = #13 then
  Begin
     Key:= #0;
     Perform(Wm_NextDlgCtl,0,0);
  end;
end;

procedure TForm1.DBLOCALIDADEKeyPress(Sender: TObject; var Key: Char);
begin
   //Mudar de campo com o ENTER
   If key = #13 then
   Begin
      Key:= #0;
      Perform(Wm_NextDlgCtl,0,0);
   end;
end;

procedure TForm1.DBLOGRADOUROKeyPress(Sender: TObject; var Key: Char);
begin
   //Mudar de campo com o ENTER
   If key = #13 then
   Begin
      Key:= #0;
      Perform(Wm_NextDlgCtl,0,0);
   end;
end;

procedure TForm1.DBNUMEROKeyPress(Sender: TObject; var Key: Char);
begin
   //Mudar de campo com o ENTER
   If key = #13 then
   Begin
      Key:= #0;
      Perform(Wm_NextDlgCtl,0,0);
   end;
end;

procedure TForm1.DBPAISKeyPress(Sender: TObject; var Key: Char);
begin
   //Mudar de campo com o ENTER
   If key = #13 then
   Begin
      Key:= #0;
      Perform(Wm_NextDlgCtl,0,0);
   end;
end;

procedure TForm1.EdtBuscaCEPExit(Sender: TObject);
begin
  //Prepara para consultar o cep ao sair do campo de busca
  BtnBuscaCEP.Default := true;

  if BtnBuscaCEP.Enabled = true then
     BtnBuscaCEP.SetFocus;
end;

procedure TForm1.EdtBuscaCEPKeyPress(Sender: TObject; var Key: Char);
begin
   //Mudar de campo com o ENTER
   If key = #13 then
   Begin
      Key:= #0;
      Perform(Wm_NextDlgCtl,0,0);
   end;
end;
// FIM DO CÓDIGO
// Espero que tenham gostado.

// By Gilvandro Brandão
// WhatsApp: (81)99750-1974
// Desenvoledor Delphi

// Conta do sistema Gmail:
// Username  := 'enviaemailinfosistemas@gmail.com';
// Password  := '!@#14693939';
end.
