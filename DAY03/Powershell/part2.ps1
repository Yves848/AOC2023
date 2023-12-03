$lines = (Get-Content -Path ..\data.txt -Raw) -split "\n"
$r2 = [regex]::new('\*')
$r = [regex]::new('\d{1,}')

function gauche(
  [string]$line
) {
  $num = $r.Matches($line)
  $result = ($num | Where-Object { $col -in $_.Index..($_.Index + ($_.Length)) }).value
  return $result
}
function droite(
  [string]$line
) {
  $num = $r.Matches($line)
  $result = ($num | Where-Object { $col -in ($_.Index-1)..(($_.Index) + ($_.Length )) }).value
  return $result
}

function isAdjacent(
  [int]$col
) {
  $nb = @()
  $l = $lines.IndexOf($line)
  $line = $lines[$l]
  $value = gauche -line $line
  if ($value) { $nb += $value }
  else {
    $value = droite -line $line
    if ($value) { $nb += $value }
  }
  

  $line = $lines[$l - 1]
  $value = gauche -line $line
  if ($value) { $nb += $value }
  else {
    $value = droite -line $line
    if ($value) { $nb += $value }
  }

  $line = $lines[$l + 1]
  $value = gauche -line $line
  if ($value) { $nb += $value }
  else {
    $value = droite -line $line
    if ($value) { $nb += $value }
  }
  return $nb
}

$sum = 0
foreach ($line in $lines) {
  $i = $lines.IndexOf($line)
  $stars = $r2.Matches($line)
  foreach ($star in $stars) {
    $res = isAdjacent -col $star.Index
    Write-Host "$($res[0]),$($res[1])" 
  }
} 
