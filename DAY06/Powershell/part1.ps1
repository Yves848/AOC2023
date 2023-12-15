[string[]]$lines = (Get-Content -Path ..\data.txt -Raw) -split "\n"

$r = [regex]::new('\d{1,}')

function nbposs(
  [int]$r,
  [int]$d
) {
  [int]$nb = 0
  [int]$s = 1
  while ($s -lt $r) {
    $x = ($r - $s)
    if (($x * $s) -gt $d) {
      $nb = $nb + 1
    }
    $s = $s + 1
  }
  return $nb
}

[int[]]$t = @()
$r.Matches($lines[0]) | ForEach-Object {
  $t += $_.Value
}
[int[]]$d = @()
$r.Matches($lines[1]) | ForEach-Object {
  $d += $_.Value
}

$i = 0
$r = 1
while ($i -lt $t.Count) {
  $r = $r * (nbposs -r $t[$i] -d $d[$i])
  $i = $i +1
}
$r
