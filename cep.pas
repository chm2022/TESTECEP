unit cep;

interface

type
  TCep = class
  private
    Flogradouro: string;
    Fibge: string;
    Fbairro: string;
    Fuf: string;
    Fcep: string;
    Flocalidade: string;
    Funidade: string;
    Fcomplemento: string;
    Fgia: string;
    procedure Setbairro(const Value: string);
    procedure Setcep(const Value: string);
    procedure Setcomplemento(const Value: string);
    procedure Setgia(const Value: string);
    procedure Setibge(const Value: string);
    procedure Setlocalidade(const Value: string);
    procedure Setlogradouro(const Value: string);
    procedure Setuf(const Value: string);
    procedure Setunidade(const Value: string);
  public
    property cep: string read Fcep write Setcep;
    property logradouro: string read Flogradouro write Setlogradouro;
    property complemento: string read Fcomplemento write Setcomplemento;
    property bairro: string read Fbairro write Setbairro;
    property localidade: string read Flocalidade write Setlocalidade;
    property uf: string read Fuf write Setuf;
    property unidade: string read Funidade write Setunidade;
    property ibge: string read Fibge write Setibge;
    property gia: string read Fgia write Setgia;
  end;

implementation

{ TCep }

procedure TCep.Setbairro(const Value: string);
begin
  Fbairro := Value;
end;

procedure TCep.Setcep(const Value: string);
begin
  Fcep := Value;
end;

procedure TCep.Setcomplemento(const Value: string);
begin
  Fcomplemento := Value;
end;

procedure TCep.Setgia(const Value: string);
begin
  Fgia := Value;
end;

procedure TCep.Setibge(const Value: string);
begin
  Fibge := Value;
end;

procedure TCep.Setlocalidade(const Value: string);
begin
  Flocalidade := Value;
end;

procedure TCep.Setlogradouro(const Value: string);
begin
  Flogradouro := Value;
end;

procedure TCep.Setuf(const Value: string);
begin
  Fuf := Value;
end;

procedure TCep.Setunidade(const Value: string);
begin
  Funidade := Value;
end;

end.
