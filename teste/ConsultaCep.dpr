program ConsultaCep;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  ClienteWSClass in 'SysClienteWS\ClienteWSClass.pas' {ClienteWS: TDataModule},
  cep in 'cep.pas',
  XmlClass in 'SysXML\XmlClass.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TClienteWS, ClienteWS);
  Application.Run;
end.
