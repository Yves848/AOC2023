$lines = (Get-Content -path ..\data.txt) -split "\n"
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
    if (-not $adj) {
      $adj = ($i -eq ($col -1))
    } 
  }
  if (-not $adj) {
    if (($line -ge 0) -and ($line -lt $lines.Count)) {
      # tester le ligne au dessus
      if ($line -gt 0) {
      foreach($match in $r2.Matches($lines[$line-1])) {
        $i = $match.Index
        if (-not $adj) {
          $start = $col -1
          $end = ($len + $col)  
          $adj = ($i -in ($start..$end))
        }
        
      }
    }
      # Tester la ligne en dessous
      if ($line -lt $lines.Count) {
      foreach($match in $r2.Matches($lines[$line+1])) {
        $i = $match.Index
        if (-not $adj) {
          $start = $col -1
          $end = ($len + $col)  
          $adj = ($i -in ($start..$end))
        }
        
      }
    }
    }
  }
  $adj
}

$sum = 0
foreach($line in $lines) {
  $i = $lines.IndexOf($line)
  Write-Host "$($i+1)  : " 
  $numbers = $r.Matches($line)
  foreach($number in $numbers) {
    if (isAdjacent -line $i -col $number.Index -len $number.Length) {
       Write-Host "# $($number.Value)"
       $sum = $sum + [int]$number.Value
    }
  }
}

Write-Host "Sum : $sum"