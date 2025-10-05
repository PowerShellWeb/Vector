function Get-Vector
{
    <#
    .SYNOPSIS
        Gets a one dimensional vector
    .DESCRIPTION
        Gets a one dimensional vector (or, more simply, a list of numbers)

        This will convert a variety of types into numbers.
    .NOTES
        This attempts to convert any type into a number.

        Some types are special:
        
        * Primitive types will be casted to float
        * `[Numerics.Vector2]`,`[Numerics.Vector3]`,`[Numerics.Vector4]` output each component
        * `[string]`s that match a range (`$start..$end`) will output that range
        * `[Version]`s will output each numeric component
        * `[semver]`s will output each numeric component, followed by the bytes of a release type
        * `[DateTime]` and `[DateTimeOffset]` will become a series of 12 numbers
          * `year`,`month`,`day`
          * `hour`, `minute`, `second`
          * `millisecond`, `microsecond`, `nanosecond`
          * `offset.hours`, `offset.minutes`, `offset.seconds`
        * `[string]s` will return their bytes in the current `$outputEncoding`
        * Anything unknown will be stringified and the bytes will be returned
    #>
    [Alias('Vector','Vector1','V1')]
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

    return $allIn | toVector
}