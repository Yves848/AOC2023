﻿unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.IOUtils, System.StrUtils,
  System.Generics.Collections, System.RegularExpressions,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

const
  DL = AnsiString(#13#10#13#10);
  L = AnsiString(#13#10);

type

  tGhostDictionary = tDictionary<string, tarray<string>>;

  TForm1 = class(TForm)
    cbFichier: TComboBox;
    Fichier: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    lblProgres: TLabel;
    Button3: TButton;
    mDirections: TMemo;
    MKeys: TMemo;
    procedure cbFichierChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    directions: tarray<char>;
    nodes: tDictionary<string, tarray<string>>;
    nodesGhost: tGhostDictionary;
    GhostKeys: tlist<string>;
    regexZ: tregex;

    procedure CreeDirections(line: string);
    procedure CreeNodes(line: string);
    procedure parsefile;
    function isAllZ(Keys: tList<string>): boolean;
    function isAllA(Keys: tList<string>): boolean;
  public
    { Public declarations }
    pause: boolean;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  i: Integer;
  iDir: Integer;
  pnode: tArray<string>;
  key: string;
begin
  // trouvez ZZZ
  Nodes.TryGetValue('AAA', pNode);
  i := 1;
  iDir := low(directions);
  while true do
  begin
    case directions[iDir] of
      'L':
        begin
          key := pNode[0]

        end;
      'R':
        begin
          key := pNode[1];
        end;
    end;
    Memo2.Lines.Add(key);
    if (key = 'ZZZ') then
    begin
      break
    end;
    inc(i);
    inc(iDir);
    if (iDir > high(directions)) then
      iDir := low(directions);
    Nodes.TryGetValue(key, pNode);
  end;
  Memo2.Lines.Add(i.ToString());
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i: integer;
  iDir: integer;
  keys: tlist<string>;
  key: string;
  next: string;
  pNode: tArray<string>;
  nexts: tlist<string>;
  GhostEnum: tEnumerator<string>;
begin
  Memo2.Clear;

  iDir := low(directions);
  Memo2.Lines.Add(timetostr(now));
  GhostEnum := GhostKeys.GetEnumerator();
  while GhostEnum.MoveNext do
  begin
    keys := tlist<string>.create([GhostEnum.Current]);
    i := 0;
    while (not isAllZ(keys)) do
    begin
      while (Pause) do
        Application.ProcessMessages;

      nexts := tlist<string>.create;
      //mDirections.Lines.Add(directions[iDir]);
      for key in keys do
      begin
        nodes.TryGetValue(key, pnode);
        case directions[iDir] of
          'L':
            begin
              next := pNode[0];
              nexts.Add(next);
            end;
          'R':
            begin
              next := pNode[1];
              nexts.Add(next);
            end;
        end;
      end;
      //Memo2.Lines.Add(directions[iDir] + ' => ' + string.Join('   ', nexts.ToArray()));
      keys.Free;
      keys := tlist<string>.create(nexts);
      Nexts.Free;
      inc(i);
      if (i mod 100 = 0) then
      begin
        lblProgres.caption := i.ToString();
        application.ProcessMessages;
      end;
      inc(iDir);
      if (iDir > high(directions)) then
        iDir := low(directions);
    end;
    Memo2.Lines.Add(directions[iDir] + ' => ' + string.Join('   ', keys.ToArray()));
    memo2.Lines.Add(i.ToString());
  end;
  Memo2.Lines.Add(timetostr(now));
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  pause := not pause;
end;

procedure TForm1.cbFichierChange(Sender: TObject);
begin
  memo1.Lines.BeginUpdate;
  Memo1.Clear;
  Memo1.Lines.LoadFromFile(tPath.Combine('../../..', cbFichier.text));
  Memo1.Lines.EndUpdate;
  parsefile;
end;

procedure TForm1.CreeDirections(Line: string);
begin
  directions := nil;
  directions := line.ToCharArray(0, line.Length);
end;

procedure TForm1.CreeNodes(line: string);
var
  key, left, right: string;
  regex: tregex;
  regex2: tregex;
  Matches: TMatchCollection;
  Match: tMAtch;
  Match2: tMAtch;
  i: Integer;
  pNodes: tarray<string>;
begin
  if (line.Trim() <> '') then
  begin
    regEx := tRegex.create('\b\w{3}\b');
    regEx2 := tRegex.Create('^\b\w*A\b');
    Matches := regEx.Matches(line);
    I := 0;
    for match in Matches do
    begin
      if Match.Success then
        case i of
          0:
            begin
              key := Match.Value;
              if (regex2.isMatch(key)) then
              begin
                nodesGhost.Add(key, []);
              end;
            end;
          1:
            begin
              left := Match.Value;
            end;
          2:
            begin
              right := Match.Value;
            end;
        end;
      inc(i);
    end;
    pNodes := tArray<string>.Create(left, right);
    Nodes.Add(key, pNodes);

  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  regexZ := tRegex.Create('^\b\w*Z\b');
  pause := false;
  cbFichierChange(sender);
end;

function TForm1.isAllA(Keys: tList<string>): boolean;
var
  keyEnum: TEnumerator<string>;
  str: string;
begin
  if MKeys.Lines.Count = high(MKeys.Lines.Count) - 1 then
    MKeys.Clear;

  MKeys.Lines.Add(string.Join(' || ', Keys.ToArray()));
  result := true;
  keyEnum := keys.GetEnumerator();
  while keyEnum.MoveNext do
  begin
    result := result and regexZ.isMatch(keyEnum.Current);
  end;
  keyEnum.Free;

end;

function TForm1.isAllZ(Keys: tList<string>): boolean;
var
  keyEnum: TEnumerator<string>;
  str: string;
begin
  result := true;
  keyEnum := keys.GetEnumerator();
  while (result and keyEnum.MoveNext) do
  begin
    result := result and regexZ.isMatch(keyEnum.Current);
  end;
  keyEnum.Free;
end;

procedure TForm1.parsefile;
var
  str: string;
  res: tarray<string>;
  i: integer;
  ghostEnum: TEnumerator<string>;
begin
  mKeys.Clear;
  str := memo1.Lines.text;
  res := str.Split([L]);
  directions := nil;
  creeDirections(res[0]);
  if GhostKeys <> nil then
    FreeandNil(GhostKeys);
  GhostKeys := tlist<string>.create;
  nodes.Free;
  nodesGhost.Free;
  Nodes := tDictionary < string, tarray<string> > .create;
  nodesGhost := tGhostDictionary.Create();
  i := 1;
  while (i < length(res)) do
  begin
    creeNodes(res[i]);
    inc(i);
  end;
  ghostEnum := nodesGhost.Keys.GetEnumerator();
  while ghostEnum.MoveNext do
  begin
    if (ghostEnum.Current.Trim() <> '') then
      GhostKeys.Add(ghostEnum.Current);
  end;
  MKeys.Lines.Add(string.Join(' | ', GhostKeys.ToArray()));
end;

end.
²

