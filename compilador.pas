unit compilador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  AdvMemo, AdvSplitter, Vcl.Menus, Vcl.ComCtrls, propscrl;

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
    AdvMemo1: TAdvMemo;
    Splitter1: TSplitter;
    StatusBar1: TStatusBar;
    AdvMemo2: TAdvMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmcompilador: Tfrmcompilador;

implementation

{$R *.dfm}

end.
