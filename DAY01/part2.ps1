$lines = (Get-Content data.txt) -split "\n"
$numbers = @("one", "two", "three", "four", "five", "six", "seven", "eight", "nine")
($lines | ForEach-Object {
  $line = $_
  $pattern = $numbers -join ')|('
  $founds = $_ | Select-String -Pattern "($($pattern))" -AllMatches
  if ($founds) {
    $founds.Matches | ForEach-Object {
      $index = ($numbers.IndexOf($_.Value) +1)
      $result = $line.Replace($_.Value, $index)
      $line = $result
    }
  }
  $r = $line | Select-String  -Pattern '(\d)' -AllMatches 
  ($r.Matches.count -eq 1) ? [int]"$($r.Matches[0])$($r.Matches[0])" : [int]"$($r.Matches[0])$($r.Matches[-1])" 
} | Measure-Object -AllStats).Sum

