object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Clientes'
  ClientHeight = 623
  ClientWidth = 1103
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 840
    Top = 2
    Width = 45
    Height = 13
    Caption = 'Endere'#231'o'
  end
  object Label2: TLabel
    Left = 800
    Top = 160
    Width = 26
    Height = 13
    Caption = 'JSON'
  end
  object Label3: TLabel
    Left = 760
    Top = 293
    Width = 19
    Height = 13
    Caption = 'XML'
  end
  object Label5: TLabel
    Left = 24
    Top = 9
    Width = 27
    Height = 13
    Caption = 'Nome'
  end
  object Label6: TLabel
    Left = 387
    Top = 9
    Width = 52
    Height = 13
    Caption = 'Identidade'
  end
  object Label7: TLabel
    Left = 557
    Top = 9
    Width = 42
    Height = 13
    Caption = 'Telefone'
  end
  object Label8: TLabel
    Left = 24
    Top = 48
    Width = 28
    Height = 13
    Caption = 'E-mail'
  end
  object Label10: TLabel
    Left = 541
    Top = 127
    Width = 19
    Height = 13
    Caption = 'Cep'
    FocusControl = DBCEP
  end
  object Label12: TLabel
    Left = 384
    Top = 88
    Width = 37
    Height = 13
    Caption = 'Numero'
    FocusControl = DBNUMERO
  end
  object Label13: TLabel
    Left = 24
    Top = 127
    Width = 65
    Height = 13
    Caption = 'Complemento'
    FocusControl = DBCOMPLEMENTO
  end
  object Label14: TLabel
    Left = 478
    Top = 88
    Width = 28
    Height = 13
    Caption = 'Bairro'
    FocusControl = DBBAIRRO
  end
  object Label15: TLabel
    Left = 285
    Top = 127
    Width = 33
    Height = 13
    Caption = 'Cidade'
    FocusControl = DBLOCALIDADE
  end
  object Label16: TLabel
    Left = 629
    Top = 127
    Width = 33
    Height = 13
    Caption = 'Estado'
    FocusControl = DBESTADO
  end
  object Label17: TLabel
    Left = 671
    Top = 127
    Width = 19
    Height = 13
    Caption = 'Pais'
    FocusControl = DBPAIS
  end
  object Label11: TLabel
    Left = 144
    Top = 88
    Width = 55
    Height = 13
    Caption = 'Logradouro'
    FocusControl = DBLOGRADOURO
  end
  object Label9: TLabel
    Left = 24
    Top = 90
    Width = 70
    Height = 13
    Caption = 'Colsutar CEP'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 24
    Top = 170
    Width = 699
    Height = 40
    Shape = bsFrame
  end
  object Label4: TLabel
    Left = 24
    Top = 213
    Width = 644
    Height = 13
    Caption = 
      'Cadastro de clientes com busca do CEP - Gera'#231#227'o de arquivos XML ' +
      '- Envio de e-mail com os dados do cadastros. By Gilvandro Brand'#227 +
      'o'
  end
  object BtnBuscaCEP: TButton
    Left = 100
    Top = 102
    Width = 31
    Height = 25
    Caption = '...'
    Enabled = False
    TabOrder = 15
    OnClick = BtnBuscaCEPClick
  end
  object MemoTEXTO: TMemo
    Left = 840
    Top = 21
    Width = 313
    Height = 289
    Lines.Strings = (
      'ENDERE'#199'O')
    TabOrder = 12
  end
  object MemoJSON: TMemo
    Left = 800
    Top = 179
    Width = 313
    Height = 289
    Lines.Strings = (
      'JSON')
    TabOrder = 13
  end
  object MemoXML: TMemo
    Left = 760
    Top = 312
    Width = 350
    Height = 289
    Lines.Strings = (
      'XML')
    TabOrder = 14
  end
  object DBCEP: TDBEdit
    Left = 541
    Top = 143
    Width = 76
    Height = 21
    Color = clSilver
    DataField = 'cep'
    DataSource = DSCliente
    TabOrder = 10
    OnKeyPress = DBCEPKeyPress
  end
  object DBNUMERO: TDBEdit
    Left = 387
    Top = 104
    Width = 79
    Height = 21
    CharCase = ecUpperCase
    Color = clSilver
    DataField = 'Numero'
    DataSource = DSCliente
    TabOrder = 6
    OnKeyPress = DBNUMEROKeyPress
  end
  object DBCOMPLEMENTO: TDBEdit
    Left = 24
    Top = 143
    Width = 249
    Height = 21
    CharCase = ecUpperCase
    Color = clSilver
    DataField = 'Complemento'
    DataSource = DSCliente
    TabOrder = 8
    OnKeyPress = DBCOMPLEMENTOKeyPress
  end
  object DBBAIRRO: TDBEdit
    Left = 478
    Top = 104
    Width = 245
    Height = 21
    CharCase = ecUpperCase
    Color = clSilver
    DataField = 'Bairro'
    DataSource = DSCliente
    TabOrder = 7
    OnKeyPress = DBBAIRROKeyPress
  end
  object DBLOCALIDADE: TDBEdit
    Left = 285
    Top = 143
    Width = 243
    Height = 21
    CharCase = ecUpperCase
    Color = clSilver
    DataField = 'Cidade'
    DataSource = DSCliente
    TabOrder = 9
    OnKeyPress = DBLOCALIDADEKeyPress
  end
  object DBESTADO: TDBEdit
    Left = 629
    Top = 143
    Width = 30
    Height = 21
    CharCase = ecUpperCase
    Color = clSilver
    DataField = 'Estado'
    DataSource = DSCliente
    TabOrder = 11
    OnKeyPress = DBESTADOKeyPress
  end
  object DBPAIS: TDBEdit
    Left = 671
    Top = 143
    Width = 52
    Height = 21
    CharCase = ecUpperCase
    Color = clSilver
    DataField = 'Pais'
    DataSource = DSCliente
    TabOrder = 16
    OnKeyPress = DBPAISKeyPress
  end
  object DBLOGRADOURO: TDBEdit
    Left = 144
    Top = 104
    Width = 230
    Height = 21
    CharCase = ecUpperCase
    Color = clSilver
    DataField = 'Logradouro'
    DataSource = DSCliente
    TabOrder = 5
    OnKeyPress = DBLOGRADOUROKeyPress
  end
  object EdtBuscaCEP: TEdit
    Left = 24
    Top = 104
    Width = 76
    Height = 21
    Color = clYellow
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    MaxLength = 9
    ParentFont = False
    TabOrder = 4
    OnExit = EdtBuscaCEPExit
    OnKeyPress = EdtBuscaCEPKeyPress
  end
  object BtnSalvar: TBitBtn
    Left = 560
    Top = 178
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 17
    OnClick = BtnSalvarClick
  end
  object BtnEnviar: TBitBtn
    Left = 640
    Top = 178
    Width = 75
    Height = 25
    Caption = 'Enviar E-mail'
    TabOrder = 18
    OnClick = BtnEnviarClick
  end
  object BtnNOVO: TBitBtn
    Left = 398
    Top = 178
    Width = 75
    Height = 25
    Caption = 'Novo'
    TabOrder = 19
    OnClick = BtnNOVOClick
  end
  object BtnAlterar: TBitBtn
    Left = 479
    Top = 178
    Width = 75
    Height = 25
    Caption = 'Alterar'
    TabOrder = 20
    OnClick = BtnAlterarClick
  end
  object DBENome: TDBEdit
    Left = 24
    Top = 25
    Width = 350
    Height = 21
    CharCase = ecUpperCase
    Color = clSilver
    DataField = 'Nome'
    DataSource = DSCliente
    TabOrder = 0
    OnKeyPress = DBENomeKeyPress
  end
  object DBEIDENTIDADE: TDBEdit
    Left = 387
    Top = 25
    Width = 160
    Height = 21
    CharCase = ecUpperCase
    Color = clSilver
    DataField = 'Identidade'
    DataSource = DSCliente
    TabOrder = 1
    OnKeyPress = DBEIDENTIDADEKeyPress
  end
  object DBETELEFONE: TDBEdit
    Left = 557
    Top = 25
    Width = 166
    Height = 21
    CharCase = ecUpperCase
    Color = clSilver
    DataField = 'Telefone'
    DataSource = DSCliente
    TabOrder = 2
    OnChange = DBETELEFONEChange
    OnKeyPress = DBETELEFONEKeyPress
  end
  object DBEEMAIL: TDBEdit
    Left = 24
    Top = 65
    Width = 699
    Height = 21
    CharCase = ecLowerCase
    Color = clSilver
    DataField = 'email'
    DataSource = DSCliente
    TabOrder = 3
    OnKeyPress = DBEEMAILKeyPress
  end
  object GridDados: TDBGrid
    Left = 24
    Top = 232
    Width = 699
    Height = 177
    Color = clBtnFace
    DataSource = DSCliente
    GradientStartColor = clBtnFace
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 21
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ID'
        Title.Alignment = taCenter
        Title.Caption = 'C'#243'digo'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nome'
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Identidade'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Telefone'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'email'
        Title.Caption = 'E-mail'
        Width = 350
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Logradouro'
        Width = 350
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Numero'
        Title.Caption = 'N'#250'mero'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Bairro'
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Complemento'
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Cidade'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CEP'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Estado'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Pais'
        Title.Caption = 'Pa'#237's'
        Width = 50
        Visible = True
      end>
  end
  object DSCliente: TDataSource
    DataSet = FDMemDados
    Left = 56
    Top = 483
  end
  object IdSSLIOHandlerSocket: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 160
    Top = 424
  end
  object IdSMTP: TIdSMTP
    SASLMechanisms = <>
    Left = 160
    Top = 483
  end
  object IdMessage: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 160
    Top = 544
  end
  object FDMemDados: TFDMemTable
    AfterPost = FDMemDadosAfterPost
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 56
    Top = 424
    object FDMemDadosID: TAutoIncField
      AutoGenerateValue = arDefault
      FieldName = 'ID'
    end
    object FDMemDadosNome: TStringField
      FieldName = 'Nome'
      Size = 350
    end
    object FDMemDadosIdentidade: TStringField
      FieldName = 'Identidade'
      Size = 10
    end
    object FDMemDadosTelefone: TStringField
      FieldName = 'Telefone'
      Size = 15
    end
    object FDMemDadosemail: TStringField
      FieldName = 'email'
      Size = 250
    end
    object FDMemDadosLogradouro: TStringField
      FieldName = 'Logradouro'
      Size = 150
    end
    object FDMemDadosNumero: TStringField
      FieldName = 'Numero'
      Size = 15
    end
    object FDMemDadosBairro: TStringField
      FieldName = 'Bairro'
      Size = 150
    end
    object FDMemDadosComplemento: TStringField
      FieldName = 'Complemento'
      Size = 150
    end
    object FDMemDadosCidade: TStringField
      FieldName = 'Cidade'
      Size = 150
    end
    object FDMemDadosCEP: TStringField
      FieldName = 'CEP'
      Size = 12
    end
    object FDMemDadosEstado: TStringField
      FieldName = 'Estado'
      Size = 2
    end
    object FDMemDadosPais: TStringField
      FieldName = 'Pais'
      Size = 150
    end
  end
  object FDStanStorageJSONLink1: TFDStanStorageJSONLink
    Left = 57
    Top = 544
  end
end
