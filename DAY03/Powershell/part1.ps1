$lines = (Get-Content -path ..\example.txt) -split "\n"
$r2 = [regex]::new('[^(\.)|(\d{1,})]')
$r = [regex]::new('\d{1,}')
function isAdjacent(
  [int]$line,
  [int]$col,
  [int]$len
) {
  $adj = $false
  # Tester sur la même ligne
  foreach($match in $r2.Matches($lines[$line])) {
    $i = $match.Index
    if (-not $adj) {
      $adj = ($i -eq ($col+$len))
    }
  }
  # if (($line -gt 0) -and ($line -lt $lines.Count)) {
  #   # Tester ligne suivante
  #   $r2.Matches($lines[$line+1])
  # }
  $adj
}


foreach($line in $lines) {
  $i = $lines.IndexOf($line)
  $numbers = $r.Matches($line)
  foreach($number in $numbers) {
    if (isAdjacent -line $i -col $number.Index -len $number.Length) {
      $number.Value
    }
  }
}
