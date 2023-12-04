unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  System.Generics.Collections;

type
  tCard = class
  Private
    fName: String;
    fNumbers: tList<Int32>;
    fMyNumbers: tList<Int32>;
    fWinning: Integer;
    fScore: Integer;
  published
    property Name: String read fName write fName;
    property Numbers: tList<Int32> read fNumbers write fNumbers;
    property MyNumbers: tList<Int32> read fMyNumbers write fMyNumbers;
    Property Winning: Integer read fWinning write fWinning;
    Property Score: Integer read fScore write fScore;
  public
    Constructor create(pres: String); overload;
    Constructor create(pname : String; pwinning : integer; pscore : integer); overload;
  end;

  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Memo2: TMemo;
    Button4: TButton;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
    Cards: tList<tCard>;
    CopyCards: tList<tCard>;
    Procedure CopyCard(i : Integer; nb: Integer);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Memo1.Clear;
  Memo1.Lines.LoadFromFile('..\..\..\example.txt');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Memo1.Clear;
  Memo1.Lines.LoadFromFile('..\..\..\data.txt');
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  i: Integer;
  line: String;
  res: tArray<String>;
  pCard: tCard;
begin
  i := 0;
  if Cards <> nil then
    Cards.Free;
  Cards := tList<tCard>.Create;
  while i <= Memo1.Lines.Count - 1 do
  begin

    pCard := tCard.create(Memo1.Lines[i]);
    Cards.Add(pCard);
    //Memo2.Lines.Add(pCard.Score.ToString());
    Memo2.Lines.Add(pCard.Winning.ToString());
    inc(i);
  end;

end;

procedure TForm1.Button4Click(Sender: TObject);
var
  Enum : TEnumerator<tCard>;
  score : integer;
begin
  Enum := Cards.GetEnumerator();
  while Enum.MoveNext do
  begin
     Score := Score + enum.Current.Score;
  end;
  
  Enum.Free;  
  Memo2.Clear;
  Memo2.Lines.Add(Score.ToString());
end;

procedure TForm1.Button5Click(Sender: TObject);
var 
   i : integer;
begin
 if CopyCards <> nil then
    CopyCards.Free;
  CopyCards := tList<tCard>.Create;

  i := 0;
  while (i <= Cards.Count -1) do
  begin
    if (Cards[i].Winning > 0) then
    begin
       CopyCard(i+1,Cards[i].Winning);
    end;
    inc(i);
  end;
  
  Memo2.Lines.Add(Cards.Count.ToString());
  Memo2.Lines.Add(CopyCards.Count.ToString());
end;

procedure TForm1.CopyCard(i, nb: Integer);
var
  pCard : tCard;
  c : Integer;
begin
    c := 1;
    while (c <= nb) do
    begin
      pCard := tCard.create(Cards[i].Name,Cards[i].Winning, Cards[i].Score);
      CopyCards.Add(pCard);
      if (Cards[i].Winning > 0) then
      begin
        copyCard(i+1,Cards[i].Winning);
      end;
      
      inc(i);
      inc(c);
    end;
    
end;

{ tCard }

constructor tCard.create(pres: String);
var
  res: tArray<String>;
  sNumbers: tArray<string>;
  sMyNumbers: tArray<string>;
  i: Integer;
begin
  res := pres.split([':', '|']);
  Name := res[0];
  sNumbers := res[1].trim().split([' ']);
  sMyNumbers := res[2].trim().split([' ']);
  Numbers := tList<Int32>.create();
  MyNumbers := tList<Int32>.create();
  i := low(sNumbers);
  while (i <= high(sNumbers)) do
  begin
    if (sNumbers[i].trim() <> '') then
      Numbers.Add(strtoint(sNumbers[i]));
    inc(i);
  end;
  i := low(sMyNumbers);
  while (i <= high(sMyNumbers)) do
  begin
    if (sMyNumbers[i].trim() <> '') then
      MyNumbers.Add(strtoint(sMyNumbers[i]));
    inc(i);
  end;

  Winning := 0;
  Score := 0;
  for i in MyNumbers do
  begin
    if Numbers.IndexOf(i) > -1 then
    begin
      if (Score = 0) then
        inc(fScore)
      else
      begin
        Score := Score * 2;
      end;
      inc(fWinning);
    end;
  end;

end;

constructor tCard.create(pname: String; pwinning, pscore: integer);
begin
     name := pname;
     winning := pwinning;
     score := pscore;
end;

end.
