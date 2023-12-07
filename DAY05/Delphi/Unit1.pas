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
    d1: Int64;
    d2: Int64;
    constructor create(line: string);
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
    procedure ComboBox1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
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
  // Les maps sont créées .....

  seedEnum := pSeeds.GetEnumerator();
  while seedEnum.MoveNext do
    // Parcourir les paires de seeds ......
  begin
    sLine := format('Seed %u - %u', [seedEnum.current.d1, seedEnum.current.d2]);
    Memo2.Lines.Add(sLine);
    Seed1 := seedEnum.current.d1;
    j := Seed1;
    nbSeeds := seedEnum.current.d2;
    // Pour chaque seed, parcourir les différentes maps pour trouver la location la plus proche.
    while (j < (Seed1 + nbSeeds)) do
    begin
        if (j mod 1000000 = 0) then
        begin
          Memo3.Lines.Add(format('J : %u',[j]));
          Application.ProcessMessages;
        end;
//      if (j = 82) then
//      begin

        //sLine := format('Seed %u', [j]);
        //Memo3.Lines.Add(sLine);

        // Parcourir les différentes maps pour convertir la valeur de la seed.
        seed2 := J;
        mapEnum := pmaps.GetEnumerator();
        while mapEnum.MoveNext do
        begin
          //sLine := format('%s', [mapEnum.current.name]);
          //Memo3.Lines.Add('       ' + sLine);
          coordEnum := mapEnum.current.Coords.GetEnumerator();

          while coordEnum.MoveNext do
          begin
            // commencer le mapping des seeds
            j2 := coordEnum.current.index(Seed2);
            //Memo3.Lines.Add('           ' + coordEnum.current.versString() + format('  Seed2 : %u j2 : %u', [Seed2, j2]));
            if (mapEnum.Current.name.Contains('to-loca')) then
                if (seedLocation > Seed2) then
                begin
                  SeedLocation := Seed2;
                   Memo2.Lines.Add(seedLocation.tostring());
                   Application.ProcessMessages;
                end;
            if (j2 <> seed2) then
            begin
              Seed2 := j2;
              break;
            end;
          end;
        end;
      //end;
      inc(j);
    end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i: integer;
  Enum: tEnumerator<tmap>;
  Coords: tEnumerator<tcoord>;
begin
  Memo3.Clear;
  Enum := pmaps.GetEnumerator();
  while Enum.MoveNext do
  begin
    Memo3.Lines.Add(Enum.current.name);
    Coords := Enum.current.Coords.GetEnumerator();
    while Coords.MoveNext do
    begin
      Memo3.Lines.Add(Coords.current.ToString());
    end;
    Coords.Free;
  end;
  Enum.Free;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  Memo1.Lines.LoadFromFile(tPath.Combine('..\..\..\', ComboBox1.Text));
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
  d1 := strtoint64(bornes[0]);
  d2 := strtoint64(bornes[1]);
end;

end.

