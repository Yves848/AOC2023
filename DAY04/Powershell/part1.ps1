[string[]]$lines = (Get-Content -Path ..\data.txt -Raw) -split "\n"

$cards = [ordered]@{}
$mynumbers = [ordered]@{}
$scores = [ordered]@{}
$cards2 = [ordered]@{}

foreach ($line in $lines) {
  [string]$card, $numbers = $line.Split('|')
  $cardnum, $num = $card.Split(":")
  $r = [regex]::new('\d{1,}')
  $val = @()
  foreach($v in $r.Matches($num)) {
   $val += [int]$v.Value
  }
  $cards[$cardnum] = $val
  
  $val = @()
  foreach($v in $r.Matches($numbers)) {
   $val += [int]$v.Value
  }
  $mynumbers[$cardnum] = $val
}

foreach($key in $cards.Keys) {
  $score = 0
  foreach($point in $mynumbers[$key]) {
    if (($cards[$key].IndexOf($point) -ne -1)) {
      
      if ($score -eq 0) {
        $cards2[$Key] = @($point)
        $score = $score + 1
      }
      else {
        $score = $score *2
        $cards2[$Key]+=$point
      }
    } 
  }
  $scores[$key] =$score
}


($scores.Values | Measure-Object -AllStats).sum

$cards2