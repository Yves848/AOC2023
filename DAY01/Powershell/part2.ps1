    $lines = (Get-Content ..\data.txt) -split "\n"
    $reg1 = [regex]::new("\d|(one)|(two)|(three)|(four)|(five)|(six)|(seven)|(eight)|(nine)")
    $reg2 = [regex]::new("\d|(one)|(two)|(three)|(four)|(five)|(six)|(seven)|(eight)|(nine)|\d", "RightToLeft")
    $numbers = @("one", "two", "three", "four", "five", "six", "seven", "eight", "nine")
    ($lines | ForEach-Object {
      $line = $_
      $r1 = $reg1.Match($line)
      $rtn=""
      if ([int]::TryParse($r1.value,[ref]$rtn)) {
        $op1=[int]$r1.Value
      } else {
        $op1= $numbers.IndexOf($r1.Value) +1
      }
      $r2 = $reg2.Match($line)
      $rtn=""
      if ([int]::TryParse($r2.value,[ref]$rtn)) {
        $op2=[int]$r2.Value
      } else {
        $op2= $numbers.IndexOf($r2.Value) +1
      }
      ($op1 * 10) + $op2
    }) | Measure-Object -sum