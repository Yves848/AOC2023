$lines = Get-Content -Path ..\data.txt -Raw

$seed, $maps = $lines -Split ('\n\n')
$rseedpairs = [regex]::new("(\d{1,})\s(\d{1,})")
$rseed = [regex]::new("(\d{1,})")


$aseeds = @()
$soils = @()
$fertilizers = @()
$water = @()
$light = @()
$temperature = @()
$humidity = @()
$locations = @()
[int64]$min = 9999999999

$seeds = @()

$rseedpairs.Matches($seed) | % {
  [int64]$d1, [int64]$d2 = $_.Value -split " "
  [int64]$i64 = 0
  # Write-Host "$i64"
  while ($i64 -lt $d2) {
    $seed = [int64]($d1 + $i64)
    #     $i64 = $i64 + 1
    #     if (($i64 % 10000) -eq 0) {
    #       Write-Host 
    #     }
    #   }
    # }


    # foreach ($seed in $seeds) {
    #$seed = $seeds[0]
  
    [int64]$l = $seed
    $aseeds += $seed
    foreach ($map in $maps) {
      $m = $map -split ('\n')
      # Write-Host $m[0]
      $i = 1
      while ($i -lt $m.Count) {
        $m1 = $m[$i]
        [int64]$dest, [int64]$source, [int64]$len = $m1 -split (' ') 
        [int64]$dest2 = ([int64]$dest + [int64]$len) - 1
        [int64]$source2 = ([int64]$source + [int64]$len) - 1
        # Write-Host "$m1"
        # Write-Host "Sources : $source - $source2  "
        # Write-Host "Destinations : $dest - $dest2  "
        
        if (($l -ge $source) -and ($l -le $source2)) {
          [int64]$diff = $l - $source
          [Int64]$d = $dest + $diff
          $l = $d
          # Write-Host "Diff : $diff  D : $D Seed : $l"
          $i = $m.Count
        }
        $i = $i + 1
      }
      # if ($map -cmatch "to-fertilizer") {
      #   $fertilizers += $l 
      # }
      # if ($map -cmatch "to-soil") {
      #   $soils += $l 
      # }
      # if ($map -cmatch "to-water") {
      #   $water += $l 
      # }
      # if ($map -cmatch "to-temperature") {
      #   $temperature += $l 
      # }
      # if ($map -cmatch "to-humidity") {
      #   $humidity += $l 
      # }
      if ($map -cmatch "to-location") {
        # $locations += $l
        if ($l -lt $min) {
          $min = $l
          Write-Host "New Seed : $min" -ForegroundColor Blue
        } 
      }
      # if ($map -cmatch "to-light") {
      #   $light += $l 
      # }
      # Write-Host "seed $l" -ForegroundColor Red
    } 
  $i64 = $i64+1
  }
}
#Destination Source Len
#Seed 79, soil 81, fertilizer 81, water 81, light 74, temperature 78, humidity 78, location 82.
[int64]$i = 0
[int64]$min = 999999999
while ($i -lt $aseeds.Length) {
  # Write-Host "Seed $($aseeds[$i]), Soil $($soils[$i]), fertilizer $($fertilizers[$i]), water $($water[$i]), light $($light[$i]), temperature $($temperature[$i]), humidity $($humidity[$i]), location $($locations[$i])"
  if ($locations[$i] -lt $min) {
    $min = $locations[$i]
  }
  $i = $i += 1
}

Write-Host "min : $min"
