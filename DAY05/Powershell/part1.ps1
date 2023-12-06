$lines = Get-Content -Path ..\data.txt -Raw

$seed, $maps = $lines -Split ('\n\n')
$rseed = [regex]::new("(\d{1,})")

$aseeds = @()
$soils = @()
$fertilizers = @()
$water = @()
$light = @()
$temperature = @()
$humidity = @()
$locations = @()

$seeds = $rseed.Matches($seed) | % {
  $_.Value
}

foreach ($seed in $seeds) {
  #$seed = $seeds[0]
  Write-Host "New Seed : $seed" -ForegroundColor Blue
  [int64]$l = $seed
  $aseeds += $seed
  foreach ($map in $maps) {
    $m = $map -split ('\n')
    Write-Host $m[0]
    $i = 1
    while ($i -lt $m.Count) {
      $m1 = $m[$i]
      [int64]$dest, [int64]$source, [int64]$len = $m1 -split (' ') 
      [int64]$dest2 = ([int64]$dest + [int64]$len) - 1
      [int64]$source2 = ([int64]$source + [int64]$len) - 1
      Write-Host "$m1"
      Write-Host "Sources : $source - $source2  "
      Write-Host "Destinations : $dest - $dest2  "
        
      if (($l -ge $source) -and ($l -le $source2)) {
        [int64]$diff = $l - $source
        [Int64]$d = $dest + $diff
        $l = $d
        Write-Host "Diff : $diff  D : $D Seed : $l"
        $i = $m.Count
      }
      $i = $i + 1
    }
    if ($map -cmatch "to-fertilizer") {
      $fertilizers += $l 
    }
    if ($map -cmatch "to-soil") {
      $soils += $l 
    }
    if ($map -cmatch "to-water") {
      $water += $l 
    }
    if ($map -cmatch "to-temperature") {
      $temperature += $l 
    }
    if ($map -cmatch "to-humidity") {
      $humidity += $l 
    }
    if ($map -cmatch "to-location") {
      $locations += $l 
    }
    if ($map -cmatch "to-light") {
      $light += $l 
    }
    Write-Host "seed $l" -ForegroundColor Red
  } 
  
}
#Destination Source Len
#Seed 79, soil 81, fertilizer 81, water 81, light 74, temperature 78, humidity 78, location 82.
$i = 0
[int64]$min = 999999999
while ($i -lt $aseeds.Length) {
  Write-Host "Seed $($aseeds[$i]), Soil $($soils[$i]), fertilizer $($fertilizers[$i]), water $($water[$i]), light $($light[$i]), temperature $($temperature[$i]), humidity $($humidity[$i]), location $($locations[$i])"
  if($locations[$i] -lt $min) {
    $min = $locations[$i]
  }
  $i = $i += 1
}

Write-Host "min : $min"
