[string[]]$lines = (Get-Content -Path ..\Example.txt -Raw) -split "\n"

$rows = [System.Collections.ArrayList]::new()
$lines | ForEach-Object {
  $cols = [System.Collections.ArrayList]::new()
  $_.ToCharArray() | ForEach-Object {
    [void]$cols.Add($_)
  }
  [void]$rows.Add($cols)
}


#expand galaxies
$gr = @()
$gc = @()

for ($r = 0; $r -lt $rows.Count; $r++) {
  $rc = ""
  for ($c = 0; $c -lt $cols.Count; $c++) {
    if ($rows[$r][$c] -eq '#') {
      $rc = "#"
    }  
  }
  if ($rc -ne "#") {
    $gr += $r
  }
}

for ($c = 0; $c -lt $cols.Count; $c++) {
  $cr = ""
  for ($r = 0; $r -lt $rows.Count; $r++) {
    if ($rows[$r][$c] -eq '#') {
      $cr = "#"
    }
  }
  if ($cr -ne "#") {
    $gc += $c
  }
}

# Write-Host "rows"
# $gr
# Write-Host "cols"
# $gc

# for ($r = 0; $r -lt $rows.Count; $r++) {
#   Write-Host
#   for ($c = 0; $c -lt $cols.Count; $c++) {
#     Write-Host $rows[$r][$c] -NoNewline
#   }
# }


# Ajouter les lignes
$i = ($gr.Count -1)
while ($i -ge 0) {
  $cols = [System.Collections.ArrayList]::new()
  "".PadLeft(($rows[0].count -1),'.').ToCharArray() | ForEach-Object {
    [void]$cols.Add($_)
  }
  $ii = $gr[$i]
  $rows.Insert($ii,$cols);
  $i = $i - 1
}


# Ajouter les colonnes
$i = ($gc.Count -1)
while ($i -ge 0) {
  $ii = $gc[$i]
  for ($r = 0; $r -lt $rows.Count; $r++) {
    $rows[$r].Insert($ii,".")
  }
  $i = $i - 1
}



for ($r = 0; $r -lt $rows.Count; $r++) {
  Write-Host
  for ($c = 0; $c -lt $cols.Count; $c++) {
    Write-Host $rows[$r][$c] -NoNewline
  }
}

