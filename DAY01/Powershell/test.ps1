$lines = (Get-Content example2.txt) -split "\n"
$sum = 0
$lines | % {
  $r = $_ | Select-String  -Pattern '\d' -AllMatches 
  $r.Line
  $val = ($r.Matches.count -eq 1) ? [int]"$($r.Matches[0])$($r.Matches[0])" : [int]"$($r.Matches[0])$($r.Matches[-1])" 
  $sum = $sum + $val
}
$sum
