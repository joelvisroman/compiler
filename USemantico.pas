unit USemantico;

interface

uses UToken, USemanticError, Classes, Contnrs, StrUtils, SysUtils;

type

    TTipo = class
    public
      Tipo : String;
    end;

    TSemantico = class
    private
      FStringList : TStringList;
      tipo1, tipo2, codigo,
      Relacional, fileName : String;
      FTipo : TTipo;
      Pilha : TObjectStack;

      procedure acaoSemantica01(token : TToken);
      procedure acaoSemantica02(token : TToken);
      procedure acaoSemantica03(token : TToken);
      procedure acaoSemantica04(token : TToken);
      procedure acaoSemantica05(token : TToken);
      procedure acaoSemantica06(token : TToken);
      procedure acaoSemantica07(token : TToken);
      procedure acaoSemantica08(token : TToken);
      procedure acaoSemantica09(token : TToken);
      procedure acaoSemantica10(token : TToken);
      procedure acaoSemantica11(token : TToken);
      procedure acaoSemantica12(token : TToken);
      procedure acaoSemantica13(token : TToken);
      procedure acaoSemantica14(token : TToken);
      procedure acaoSemantica15(token : TToken);
      procedure acaoSemantica16(token : TToken);
      procedure acaoSemantica17(token : TToken);
      procedure acaoSemantica18(token : TToken);
      procedure acaoSemantica19(token : TToken);
      procedure acaoSemantica20(token : TToken);
      procedure acaoSemantica21(token : TToken);
      procedure acaoSemantica22(token : TToken);
      procedure acaoSemantica23(token : TToken);
      procedure acaoSemantica24(token : TToken);
      procedure acaoSemantica25(token : TToken);
      procedure acaoSemantica26(token : TToken);
      procedure acaoSemantica27(token : TToken);
      procedure acaoSemantica28(token : TToken);
      procedure acaoSemantica29(token : TToken);
      procedure acaoSemantica30(token : TToken);
      procedure acaoSemantica31(token : TToken);
      procedure acaoSemantica32(token : TToken);
      procedure acaoSemantica33(token : TToken);
      procedure acaoSemantica34(token : TToken);
      procedure acaoSemantica35(token : TToken);
      procedure acaoSemantica36(token : TToken);
      procedure acaoSemantica37(token : TToken);
      procedure acaoSemantica38(token : TToken);
      procedure acaoSemantica39(token : TToken);
      procedure acaoSemantica40(token : TToken);

      procedure DeterminaTipo;
      function DesempilhaTipo : String;
      procedure EmpilhaTipo(const Tipo : string);
    public
        property StringList : TStringList read FStringList;

        constructor Create;
        destructor  Destroy;
        procedure executeAction(action : integer; const token : TToken); //raises ESemanticError
    end;

implementation

procedure TSemantico.acaoSemantica01(token: TToken);
begin
  DeterminaTipo();
  FStringList.Add('add');
end;

procedure TSemantico.acaoSemantica02(token: TToken);
begin
  DeterminaTipo();
  FStringList.Add('sub');
end;

procedure TSemantico.acaoSemantica03(token: TToken);
begin
  DeterminaTipo();
  FStringList.Add('mul');
end;

procedure TSemantico.acaoSemantica04(token: TToken);
begin
  tipo1 := DesempilhaTipo();
  tipo2 := DesempilhaTipo();
  EmpilhaTipo('float64');
  FStringList.Add('div');
end;

procedure TSemantico.acaoSemantica05(token: TToken);
begin
  EmpilhaTipo('int64');
  FStringList.Add('ldc.i8 ' + token.getLexeme());
end;

procedure TSemantico.acaoSemantica06(token: TToken);
begin
  EmpilhaTipo('float64');
  FStringList.Add('ldc.r8 ' + token.getLexeme());
end;

procedure TSemantico.acaoSemantica07(token: TToken);
begin
  tipo1 := DesempilhaTipo();
  if (tipo1 = 'int64') or (tipo1 = 'int64') then
      EmpilhaTipo(tipo1)
  else
    raise ESemanticError.Create('Tipo inválido');
end;

procedure TSemantico.acaoSemantica08(token: TToken);
begin
  tipo1 := DesempilhaTipo();
  if (tipo1 = 'int64') or (tipo1 = 'int64') then
      EmpilhaTipo(tipo1)
  else
    raise ESemanticError.Create('Tipo inválido');

  FStringList.Add('ldc.i8 -1');
  FStringList.Add('mul');
end;

procedure TSemantico.acaoSemantica09(token: TToken);
begin
  Relacional := token.getLexeme();
end;

procedure TSemantico.acaoSemantica10(token: TToken);
begin
  tipo1 := DesempilhaTipo();
  tipo2 := DesempilhaTipo();
  if (tipo1 = tipo2) then
      EmpilhaTipo('bool')
  else
    raise ESemanticError.Create('Os tipos comparados são diferentes');

  case AnsiIndexStr(UpperCase(Relacional), ['==', '<>','<', '<=', '>', '>=']) of
    0 : begin
          FStringList.Add('ceq');
        end;
    1 : begin
          FStringList.Add('ceq');
          FStringList.Add('ldc.i4.1');
          FStringList.Add('xor');
        end;
    2 : begin
          FStringList.Add('clt');
        end;
    3 : begin
          FStringList.Add('clt');
          FStringList.Add('ceq');
          FStringList.Add('or');
        end;
    4 : begin
          FStringList.Add('cgt');
        end;
    5 : begin
          FStringList.Add('cgt');
          FStringList.Add('ceq');
          FStringList.Add('or');
        end;
  end;
end;

procedure TSemantico.acaoSemantica11(token: TToken);
begin
  EmpilhaTipo('bool');
  FStringList.Add('ldc.i4.1');
end;

procedure TSemantico.acaoSemantica12(token: TToken);
begin
  EmpilhaTipo('bool');
  FStringList.Add('ldc.i4.0');
end;

procedure TSemantico.acaoSemantica13(token: TToken);
begin

end;

procedure TSemantico.acaoSemantica14(token: TToken);
begin

end;

procedure TSemantico.acaoSemantica15(token: TToken);
begin
  FStringList.Add('.assembly extern mscorlib{}');
  FStringList.Add('.assembly ' + fileName + '{}');
  FStringList.Add('.module ' + fileName + '.exe');
  FStringList.Add('');
  FStringList.Add('.class public ' + fileName + ' {');
  FStringList.Add('  .method public static void _principal ()');
  FStringList.Add('  {');
  FStringList.Add('     .entrypoint');
end;

procedure TSemantico.acaoSemantica16(token: TToken);
begin

end;

procedure TSemantico.acaoSemantica17(token: TToken);
begin

end;

procedure TSemantico.acaoSemantica18(token: TToken);
begin

end;

procedure TSemantico.acaoSemantica19(token: TToken);
begin

end;

procedure TSemantico.acaoSemantica20(token: TToken);
begin

end;

procedure TSemantico.acaoSemantica21(token: TToken);
begin

end;

procedure TSemantico.acaoSemantica22(token: TToken);
begin

end;

procedure TSemantico.acaoSemantica23(token: TToken);
begin

end;

procedure TSemantico.acaoSemantica24(token: TToken);
begin

end;

procedure TSemantico.acaoSemantica25(token: TToken);
begin

end;

procedure TSemantico.acaoSemantica26(token: TToken);
begin

end;

procedure TSemantico.acaoSemantica27(token: TToken);
begin

end;

procedure TSemantico.acaoSemantica28(token: TToken);
begin

end;

procedure TSemantico.acaoSemantica29(token: TToken);
begin

end;

procedure TSemantico.acaoSemantica30(token: TToken);
begin

end;

procedure TSemantico.acaoSemantica31(token: TToken);
begin

end;

procedure TSemantico.acaoSemantica32(token: TToken);
begin

end;

procedure TSemantico.acaoSemantica33(token: TToken);
begin

end;

procedure TSemantico.acaoSemantica34(token: TToken);
begin

end;

procedure TSemantico.acaoSemantica35(token: TToken);
begin

end;

procedure TSemantico.acaoSemantica36(token: TToken);
begin

end;

procedure TSemantico.acaoSemantica37(token: TToken);
begin

end;

procedure TSemantico.acaoSemantica38(token: TToken);
begin

end;

procedure TSemantico.acaoSemantica39(token: TToken);
begin

end;

procedure TSemantico.acaoSemantica40(token: TToken);
begin

end;

constructor TSemantico.Create;
begin
// cria objetos e pilha.
  Pilha := TObjectStack.Create;
  FTipo := TTipo.Create;
  codigo := '';
  Relacional := '';
  fileName := 'teste';
end;

function TSemantico.DesempilhaTipo : String;
begin
  FTipo := TTipo(Pilha.Pop);
  Result := FTipo.Tipo;
end;

destructor TSemantico.Destroy;
begin
  FStringList.Free;
end;

procedure TSemantico.DeterminaTipo;
var
 tipo1, tipo2 : String;
begin
  tipo1 := DesempilhaTipo();
  tipo2 := DesempilhaTipo();

  if (tipo1 = 'float64') or (tipo2 = 'float64') then
    EmpilhaTipo('float64')
  else
    EmpilhaTipo('int64');
end;

procedure TSemantico.EmpilhaTipo(const Tipo : string);
begin
  FTipo.Tipo := Tipo;
  Pilha.Push(FTipo);
end;

procedure TSemantico.executeAction(action : integer; const token : TToken);
begin
  tipo1 := '';
  tipo2 := '';

  case action of
    01: acaoSemantica01(token);
    02: acaoSemantica02(token);
    03: acaoSemantica03(token);
    04: acaoSemantica04(token);
    05: acaoSemantica05(token);
    06: acaoSemantica06(token);
    07: acaoSemantica07(token);
    08: acaoSemantica08(token);
    09: acaoSemantica09(token);
    10: acaoSemantica10(token);
    11: acaoSemantica11(token);
    12: acaoSemantica12(token);
    13: acaoSemantica13(token);
    14: acaoSemantica14(token);
    15: acaoSemantica15(token);
    16: acaoSemantica16(token);
    17: acaoSemantica17(token);
    18: acaoSemantica18(token);
    19: acaoSemantica19(token);
    20: acaoSemantica20(token);
    21: acaoSemantica21(token);
    22: acaoSemantica22(token);
  end;
end;

end.
