unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.IOUtils, Vcl.ExtCtrls,
  system.RegularExpressions, system.StrUtils, System.Generics.Collections, system.Math;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    cbFichier: TComboBox;
    Panel1: TPanel;
    pnlmain: TPanel;
    btnPart2: TButton;
    btnPart1: TButton;
    Panel2: TPanel;
    Splitter1: TSplitter;
    Memo1: TMemo;
    mSource: TListBox;
    procedure FormShow(Sender: TObject);
    procedure btnPart1Click(Sender: TObject);
    function sum(ar: tlist<integer>): boolean;
    procedure cbFichierChange(Sender: TObject);
  private
    { Private declarations }
    regEx: tRegex;
    procedure ParseFile(sFile: string);
    function makeIntArray(line: string): tlist<Integer>;
    function extrapole(ar: tlist<integer>): tlist<integer>;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnPart1Click(Sender: TObject);
type
  myList = tList<Integer>;
var
  line: myList;
  line2: myList;

  list: tlist<myList>;
  Matches: TMatchCollection;
  Match: tMatch;
  regEx: tRegEx;

  listEnum: TEnumerator<Mylist>;
  list2: tEnumerator<integer>;
  i, j, total: integer;
  iline: integer;
  somme: integer;

  function makeline(list: mylist): string;
  var
     total : string;
  begin
    var ls: tlist<string> := tlist<string>.Create;
    var enum: TEnumerator<Integer> := list.GetEnumerator();
    while enum.MoveNext do
    begin
      ls.Add(enum.Current.ToString);
    end;
    total := ls[ls.Count-1];
    ls.Delete(ls.Count-1);
    result := string.Join(', ', ls.ToArray())+'   Total : '+total;
    ls.Free;
  end;
begin
  Memo1.Clear;
  somme := 0;
  iLine := 0;

  while (iline <= mSource.items.Count - 1) do
  begin
    list := tlist < tlist<Integer> > .Create;
    line := makeIntArray(mSource.items[iline]);
    //line := makeIntArray(mSource.items[mSource.ItemIndex]);
    list.Add(line);
    //Memo1.Lines.Add(makeline(line));
    while (not sum(line)) do
    begin
      line := extrapole(list[list.Count - 1]);
      //Memo1.Lines.Add(makeline(line));
      list.Add(line);
    end;

    i := list.Count - 1;
    total := 0;
    while (i >= 0) do
    begin
      line := list[i];
      total := total + line[line.Count - 1];
      line.Add(total);
      dec(i);
    end;
    memo1.Lines.Add(total.ToString);
    somme := somme + total;
          //8819988
    i := 0;
    while i < list.Count do
    begin
      Memo1.Lines.Add(makeline(list[i]));
      inc(i);
    end;
    inc(iLine);
  end;
  list.Free;
  memo1.Lines.Add(somme.ToString);
end;

procedure TForm1.cbFichierChange(Sender: TObject);
begin
  parseFile(cbFichier.Text);
end;

function TForm1.extrapole(ar: tlist<integer>): tlist<integer>;
var
  i: Integer;
begin
  result := tlist<Integer>.create;
  i := 1;
  while (i <= (ar.Count - 1)) do
  begin
    result.Add(ar[i] - ar[i - 1]);
    inc(i);
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
var
  files: tarray<string>;
  i: integer;
  sPath: string;
begin
  // récupérer la liste des exemples
  regEx := tRegEx.Create('-?\d{1,}');
  sPath := tPath.Combine(ExtractFilePath(paramstr(0)), '..');
  files := tDirectory.GetFiles(sPath, '*.txt');
  i := low(files);
  cbFichier.Items.Clear;
  while i <= high(files) do
  begin
    cbFichier.Items.Add(ExtractFileName(files[i]));
    inc(i);
  end;
  cbFichier.ItemIndex := cbFichier.Items.IndexOf('Example.txt');
  parseFile(cbFichier.Text);
end;

function TForm1.makeIntArray(line: string): tlist<Integer>;
var
  Matches: TMatchCollection;
  Match: tMatch;
  list: tlist<Integer>;
begin
  Matches := regEx.Matches(line);
  list := tlist<Integer>.Create;
  for match in matches do
  begin
    if match.Success then
      list.Add(match.Value.ToInt64);
  end;
  result := list;
end;

procedure TForm1.ParseFile(sFile: string);
begin
  //
  mSource.items.LoadFromFile(sFile);
end;

function TForm1.sum(ar: tlist<integer>): boolean;
var
  arEnum: TEnumerator<Integer>;
begin
  result := true;
  arEnum := ar.GetEnumerator();
  while result and arEnum.MoveNext do
  begin
    result := result and (arEnum.Current = 0)
  end;
end;

end.

