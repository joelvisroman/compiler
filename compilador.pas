unit compilador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  AdvMemo, AdvSplitter, Vcl.Menus, Vcl.ComCtrls, propscrl, SynEdit, Vcl.ImgList,
  System.Actions, Vcl.ActnList;

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
    StatusBar1: TStatusBar;
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
    procedure actFileNewExecute(Sender: TObject);
    procedure novoExecute(Sender: TObject);
    procedure abrirExecute(Sender: TObject);
    procedure salvarExecute(Sender: TObject);
    procedure copiarExecute(Sender: TObject);
    procedure colarExecute(Sender: TObject);
    procedure recortarExecute(Sender: TObject);
    procedure compilarExecute(Sender: TObject);
    procedure gerarExecute(Sender: TObject);
    procedure equipeExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcompilador: Tfrmcompilador;

implementation

{$R *.dfm}

procedure Tfrmcompilador.abrirExecute(Sender: TObject);
begin
  ShowMessage('abrir');
end;

procedure Tfrmcompilador.actFileNewExecute(Sender: TObject);
begin
  ShowMessage('teste');
end;

procedure Tfrmcompilador.colarExecute(Sender: TObject);
begin
  ShowMessage('colar');
end;

procedure Tfrmcompilador.compilarExecute(Sender: TObject);
begin
  ShowMessage('compilar');
end;

procedure Tfrmcompilador.copiarExecute(Sender: TObject);
begin
  ShowMessage('copiar');
end;

procedure Tfrmcompilador.equipeExecute(Sender: TObject);
begin
  ShowMessage('equipe');
end;

procedure Tfrmcompilador.gerarExecute(Sender: TObject);
begin
  ShowMessage('gerar');
end;

procedure Tfrmcompilador.novoExecute(Sender: TObject);
begin
  ShowMessage('novo');
end;

procedure Tfrmcompilador.recortarExecute(Sender: TObject);
begin
  ShowMessage('recortar');
end;

procedure Tfrmcompilador.salvarExecute(Sender: TObject);
begin
  ShowMessage('salvar');
end;

end.
