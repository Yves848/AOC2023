$lines = (Get-Content ..\data.txt) -split "\n"
$colors = @{
  red   = 12
  green = 13
  blue  = 14
}

$points = 0
$lines | ForEach-Object {
  $games, $pass = $_ -split ":"
  $id = [regex]::new('\d{1,}')
  $possible = $true
  $gamepoint = ($id.Match($games)).Value
  $pass -split ';' | ForEach-Object {
    
    $pairs = $_ -split ','
    $rnb = [regex]::new('\d{1,}')
    $rcol = [regex]::new('(red)|(blue)|(green)')
    $i = 0
    while ( $possible -and ($i -lt $pairs.Count ) ) {
      $nb = [int]($rnb.Match($pairs[$i])).Value
      $color = $rcol.Match($pairs[$i]).Value
      $possible = ($nb -le $colors[$color])
      $i++
    }
  }
  if ($possible) {
    $points = $points + $gamepoint
  }
}
$points