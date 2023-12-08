unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.IOUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    cbFichier: TComboBox;
    Fichier: TLabel;
    Memo1: TMemo;
    procedure cbFichierChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.cbFichierChange(Sender: TObject);
begin
  memo1.Lines.BeginUpdate;
  Memo1.Lines.LoadFromFile(tPath.Combine('../../..',cbFichier.text));
end;

end.
