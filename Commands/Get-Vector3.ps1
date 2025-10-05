function Get-Vector3 {
    <#
    .SYNOPSIS
        Gets a Vector3
    .DESCRIPTION
        Gets any input and arguments as a Vector3
    .LINK
        https://learn.microsoft.com/en-us/dotnet/api/system.numerics.vector3?wt.mc_id=MVP_321542
    .EXAMPLE
        # Create a vector out of two numbers
        Vector3 1 2 3
    .EXAMPLE
        (Vector3 1 2 3 ) + (Vector3 3 2 1)
    .EXAMPLE
        (Vector3 1 2 3 ) - (Vector3 3 2 1)
    .EXAMPLE
        # Create a thousand vectors
        $vectors = Vector3 1..3kb
    .EXAMPLE
        # Create a thousand vectors in random order, using the pipeline
        $vectors = 1..3kb | Get-Random -Count 3kb | Vector3
    .EXAMPLE
        # Create a vector from a string
        $vector = Vector3 "hi"
    .NOTES
        This script is self contained so that it can be easily dropped into any project
    #>
    [Alias('Vector3','V3')]
    param()        

    
    # Collect all of our input and arguments
    $allIn = @($input) + @(
        foreach ($arg in $args) { 
            $arg            
        }
    )

    # and expand them
    $expandAllIn = @($allIn | Vector)

    # Go over our arguments three at a time
    For ($n = 0; $n -lt $expandAllIn.Length; $n+=3) {
        $argSet = $expandAllIn[$n..($n+2)] -as [float[]]
        switch ($argSet.Length) {
            1 {
                [Numerics.Vector3]::new($argSet[0])
            }
            2 {
                [Numerics.Vector3]::new([Numerics.Vector2]::new($argSet[0],$argSet[1]), 1)
            }
            3 {
                [Numerics.Vector3]::new($argSet)
            }
        }
    }
}
