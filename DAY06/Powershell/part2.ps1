[string[]]$lines = (Get-Content -Path ..\data.txt -Raw) -split "\n"

$r = [regex]::new('\d{1,}')

function nbposs(
  [int64]$r,
  [int64]$d
) {
  [int64]$nb = 0
  [int64]$s = 1
  while ($s -lt $r) {
    $x = ($r - $s)
    if (($x * $s) -gt $d) {
      $nb = $nb + 1
    }
    $s = $s + 1
  }
  return $nb
}

[int64[]]$t = @()
$r.Matches($lines[0].Replace(' ',"")) | ForEach-Object {
  $t += $_.Value
}
[int64[]]$d = @()
$r.Matches($lines[1].Replace(' ','')) | ForEach-Object {
  $d += $_.Value
}

$i = 0
[int64]$r = 1
while ($i -lt $t.Count) {
  $r = $r * (nbposs -r $t[$i] -d $d[$i])
  $i = $i +1
}
$r
