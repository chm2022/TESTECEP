unit ClienteWSClass;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, REST.Client, System.JSON,
  Data.Bind.Components, Data.Bind.ObjectScope, Rest.JSON, Rest.Types;

type
  TClienteWS = class(TDataModule)
    rc: TRESTClient;
    request: TRESTRequest;
  private
    { Private declarations }
  public
    { Public declarations }
    function Get_(url: string): string;
    function Post_(servidor, metodo: string; parametros: string): string;
    class function Get(servidor: string): string;
    class function Post(servidor, metodo: string; parametros: string): string;
  end;

var
  ClienteWS: TClienteWS;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TClienteWS }

function TClienteWS.Get_(url: string): string;
var
  retorno: string;
begin
  try
    request.Method:= TRESTRequestMethod.rmGET;
    rc.BaseURL:= url;
    request.Execute;

    retorno := request.Response.Content;
    Result:= retorno;
  except
    on e: exception do
    begin
      Result:= 'Erro de comunicação com o servidor: ' + e.Message + '. Retorno: ' + request.Response.Content;
    end;
  end;
end;

function TClienteWS.Post_(servidor, metodo: string; parametros: string): string;
var
  LJson: TJsonObject;
  retorno: string;
begin
  try
    request.Method:= TRESTRequestMethod.rmPOST;
    rc.BaseURL:= servidor + metodo;
    request.Params.Clear;

    request.Params.AddItem; //Adds a new Parameter Item
    request.Params.Items[0].name := 'data'; //sets the name of the parameter. In this case, since i need to use 'data=' on the request, the parameter name is data.
    request.Params.Items[0].Value := parametros; //Adds the value of the parameter, in this case, the XML data.
    request.Params.Items[0].ContentType := ctAPPLICATION_JSON; //sets the content type.
    request.Params.Items[0].Kind := pkGETorPOST; //sets the kind of request that will be executed.

    //request.ClearBody;
    //request.AddBody(parametros, ContentTypeFromString('application/json'));
    request.Execute;

    //LJson := request.Response.JSONValue as TJSONObject;
    retorno := request.Response.Content;
    //Result:= TJson.JsonToObject<TMensagemWS>(retorno);
    Result:= retorno;
  except
    on e: exception do
    begin
      Result:= 'Erro de comunicação com o servidor: ' + e.Message + '. Retorno: ' + request.Response.Content;
    end;
  end;
end;

class function TClienteWS.Get(servidor: string): string;
var
  ws: TClienteWS;
begin
  try
    ws:= TClienteWS.Create(nil);
    Result:= ws.Get_(servidor);
  finally
    FreeAndNil(ws);
  end;
end;

class function TClienteWS.Post(servidor, metodo, parametros: string): string;
var
  ws: TClienteWS;
begin
  try
    ws:= TClienteWS.Create(nil);
    Result:= ws.Post_(servidor, metodo, parametros);
  finally
    FreeAndNil(ws);
  end;
end;

end.
