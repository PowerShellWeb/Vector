function Get-Vector2 {
    <#
    .SYNOPSIS
        Gets a Vector2
    .DESCRIPTION
        Gets any input and arguments as a Vector2
    .LINK
        https://learn.microsoft.com/en-us/dotnet/api/system.numerics.vector2?wt.mc_id=MVP_321542
    .EXAMPLE
        # Create a vector out of two numbers
        Vector2 1 2
    .EXAMPLE
        (Vector2 1 2) + (Vector2 2 1)
    .EXAMPLE
        (Vector2 1 2) - (Vector2 2 1)
    .EXAMPLE
        # Create a thousand vectors
        $vectors = Vector2 1..2kb
    .EXAMPLE
        # Create a thousand vectors in random order, using the pipeline
        $vectors = 1..2kb | Get-Random -Count 2kb | Vector2
    .EXAMPLE
        # Create a vector from a string
        $vector = Vector2 "hi"
    #>
    [Alias('V2','Vector2')]
    param()
    # Collect all of our input and arguments
    $allIn = @($input) + @(
        foreach ($arg in $args) {
            $arg            
        }
    )

    # and expand them
    $expandAllIn = @($allIn | Vector)    

    For ($n = 0; $n -lt $expandAllIn.Length; $n+=2) {
        $argSet = $expandAllIn[$n..($n+1)] -as [float[]]
        if ($argSet.Length -eq 1) {
            [Numerics.Vector2]::new($argSet[0])
        } else {
            [Numerics.Vector2]::new($argSet)
        }        
    }    
}
