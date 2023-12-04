[string[]]$lines = (Get-Content -Path ..\data.txt -Raw) -split "\n"

class Card {
  [string]$name
  [int[]]$numbers
  [int[]]$mynumbers
  [int]$winning
  [int]$score
  [bool]$copy

  Card(
    [string]$name
  ) {
    $this.name = $name
    $this.numbers = @()
    $this.mynumbers = @()
    $this.winning = 0
    $this.score = 0
  }

  isWinning(
  ) {
    foreach ($point in $this.mynumbers) {
      if (($this.numbers.IndexOf($point) -ne -1)) {
        if ($this.score -eq 0) {
          $this.score = $this.score + 1
        }
        else {
          $this.score = $this.score * 2
        }
        $this.winning = $this.winning + 1
      } 
    }
  }
}

[Card[]]$cards = @()
[Card[]]$global:copies = @()


foreach ($line in $lines) {
  [string]$card, $numbers = $line.Split('|')
  $cardnum, $num = $card.Split(":")
  $r = [regex]::new('\d{1,}')
  $ocard = [card]::new($cardnum)
  foreach ($v in $r.Matches($num)) {
    $ocard.numbers += [int]$v.Value
  }

  foreach ($v in $r.Matches($numbers)) {
    $ocard.mynumbers += [int]$v.Value
  }
  $ocard.isWinning()
  $cards += $ocard
}



function copyCards(
  [int]$i,
  [int]$nb
) {
  $c = 1
  $j = $i
  while ($c -le $nb) {
    Write-Host " **  copy ** $($cards[$j].name) $($cards[$j].winning)"
    $ocard = [card]::new($cards[$j].name)
    $ocard.winning = $cards[$j].winning
    $ocard.mynumbers = $cards[$j].mynumbers 
    $ocard.numbers = $cards[$j].numbers
    $ocard.score = $cards[$j].score
    $global:copies += $ocard
    if ($cards[$j].winning -gt 0) {
      Write-Host " **  Recursion ** $($cards[$j].name) $($cards[$j].winning)"
      copyCards -i ($j + 1) -nb $cards[$j].winning
    }
    $j = $j + 1
    $c = $c + 1
  }
  
}

Write-Host "Part 1 : $(($cards | Select-Object -ExpandProperty score | Measure-Object -Sum).sum )"



Write-Host "Part 2 :"

$iCard = 0
while ($iCard -lt $cards.Count) {
  if ($cards[$iCard].winning -gt 0) {
    copyCards -i ($iCard + 1) -nb $cards[$iCard].winning
  }
  $iCard = $iCard + 1
}
$cards.Count 
$global:copies.Count