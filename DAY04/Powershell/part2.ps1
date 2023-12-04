[string[]]$lines = (Get-Content -Path ..\example.txt -Raw) -split "\n"

class Card {
  [string]$name
  [int[]]$numbers
  [int[]]$mynumbers
  [int]$winning
  [int]$score

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

$cards = @()
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

$cards