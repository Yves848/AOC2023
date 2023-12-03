$lines = (Get-Content -Path ..\data.txt -Raw) -split "\n"
$r2 = [regex]::new('\*')
$r = [regex]::new('\d{1,}')
$rr = [regex]::new('\d{1,}','RightToLeft')
function gauche(
  [string]$line
) {
  $num = $r.Matches($line)
  foreach($n in $num) {
    if ($col -in ($n.Index) .. ($n.Index+($n.Length-1))) {
      return $n.Value
    }
  }
}
function droite(
  [string]$line
) {
  $num = $rr.Matches($line)
  foreach($n in $num) {
    if ($col -in ($n.Index) .. ($n.Index+($n.Length-1))) {
      return $n.Value
    }
  }
}

function isAdjacent(
  [int]$col
) {
  $nb = @()
  $l = $lines.IndexOf($line)
  $line = $lines[$l]
  $value = gauche -line $line
  if ($value) { $nb += $value }
  $value = droite -line $line
  if ($value) { $nb += $value }
  
  $line = $lines[$l - 1]
  $num = $r.Matches($line)
  foreach($n in $num) {
    if ($col -in ($n.Index-1) .. ($n.Index+($n.Length))) {
      $nb += $n.Value
    }
  }
  
  $line = $lines[$l + 1]
  $num = $r.Matches($line)
  foreach($n in $num) {
    if ($col -in ($n.Index-1) .. ($n.Index+($n.Length))) {
      $nb += $n.Value
    }
  }
  return $nb
}

$sum = 0
foreach ($line in $lines) {
  $stars = $r2.Matches($line)
  foreach ($star in $stars) {
    $res = isAdjacent -col $star.Index
    if ($res.Count -eq 2) {
      $sum = $sum + ([int]$res[0]*[int]$res[1])
      "$($res[0]),$($res[1])" | Out-File -FilePath "restult.txt" -Append
    }
  }
} 
$sum
