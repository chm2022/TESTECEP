unit XmlClass;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmldom, XMLIntf, msxmldom, XMLDoc;

type
  TXml = class(TComponent)
  private
    Fmodificado: boolean;
    Fdoc: TXMLDocument;
    Farquivoxml: string;
    FnoPadrao: string;
    FnoRaiz: iXMLNode;
    const
      no_raiz = 'xml';
    function GetNoDefault: IXMLNode;
    procedure SetModificado;
  public
    constructor Create(arquivo: string; abrirArquivo: boolean);
    destructor Destroy; override;
    function  AbrirArquivo(abrirArquivo: boolean): boolean;
    function  AddElemento(var _no: IXMLNode; _elemento: string): IXMLNode;
    procedure SetElemento(_elemento: string; _valor: string); overload;
    procedure SetElemento(_elementos: array of string; _valor: string); overload;
    function  GetElemento(_elemento: string; _valorDefault: string): string; overload;
    function  GetElemento(_elementos: array of string; _valorDefault: string): string; overload;
    function  GetElementoIndex(idx: integer; _valorDefault: string): string;
    function  GetElementoNome(idx: integer): string;
    procedure SetAtributo(_elemento: string; _atributo: string; _valor: string);
    function  GetAtributo(_elemento: string; _atributo: string; _valorDefault: string): string;
    procedure SetNoPadrao(_NomeNoPadrao: string);
    function  GetNoPadrao: string;
    procedure SalvarArquivo;
    function  GetNodeCount: integer;
    function  GetXmlString: string;
    procedure SetXmlString(s: string);

    class procedure GravarNoXml(_arquivo, _noPadrao, _elemento,
      _valor: string);
    class function LerDoXml(_arquivo, _noPadrao, _elemento,
      _valorDefault: string; _Add: boolean = false): string;
    property Modificado: boolean read Fmodificado;
  end;

implementation

{ TXml }

function TXml.AbrirArquivo(abrirArquivo: boolean): boolean;
begin
  try
    //guarda o nome do arquivo xml
    Fdoc.Active:= true;
    if abrirArquivo and FileExists(Farquivoxml) then
    begin
      //carrega o arquivo
      Fdoc.LoadFromFile(Farquivoxml);
    end;

    //Fdoc.Encoding := 'ISO-8859-1';
    Fdoc.Encoding := 'UTF-8';
    Fdoc.Version := '1.0';
    //pega o no raiz do xml
    if Fdoc.DocumentElement = nil then
      Fdoc.AddChild(no_raiz);

    FnoRaiz:= Fdoc.DocumentElement;
    Self.Fmodificado:= false;
    Result:= true;
  except
    Result:= false;
  end;
end;

function TXml.AddElemento(var _no: IXMLNode; _elemento: string): IXMLNode;
var
  novono: IXMLNode;
begin
  novono:= _no.ChildNodes.FindNode(_elemento);
  if novono = nil then
  begin
    novono:= _no.AddChild(_elemento);
  end;

  Result:= novono;
  SetModificado;
end;

constructor TXml.Create(arquivo: string; abrirArquivo: boolean);
begin
  Self.Fmodificado:= false;
  Self.Fdoc:= TXMLDocument.Create(Application);
  Self.Fdoc.Options:= [doNodeAutoCreate,doNodeAutoIndent];
  Self.Farquivoxml:= arquivo;
  Self.AbrirArquivo(abrirArquivo);
end;

destructor TXml.Destroy;
begin
  FreeAndNil(Self.Fdoc);
end;

function TXml.GetAtributo(_elemento, _atributo, _valorDefault: string): string;
var
  noPadrao, no: IXMLNode;
begin
  noPadrao:= GetNoDefault;
  no:= noPadrao.ChildNodes.FindNode(_elemento);
  if no = nil then
  begin
    SetElemento(_elemento,'');
    SetAtributo(_elemento,_atributo,_valorDefault);
    Result:= _valorDefault;
  end
  else
  begin
    Result:= no.GetAttribute(_atributo);
    if Result = '' then
    begin
      SetAtributo(_elemento,_atributo,_valorDefault);
      Result:= _valorDefault;
    end;
  end;
end;

function TXml.GetElemento(_elemento, _valorDefault: string): string;
var
  noPadrao, no: IXMLNode;
begin
  noPadrao:= GetNoDefault;
  no:= noPadrao.ChildNodes.FindNode(_elemento);
  if no = nil then
  begin
    SetElemento(_elemento,_valorDefault);
    Result:= _valorDefault;
  end
  else
  begin
    Result:= no.Text;
    if Result = '' then
    begin
      SetElemento(_elemento,_valorDefault);
      Result:= _valorDefault;
    end;
  end;
end;

function TXml.GetElemento(_elementos: array of string;
  _valorDefault: string): string;
var
  noPadrao, noA, noB  : IXMLNode;
  i: Integer;
begin
  noPadrao:= GetNoDefault;
  noA:= noPadrao.ChildNodes.FindNode(_elementos[0]);
  if noA = nil then
  begin
    noA:= Self.AddElemento(noPadrao,_elementos[0]);
  end;

  if length(_elementos) > 1 then
  begin
    for i := 1 to length(_elementos)-1 do
    begin
      noB:= noA.ChildNodes.FindNode(_elementos[i]);
      if noB = nil then
      begin
        noB:= Self.AddElemento(noA,_elementos[i]);
      end;

      noA:= noB;
    end;
  end;

  Result:= noA.Text;
  if Result = '' then
  begin
    noA.Text:= _valorDefault;
    Result:= _valorDefault;
  end;
end;

function TXml.GetElementoIndex(idx: integer; _valorDefault: string): string;
var
  noPadrao, no: IXMLNode;
begin
  noPadrao:= GetNoDefault;
  no:= noPadrao.ChildNodes.Get(idx);
  if no = nil then
  begin
    //SetElemento(_elemento,_valorDefault);
    Result:= _valorDefault;
  end
  else
  begin
    Result:= no.Text;
    if Result = '' then
    begin
      //SetElemento(_elemento,_valorDefault);
      Result:= _valorDefault;
    end;
  end;
end;

function TXml.GetElementoNome(idx: integer): string;
var
  noPadrao, no: IXMLNode;
begin
  noPadrao:= GetNoDefault;
  no:= noPadrao.ChildNodes.Get(idx);
  if no = nil then
  begin
    //SetElemento(_elemento,_valorDefault);
    Result:= '';
  end
  else
  begin
    Result:= no.NodeName;
    if Result = '' then
    begin
      //SetElemento(_elemento,_valorDefault);
      Result:= '';
    end;
  end;
end;

function TXml.GetNodeCount: integer;
begin
  Result:= GetNoDefault.ChildNodes.Count;
end;

function TXml.GetNoDefault: IXMLNode;
begin
  if Self.FnoPadrao = '' then
  begin
    Result:= Self.FnoRaiz;
  end
  else
  begin
    Result:= Self.FnoRaiz.ChildNodes.FindNode(Self.FnoPadrao);
    if Result = nil then
    begin
      Result:= Self.FnoRaiz.AddChild(Self.FnoPadrao);
    end;
  end;

  Result:= Result;
end;

function TXml.GetNoPadrao: string;
begin
  Result:= Self.FnoPadrao;
end;

class procedure TXml.GravarNoXml(_arquivo, _noPadrao, _elemento,
  _valor: string);
var
  xml: TXml;
begin
  try
    xml:= TXml.Create(_arquivo,false);
    xml.SetNoPadrao(_noPadrao);
    xml.SetElemento(_elemento,_valor);
    xml.SalvarArquivo;
  finally
    FreeAndNil(xml);
  end;
end;

class function TXml.LerDoXml(_arquivo, _noPadrao, _elemento,
  _valorDefault: string; _Add: boolean = false): string;
var
  xml: TXml;
begin
  try
    xml:= TXml.Create(_arquivo,true);
    xml.SetNoPadrao(_noPadrao);
    Result:= xml.GetElemento(_elemento,_valorDefault);
    if _Add and (Result = _valorDefault) then
    begin
      xml.SetElemento(_elemento,_valorDefault);
      xml.SalvarArquivo;
    end;
  finally
    FreeAndNil(xml);
  end;
end;

procedure TXml.SalvarArquivo;
begin
  Self.Fdoc.SaveToFile(Self.Farquivoxml);
end;

procedure TXml.SetAtributo(_elemento, _atributo, _valor: string);
var
  noPadrao, no: IXMLNode;
begin
  noPadrao:= GetNoDefault;
  no:= noPadrao.ChildNodes.FindNode(_elemento);
  if no = nil then
  begin
    no:= noPadrao.AddChild(_elemento);
  end;

  no.SetAttribute(_atributo,_valor);
  SetModificado;
end;

procedure TXml.SetElemento(_elementos: array of string; _valor: string);
var
  noPadrao, noA, noB: IXMLNode;
  i: Integer;
begin
  noPadrao:= GetNoDefault;
  noA:= noPadrao.ChildNodes.FindNode(_elementos[0]);
  if noA = nil then
  begin
    noA:= Self.AddElemento(noPadrao,_elementos[0]);
  end;

  if length(_elementos) > 1 then
  begin
    for i := 1 to length(_elementos)-1 do
    begin
      noB:= noA.ChildNodes.FindNode(_elementos[i]);
      if noB = nil then
      begin
        noB:= Self.AddElemento(noA,_elementos[i]);
      end;

      noA:= noB;
    end;
  end;

  noA.Text:= _valor;
  SetModificado;
end;

procedure TXml.SetElemento(_elemento, _valor: string);
var
  noPadrao, no: IXMLNode;
begin
  noPadrao:= GetNoDefault;
  no:= noPadrao.ChildNodes.FindNode(_elemento);
  if no = nil then
  begin
    no:= noPadrao.AddChild(_elemento);
  end;

  no.Text:= _valor;
  SetModificado;
end;

procedure TXml.SetModificado;
begin
  Self.Fmodificado:= true;
end;

procedure TXml.SetNoPadrao(_NomeNoPadrao: string);
begin
  Self.FnoPadrao:= _NomeNoPadrao;
end;

procedure TXml.SetXmlString(s: string);
begin
  Self.Fdoc.LoadFromXML(s);
  Self.FnoRaiz:= Self.Fdoc.DocumentElement;
  Self.Fdoc.Active:= true;
end;

function TXml.GetXmlString: string;
begin
  Result:= Self.Fdoc.XML.Text;
end;

end.
