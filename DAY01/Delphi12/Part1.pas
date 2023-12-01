unit Part1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,System.RegularExpressions,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.FileCtrl, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    FileListBox1: TFileListBox;
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Memo1: TMemo;
    Splitter1: TSplitter;
    Button1: TButton;
    Button2: TButton;
    mp1: TMemo;
    procedure FormShow(Sender: TObject);
    procedure FileListBox1DblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  i : Integer;
  regEx : tRegEx;
  Match : tMAtch;
begin
  mp1.Clear;
  mp1.Lines.BeginUpdate;
  regEx := TRegEx.Create('\d');
  for I := 0 to Memo1.Lines.Count -1 do
  begin
    Match := regEx.Match(Memo1.Lines[i]);
    if Match.Success then
    begin

    end;
  end;
  mp1.Lines.EndUpdate;

end;

procedure TForm1.FileListBox1DblClick(Sender: TObject);
begin
  Memo1.Lines.LoadFromFile(FileListBox1.FileName);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  FileListBox1.Directory := '..\..\..\';
end;

end.
