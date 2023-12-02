$lines = (Get-Content ..\data.txt) -split "\n"

($lines | ForEach-Object {
  $games, $pass = $_ -split ":"
  $minimums = @{}
  $pass -split ';' | ForEach-Object {    
    $pairs = $_ -split ','
    $rnb = [regex]::new('\d{1,}')
    $rcol = [regex]::new('(red)|(blue)|(green)')
    $i = 0
    while (($i -lt $pairs.Count ) ) {
      $nb = [int]($rnb.Match($pairs[$i])).Value
      $color = $rcol.Match($pairs[$i]).Value
      if ($minimums[$color] -lt $nb) {
        $minimums[$color] = $nb
      }
      $i++
    }
  }
  $total = 1
  foreach($key in $minimums.keys) {
    $total = $total * $minimums[$key]
  }
  $total
} | Measure-Object -AllStats).Sum