$lines = (Get-Content data.txt) -split "\n"
$numbers = @("one", "two", "three", "four", "five", "six", "seven", "eight", "nine")
($lines | ForEach-Object {
  $line = $_
  $temp = ($numbers -join ')|(')
  $pattern = "($($temp))"
  $reg1 = [regex]::new($pattern)
  $match = $reg1.Match($line)
  if ($match.Success) {
    $index = ($numbers.IndexOf($_.Value) + 1)
    $result = $line.Replace($_.Value, $index)
    $line = $result
  }
  $reg2 = [regex]::new($pattern,"RightToLeft")
  $match = $reg2.Match($line)
  if ($match.Success) {
    $index = ($numbers.IndexOf($_.Value) + 1)
    $result = $line.Replace($_.Value, $index)
    $line = $result
  }
  $r = $line | Select-String  -Pattern '(\d)' -AllMatches 
  if ($r.Matches.Count -gt 0) {
    ($r.Matches.count -eq 1) ? [int]"$($r.Matches[0])$($r.Matches[0])" : [int]"$($r.Matches[0])$($r.Matches[-1])" 
  }
} | Measure-Object -AllStats).Sum


