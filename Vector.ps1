<#
.SYNOPSIS
    Gets vectors
.DESCRIPTION
    Gets a vector in one, two, three, or four dimensions.

    This will convert a variety of types into numbers.

    * `Vector1` will return a list of numbers
    * `Vector2` will return a list of `[Numerics.Vector2]`
    * `Vector3` will return a list of `[Numerics.Vector3]`
    * `Vector4` will return a list of `[Numerics.Vector4]`
.NOTES
    This attempts to convert any type into a number.

    Some types are special:
    
    * Primitive types will be casted to float
    * `[Numerics.Vector2]`,`[Numerics.Vector3]`,`[Numerics.Vector4]` output each component
    * `[string]`s that match a range (`$start..$end`) will output that range
    * `[Version]`s will output each numeric component
    * `[semver]`s will output each numeric component, followed by the bytes of a release type
    * `[Numerics.Matrix3x2]` and `[Numerics.Matrix4x4]` will return the numbers in the matrix
    * `[DateTime]` and `[DateTimeOffset]` will become a series of 12 numbers
        * `year`,`month`,`day`
        * `hour`, `minute`, `second`
        * `millisecond`, `microsecond`, `nanosecond`
        * `offset.hours`, `offset.minutes`, `offset.seconds`
    * `[string]s` will return their bytes in the current `$outputEncoding`
    * Anything unknown will be stringified and the bytes will be returned
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
.LINK
    https://learn.microsoft.com/en-us/dotnet/api/system.numerics.vector2?wt.mc_id=MVP_321542
.LINK
    https://learn.microsoft.com/en-us/dotnet/api/system.numerics.vector3?wt.mc_id=MVP_321542
.LINK
    https://learn.microsoft.com/en-us/dotnet/api/system.numerics.vector4?wt.mc_id=MVP_321542
#>
[Alias('Vector',
    'Get-Vector1','Vector1','V1',
    'Get-Vector2','Vector2','V2',
    'Get-Vector3','Vector3','V3',
    'Get-Vector4','Vector4','V4'
)]
param()
filter toVector { 
    $arg = $_
    # Return primitive types
    if ($arg.GetType -and $arg.GetType().IsPrimitive) {
        # casted to float
        return ($arg -as [float])
    }
    # Return vector components
    if ($arg -is [ValueType]) {
        if ($arg -is [Numerics.Vector2]) {
            return $arg.X,$arg.Y
        }
        elseif ($arg -is [Numerics.Vector3]) {
            return $arg.X,$arg.Y,$arg.Z
        }
        elseif ($arg -is [Numerics.Vector4]) {
            return $arg.X,$arg.Y,$arg.Z, $arg.W
        }
    }
    # Look for inline ranges.
    if ($arg -is [string]) {
        if ($arg -match '^\d..\d') {
            $start, $end = $arg -split '\..', 2
            $startInt = ($start -as [int])
            $endInt   = ($end -as [int])            
            if ($null -ne $startInt -and $null -ne $endInt) {
                # If found, return them expanded.
                return ($startInt..$endInt)
            }
        }
        if ($arg -as [float]) {
            return $arg -as [float]
        }
    }
    

    # If the arg is a version, get each number of the version
    if ($arg -is [version]) {return $arg.Major,$arg.Minor,$arg.Build,$arg.Revision}

    # If we support semver and the arg is semver
    if (('semver' -as [type]) -and $arg -is [semver]) {
        # Return the numeric parts of the semver
        $arg.Major,$arg.Minor,$arg.Patch
        # and turn any string portions to bytes            
        if ($arg.PreReleaseLabel) {
            # make sure to include a leading dash for pre-releases
            $OutputEncoding.GetBytes("-$($arg.PreReleaseLabel)")
        }
        
        if ($arg.BuildLabel) {
            # make sure to include a leading plus for build labels
            $OutputEncoding.GetBytes("+$($arg.BuildLabel)")
        }
        return
    }

    # If the arg is a datetime or datetimeoffset 
    if ($arg -is [DateTime] -or $arg -is [DateTimeOffset]) {
        # make it an offset, and then output 12 values
        $dateArg = $arg -as [DateTimeOffset]
        # * `year` `month` `day`
        $dateArg.Year, $dateArg.Month, $dateArg.Day, 
        # * `hour` `minute` `second`
        $dateArg.Hour, $dateArg.Minute, $dateArg.Second,
        # * `millisecond`, `microsecond`, `nanosecond`
        $dateArg.Millisecond, $dateArg.Microsecond, $dateArg.Nanosecond,
        # * `offset hours`, `offset minutes`, `offset seconds`
        $dateArg.Offset.Hours,$dateArg.Offset.Minutes,$dateArg.Offset.Seconds
        return
    }

    if ($arg -is [Numerics.Matrix3x2]) {
        $arg.M11,$arg.M12,
        $arg.M21,$arg.M22,
        $arg.M31,$arg.M32
        return
    }

    if ($arg -is [Numerics.Matrix4x4]) {
        $arg.M11,$arg.M12,$arg.M13,$arg.M14
        $arg.M21,$arg.M22,$arg.M23,$arg.M24
        $arg.M31,$arg.M32,$arg.M33,$arg.M34
        $arg.M41,$arg.M42,$arg.M43,$arg.M44
        return
    }

    # If the arg is a string
    if ($arg -is [string]) {
        # return its bytes
        return $OutputEncoding.GetBytes($arg)
    }
    # any input we have not caught, stringify and turn to bytes
    return $OutputEncoding.GetBytes("$arg")        
}


# Collect all of our input and arguments
$allIn = @($input) + @(
    foreach ($arg in $args) {
        $arg            
    }
)

$myName = $MyInvocation.InvocationName

$expandAllIn = @($allIn | toVector)

if (-not $expandAllIn.Length) {
    if ($myName -match '2$') {
        return [Numerics.Vector2]
    }
    elseif ($myName -match '3$') {
        return [Numerics.Vector3]
    }
    elseif ($myName -match '4$') {
        return [Numerics.Vector4]
    }
    else {
        return [Numerics.Vector2],[Numerics.Vector3],[Numerics.Vector4]
    }
}
if ($myName -match '[234]$') {
    $dimension = $matches.0 -as [int]
    for ($n = 0; $n -lt $expandAllIn.Length; $n+=$dimension) {
        $nums = $expandAllIn[$n..($n+($dimension-1))] -as [float[]]
        if ($dimension -eq 2) {
            if ($nums.Length -eq 1) {
                [Numerics.Vector2]::new($nums[0])
            } else {
                [Numerics.Vector2]::new($nums)
            }
        } elseif ($dimension -eq 3) {
            if ($nums.Length -eq 1) {
                [Numerics.Vector3]::new($nums[0])
            }
            elseif ($nums.Length -eq 2) {
                [Numerics.Vector3]::new([Numerics.Vector2]::new($nums[0],$nums[1]), 0)
            }
            elseif ($nums.Length -eq 3) {
                [Numerics.Vector3]::new($nums)
            }
        } elseif ($dimension -eq 4) {
            if ($nums.Length -eq 1) { 
                [Numerics.Vector4]::new($nums[0])
            }
            elseif ($nums.Length -eq 2) {
                [Numerics.Vector4]::new([Numerics.Vector2]::new($nums[0],$nums[1]), 0, 0)
            }
            elseif ($nums.Length -eq 3) {
                [Numerics.Vector4]::new([Numerics.Vector3]::new($nums[0],$nums[1],$nums[2]), 0)
            }
            elseif ($nums.Length -eq 4) {
                [Numerics.Vector4]::new($nums)
            }            
        }
    }       
} else {
    return $allIn | toVector
}   
