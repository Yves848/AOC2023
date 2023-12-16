[string[]]$lines = (Get-Content -Path ..\Data.txt -Raw) -split "\n"

[string]$cards= "AKQT98765432J";
[string]$let  = "ABCDEFGHIJKLM"

$hands = [ordered]@{}

$pair = [regex]::new('(.)\1')
$ThreeOfAKind = [regex]::new('(.)\1\1')
$FourOfAKind = [regex]::new('(.)\1\1\1')
$FiveOfAKind = [regex]::new('(.)\1\1\1\1')

$results = @()


$lines | ForEach-Object {
  $line = $_.Split(' ')
  $card = ($line[0].ToCharArray() | ForEach-Object { $let[$cards.IndexOf($_)]}) -join ''
  $hands[$card] = @{
    #"cards"= $line[0]
    "bet"= $line[1]
    "sorted" = ($card.ToCharArray() | Sort-Object) -join ''
    "original" = $line[0]
    "poker" = 0
    "rank" = 0
  }
}

function determineHand(
  $hand
) {
 [string]$sorted = $hand
  if ($FiveOfAKind.isMatch($sorted)) {
    return 7
  }
  if ($FourOfAKind.IsMatch($sorted)) {
    return 6
  }
  $m = $ThreeOfAKind.Match($sorted)
  if ($m.Success) {
    $sorted = $sorted.Remove($m.index,$m.Length)
    $m = $pair.Match($sorted) 
    if ($m.success) {
      return 5
    }
    return 4
  }
  $m = $pair.Matches($sorted) 
  if ($m.success) {
    if ($m.Count -eq 2) {
      return 3
    }
    return 2
  }
  return 1
}

$i = 0
while ($i -lt $hands.Count) {
  $hand = $hands[$i]["sorted"]
  $original = $hands[$i]["original"]
  if ($hand.contains('M')) {
    $score = 0
    $let.ToCharArray() | ForEach-Object {
      if ($_ -ne 'M') {
        $hand2 = (($hand -replace "M",$_).ToCharArray() | Sort-Object) -join ''
        $n = determineHand -hand $hand2
        if ($n -gt $score) {
          $score = $n
        }
      }
    }

    $hands[$i]["poker"] = $score
   
    
  }
  else {
    $hands[$i]["poker"] = determineHand -hand $hand
  }
  
  $i = $i + 1
}


7..1 | ForEach-Object {
  $temp = @()
  $i = $_
  $hands.GetEnumerator() | Where-Object {$_.Value["poker"] -eq $i} | ForEach-Object {
    $temp += $_.Name
  }
  $temp = $temp | sort
  $temp | ForEach-Object {
    $results += ($_.ToCharArray() | ForEach-Object { $cards[$let.IndexOf($_)]}) -join ''
  }
}

[int]$i = $hands.Count
$amount = 0
$results | ForEach-Object {
  $key = ($_.ToCharArray() | ForEach-Object { $let[$cards.IndexOf($_)]}) -join ''
  $bet = [int64]$hands[$key]["bet"]
  $amount = $amount + ($bet * $i)
  $i = $i - 1
}

$amount