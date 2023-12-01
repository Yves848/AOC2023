#"(one)|(two)|(three)|(four)|(five)|(six)|(seven)|(eight)|(nine)"R

$reg2 = [regex]::new("(one)|(two)|(three)|(four)|(five)|(six)|(seven)|(eight)|(nine)","RightToLeft")
$reg2.RightToLeft($true)
$reg2.Match("zfxbzhczcx9eightwockk")

$reg1 = [regex]::new("(one)|(two)|(three)|(four)|(five)|(six)|(seven)|(eight)|(nine)")
$reg1.RightToLeft($true)
$reg1.Match("zfxbzhczcx9eightwockk")
