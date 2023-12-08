unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.RegularExpressions,
  System.Classes, Vcl.Graphics, System.IOUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  System.Generics.Collections;

const
  DL = AnsiString(#13#10#13#10);
  L = AnsiString(#13#10);

type
  tcoord = class
  public
    source: Int64; // Source
    destination: Int64; // Destination
    L: Int64; // Longueur
    constructor create(pD, pS, pL: Int64);
    function versString(): string;
    function index(i: Int64): Int64;
  end;

  tSeed = class
  public
    Start: Int64;
    Nb: Int64;
    constructor create(line: string);
    function range: string;
    function enum: string;
  end;

  tmap = class
  public
    name: string;
    Coords: tlist<tcoord>;
    constructor create(line: string);
  end;

  TForm1 = class(TForm)
    ComboBox1: TComboBox;
    Memo1: TMemo;
    Button1: TButton;
    Memo2: TMemo;
    Button2: TButton;
    Memo3: TMemo;
    Memo4: TMemo;
    Label1: TLabel;
    eStep: TEdit;
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure parseFile;
    procedure createSeeds(line: string);
    procedure createmaps;
  public
    { Public declarations }
    res: tArray<string>;
    pmaps: tlist<tmap>;
    pSeeds: tlist<tSeed>;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  str: string;
  res: tarray<string>;
  i: integer;
  seedEnum: tEnumerator<tSeed>;
  mapEnum: tEnumerator<tmap>;
  coordEnum: tEnumerator<tcoord>;
  regEx: TRegEx;
  Match: tMatch;
  Matches: TMatchCollection;
  nornes: string;
  pseed: tSeed;
  Seed1, Seed2: Int64;
  nbSeeds: Int64;
  seedLocation: Int64;
  index: Int64;
  j2: Int64;
  j: Int64;
  sLine: string;
begin
  Memo3.Clear;
  Memo2.Clear;
  Memo4.Clear;
  str := Memo1.Lines.Text;
  res := str.Split([DL]);
  seedLocation := high(Int64);
  regEx := TRegEx.create('(\d{1,})\s(\d{1,})');
  Matches := regEx.Matches(res[0]);
  pSeeds := tlist<tSeed>.create;

  for Match in Matches do
  begin
    if Match.Success then
      str := Match.Value;
    pseed := tSeed.create(str);
    pSeeds.Add(pseed);
  end;

  i := 1;
  pmaps := tlist<tmap>.create;
  while i < length(res) do
  begin
    pmaps.Add(tmap.create(res[i]));
    inc(i);
  end;
  // Les maps sont cr��es .....

  seedEnum := pSeeds.GetEnumerator();
  while seedEnum.MoveNext do
    // Parcourir les paires de seeds ......
  begin
    sLine := format('Seed %u - %u', [seedEnum.current.Start, seedEnum.current.Nb]);
    Memo2.Lines.Add(sLine);
    Seed1 := seedEnum.current.Start;
    j := Seed1;
    nbSeeds := seedEnum.current.Nb;
    // Pour chaque seed, parcourir les diff�rentes maps pour trouver la location la plus proche.
    while (j < (Seed1 + nbSeeds)) do
    begin
      if (j mod 1000000 = 0) then
      begin
        eStep.Text := (format('J : %u', [j]));
        Application.ProcessMessages;
      end;
      seed2 := J;
      mapEnum := pmaps.GetEnumerator();
      while mapEnum.MoveNext do
      begin
        coordEnum := mapEnum.current.Coords.GetEnumerator();
        while coordEnum.MoveNext do
        begin
          // commencer le mapping des seeds
          j2 := coordEnum.current.index(Seed2);
          if (mapEnum.Current.name.Contains('to-loca')) then
            if (seedLocation > Seed2) then
            begin
              SeedLocation := Seed2;
              Memo4.Lines.Add(seedLocation.tostring());
              Application.ProcessMessages;
            end;
          if (j2 <> seed2) then
          begin
            Seed2 := j2;
            break;
          end;
        end;
        coordEnum.Free;
      end;
      mapEnum.Free;
      inc(j);
    end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  SeedEnum : TEnumerator<tSeed>;
begin
  SeedEnum := pSeeds.GetEnumerator();
  while SeedEnum.MoveNext do
  begin
    memo4.Lines.Add(seedEnum.Current.range);
  end;
  SeedEnum.Free;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  Memo1.Lines.LoadFromFile(tPath.Combine('..\..\..\', ComboBox1.Text));
  parseFile;
end;

procedure TForm1.createmaps;

begin

end;

procedure TForm1.createSeeds(line: string);
var
  Regex: tRegEx;
  Matches: TMatchCollection;
  Match: tMatch;
  res: tarray<string>;
begin
  if pSeeds <> nil then
    FreeandNil(pSeeds);
  pSeeds := tlist<tSeed>.Create;

  regEx := TRegEx.create('(\d{1,})\s(\d{1,})');
  Matches := regex.Matches(line);
  for Match in Matches do
  begin
    if Match.Success then
      pseeds.Add(tseed.create(Match.Value));
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ComboBox1Change(sender);
end;

procedure TForm1.parseFile;
var
  str: string;
begin
  str := Memo1.Lines.Text;
  if length(res) > 0 then
    res := nil;
  res := str.Split([DL]);
  createSeeds(res[0]);
end;

{ tmap }

constructor tmap.create(line: string);
var
  dsl: tarray<string>;
  sCoord: tarray<string>;
  i: integer;
  pCoord: tcoord;
begin
  dsl := line.Split([L]);
  name := dsl[0];
  Coords := tlist<tcoord>.create;
  i := 1;
  while i <= length(dsl) - 1 do
  begin
    sCoord := dsl[i].Split([' ']);
    pCoord := tcoord.create(strtoint64(sCoord[0]), strtoint64(sCoord[1]),
      strtoint64(sCoord[2]));
    Coords.Add(pCoord);
    inc(i);
  end;
end;

{ tcoord }

constructor tcoord.create(pD, pS, pL: Int64);
begin
  source := pS;
  destination := pD;
  L := pL;
end;

function tcoord.index(i: Int64): Int64;
var
  d1, d2: Int64;
  S1, S2: Int64;
  diff: Int64;
begin

  // Destination Source Len
  d1 := destination;
  d2 := (d1 + L) - 1;
  S1 := source;
  S2 := (S1 + L) - 1;
  result := i;
  if ((i >= S1) and (i <= S2)) then
  begin
    diff := i - S1;
    result := (d1 + diff);
  end;
end;

function tcoord.versString: string;
var
  d1, d2: Int64;
  S1, S2: Int64;
begin
  d1 := destination;
  d2 := (d1 + L) - 1;
  S1 := source;
  S2 := (S1 + L) - 1;
  result := format('D %u - %u S %u - %u', [d1, d2, S1, S2]);
end;

{ tSeed }

constructor tSeed.create(line: string);
var
  bornes: tarray<string>;
begin
  bornes := line.Split([' ']);
  Start := strtoint64(bornes[0]);
  nb := strtoint64(bornes[1]);
end;

function tSeed.enum: string;
var
  I: Integer;
begin
  result := format('%u', [Start]);
  for I := 1 to nb-1 do
  begin
    result := result + format(',%u',[Start+i])
  end;
  result := '['+result+']';
end;

function tSeed.range: string;
begin
  result := format('%u-%u', [start, (start + nb) - 1]);
end;

end.

