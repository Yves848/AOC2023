function NextSequence {
    Param(
        [Int64[]]$Sequence
    )
    # We go to one less than count, because we're not 
    # doing the end number
    for ($i = 0; $i -lt ($Sequence.Count-1); $i++) {
        $Sequence[$i+1] - $Sequence[$i]
    }
}

$InputData = Get-Content $PSScriptRoot\..\data.txt
#$InputData = Get-Content $PSScriptRoot\9-1_input_EXAMPLE.txt

$Values = foreach ($Line in $InputData) {
    # Create a list of lists - makes popping another element on the end easier
    $SequenceArray = [System.Collections.Generic.List[System.Collections.Generic.List[int64]]]@()

    # Add the first line to the list so we have something to work with
    $SequenceArray.Add([int64[]]($Line -split "\ "))

    $Count = 0

    while ($Count -lt $SequenceArray.Count) {
    
        # Call our NextSequence function
        $TempSequence = NextSequence -Sequence $SequenceArray[$Count]

        # If we're not all-zeroed yet, then add to the list and keep the
        # while loop condition true
        if([System.Collections.Generic.HashSet[int]]$TempSequence -ne 0) {
            $SequenceArray.Add( $TempSequence )
        }
        
        $Count++
    }

    # Now we go backward through the sequences
    for ($i = ($SequenceArray.count -1); $i -gt 0; $i--) {
        # mathematical addition of the end of the current sequence to 
        # the end of the next line down
        $OnTheEndValue = $SequenceArray[$i][-1] + $SequenceArray[$i-1][-1] 

        # And pop that value on the end of the next one.
        $SequenceArray[$i-1].Add($OnTheEndValue)
    }

    # Pass the end value back to our $Values list
    $SequenceArray[0][-1]
}
$Values
($Values | Measure-Object -Sum).Sum