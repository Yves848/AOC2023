$lines = (Get-Content ..\data.txt -Raw) -split "\n"
($lines | ForEach-Object {
  $r = $_ | Select-String  -Pattern '\d' -AllMatches 
  ($r.Matches.count -eq 1) ? [int]"$($r.Matches[0])$($r.Matches[0])" : [int]"$($r.Matches[0])$($r.Matches[-1])" 
} | Measure-Object -AllStats).Sum
