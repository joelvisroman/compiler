unit compilador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  AdvMemo, AdvSplitter, Vcl.Menus, Vcl.ComCtrls, propscrl, SynEdit, Vcl.ImgList,
  System.Actions, Vcl.ActnList, ULexico, UToken, ULexicalError;

type
  Tfrmcompilador = class(TForm)
    W7Panel1: TPanel;
    btnovo: TSpeedButton;
    btabrir: TSpeedButton;
    btsalvar: TSpeedButton;
    btcopiar: TSpeedButton;
    btcolar: TSpeedButton;
    btrecortar: TSpeedButton;
    btcompilar: TSpeedButton;
    btgerarcodigo: TSpeedButton;
    btequipe: TSpeedButton;
    Splitter1: TSplitter;
    stBarra: TStatusBar;
    synEditor: TSynEdit;
    synMensagens: TSynEdit;
    actAcoes: TActionList;
    novo: TAction;
    abrir: TAction;
    salvar: TAction;
    copiar: TAction;
    colar: TAction;
    recortar: TAction;
    compilar: TAction;
    gerar: TAction;
    equipe: TAction;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure novoExecute(Sender: TObject);
    procedure abrirExecute(Sender: TObject);
    procedure salvarExecute(Sender: TObject);
    procedure copiarExecute(Sender: TObject);
    procedure colarExecute(Sender: TObject);
    procedure recortarExecute(Sender: TObject);
    procedure compilarExecute(Sender: TObject);
    procedure gerarExecute(Sender: TObject);
    procedure equipeExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure synEditorChange(Sender: TObject);
  private
    { Private declarations }
    {procedures}
    procedure plAdicionaLinhasIniciais;
    procedure plCompilarPrograma;
    {functions}
    {Realiza analise lexica}
    function flRetornaClasseToken(idToken: Integer) :string;
    {Auxiliar para formatar as mensagens apresentadas}
    function StrFormat(AText, Caracter: String; Size: Word): String;
  public
    { Public declarations }
    vbArquivoModificado: Boolean;
    gsCaminho : String;
  end;

var
  frmcompilador: Tfrmcompilador;

implementation

{$R *.dfm}

procedure Tfrmcompilador.abrirExecute(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    synEditor.Clear;
    synMensagens.Clear;
    synEditor.Lines.LoadFromFile(OpenDialog1.Filename);
    plAdicionaLinhasIniciais;
    stBarra.Panels[0].text := 'Não modificado';
    stBarra.Panels[1].Text := OpenDialog1.FileName;
    gsCaminho := OpenDialog1.FileName;
  end;
end;

procedure Tfrmcompilador.colarExecute(Sender: TObject);
begin
  synEditor.PasteFromClipboard;
end;

procedure Tfrmcompilador.compilarExecute(Sender: TObject);
begin
  plCompilarPrograma;
end;

procedure Tfrmcompilador.copiarExecute(Sender: TObject);
begin
  synEditor.CopyToClipboard;
end;

procedure Tfrmcompilador.equipeExecute(Sender: TObject);
begin
  synMensagens.Lines.Add('Joelvis Roman da Silva')
end;

function Tfrmcompilador.flRetornaClasseToken(idToken: Integer): string;
var
 lsClasse: string;
begin
  lsClasse := EmptyStr;
  case idToken of
    2: lsClasse := 'identificador';
    3,4,5,6,7,8,9,10,11,12,13,14,
    15,16: lsClasse := 'palavra reservada';
    17,18,19,20,21,22,23,
    24,25,26,27,28,29,30,31,32: lsClasse := 'símbolo especial';
    33: lsClasse := 'constante inteira';
    34: lsClasse := 'constante binária';
    35: lsClasse := 'constante hexadecimal';
    36: lsClasse := 'constante real';
    37: lsClasse := 'constante string';
    38: lsClasse := 'constante caracter';
  end;
  Result := lsClasse;
end;

procedure Tfrmcompilador.FormCreate(Sender: TObject);
begin
 stBarra.Panels[0].text := 'Não modificado';
 stBarra.Panels[1].Text := EmptyStr;
 plAdicionaLinhasIniciais;
 gsCaminho := EmptyStr;
end;

procedure Tfrmcompilador.gerarExecute(Sender: TObject);
begin
  synMensagens.Lines.Add('geração de código ainda não foi implementada');
end;

procedure Tfrmcompilador.novoExecute(Sender: TObject);
begin
  synEditor.Clear;
  synMensagens.Clear;
  gsCaminho := EmptyStr;
  plAdicionaLinhasIniciais;
  stBarra.Panels[0].text := 'Não modificado';
  stBarra.Panels[1].Text := EmptyStr;
end;

procedure Tfrmcompilador.plAdicionaLinhasIniciais;
var
 i : integer;
begin
  for i := 1 to 300 do
  begin
    synEditor.Lines.Add(EmptyStr);
  end;
end;

procedure Tfrmcompilador.plCompilarPrograma;
var
 lexico : TLexico;
 t : TToken;
 i,
 numerolinha : Integer;
 conteudoMensagem,
 mensagemErro : string;
 erro : boolean;
begin
  erro := false;
  lexico := TLexico.create;
  try
   for i := 0 to synEditor.Lines.Count -1 do
   begin
     numerolinha := i;
     lexico.setInput(synEditor.Lines.Strings[i]);
      try
       t := lexico.nextToken;
       while (t <> nil) do
       begin
         conteudoMensagem := StrFormat(IntToStr(numeroLinha + 1),' ',12) +  StrFormat(flRetornaClasseToken(t.getId()),' ',25) +  t.getLexeme().trim();
         synMensagens.Lines.Add(conteudoMensagem);
         t.Destroy;
         t := lexico.nextToken;
       end;
      except
       on ex : ELexicalError do
       begin
         erro := true;
         synMensagens.Lines.Clear;
         mensagemErro:= 'Erro na linha ' + Integer.toString(numeroLinha + 1) + ' - ' + Trim(synEditor.Lines.Strings[i]) + ' ' + ex.getMessage();
         synMensagens.Lines.Add(mensagemErro);
         break;
       end;
     end;
   end;
   if not(erro) then
   begin
     if not(synMensagens.Lines.Text.IsEmpty) then
     begin
       synMensagens.Lines.Insert(0,StrFormat('linha', ' ', 12) + StrFormat('classe', ' ', 25) + StrFormat('lexema', ' ', 6));
       synMensagens.Lines.Add('programa compilado com sucesso');
     end;
   end;
  finally
    lexico.Destroy;
  end;
end;

procedure Tfrmcompilador.recortarExecute(Sender: TObject);
begin
  synEditor.CutToClipboard;
end;

procedure Tfrmcompilador.salvarExecute(Sender: TObject);
begin
 if gsCaminho = EmptyStr then
 begin
   if SaveDialog1.Execute then
   begin
     synEditor.Lines.SaveToFile(SaveDialog1.FileName);
     stBarra.Panels[0].text := 'Não modificado';
     stBarra.Panels[1].text := SaveDialog1.FileName;
     gsCaminho := SaveDialog1.FileName;
     synMensagens.Clear;
   end;
 end
 else
   begin
     synEditor.Lines.SaveToFile(gsCaminho);
     stBarra.Panels[0].text := 'Não modificado';
     synMensagens.Clear;
   end;
end;

function Tfrmcompilador.StrFormat(AText, Caracter: String; Size: Word): String;
var
  i: Integer;
begin
  Result := Copy(AText, 1, Size);
  for i := Length(AText) to Size - 1 do
    Result := Result + Caracter;
end;

procedure Tfrmcompilador.synEditorChange(Sender: TObject);
begin
  stBarra.Panels[0].text := 'Modificado';
  if (synEditor.Lines.Count = 1) then
    plAdicionaLinhasIniciais;
end;

end.
