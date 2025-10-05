function Get-Vector4 {
    <#
    .SYNOPSIS
        Gets a Vector4
    .DESCRIPTION
        Gets any input and arguments as a Vector4
    .LINK
        https://learn.microsoft.com/en-us/dotnet/api/system.numerics.vector4?wt.mc_id=MVP_321542
    .EXAMPLE
        # Create a vector out of four numbers
        Vector4 1 2 3 4
    .EXAMPLE
        (Vector4 1 2 3 4 ) + (Vector4 4 3 2 1 )
    .EXAMPLE
        (Vector4 1 2 3 4 ) - (Vector4 4 3 2 1)
    .EXAMPLE
        # Create a thousand vectors
        $vectors = Vector4 1..4kb
    .EXAMPLE
        # Create a thousand vectors in random order, using the pipeline
        $vectors = 1..4kb | Get-Random -Count 4kb | Vector4
    .EXAMPLE
        # Create vectors from a string
        Vector4 "hi"
    #>
    [Alias('v4','Vector4')]
    param()        
    # Collect all of our input and arguments
    $allIn = @($input) + @(
        foreach ($arg in $args) { 
            $arg            
        }
    )

    # and expand them
    $expandAllIn = @($allIn | vector)
    For ($n = 0; $n -lt $expandAllIn.Length; $n+=4) {
        $argSet = $expandAllIn[$n..($n+3)] -as [float[]]
        switch ($argSet.Length) {
            1 {[Numerics.Vector4]::new($argSet[0]) }
            2 {
                [Numerics.Vector4]::new([Numerics.Vector2]::new($argSet[0],$argSet[1]), 1, 1)
            }
            3 {
                [Numerics.Vector4]::new([Numerics.Vector3]::new($argSet[0],$argSet[1],$argSet[2]), 1)
            }
            4 {
                [Numerics.Vector4]::new($argSet)
            }
        }      
    }
}