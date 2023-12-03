$lines = (Get-Content -path ..\example.txt) -split "\n"

function isAdjacent(
  [int]$line,
  [int]$col
) {

}
$r = [regex]::new('\d{1,}')
foreach($line in $lines) {
  $index = $lines.IndexOf($line)
  $numbers = $r.Matches($line)
  
  $index
}
