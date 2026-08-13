#
# Module manifest for module 'Vector'
#
# Generated on: 10/4/2025
#

@{

# Script module or binary module file associated with this manifest.
RootModule = 'Vector.psm1'

# Version number of this module.
ModuleVersion = '0.1.1'

# Supported PSEditions
# CompatiblePSEditions = @()

# ID used to uniquely identify this module
GUID = '2110de70-cbfb-4e01-b273-e7db122a4a53'

# Author of this module
Author = 'James Brundage'

# Company or vendor of this module
CompanyName = 'Start-Automating'

# Copyright statement for this module
Copyright = '2025-2026 Start-Automating'

# Description of the functionality provided by this module
Description = 'Vectors in PowerShell'

# Minimum version of the PowerShell engine required by this module
# PowerShellVersion = ''

# Name of the PowerShell host required by this module
# PowerShellHostName = ''

# Minimum version of the PowerShell host required by this module
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# DotNetFrameworkVersion = ''

# Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
# ClrVersion = ''

# Processor architecture (None, X86, Amd64) required by this module
# ProcessorArchitecture = ''

# Modules that must be imported into the global environment prior to importing this module
# RequiredModules = @()

# Assemblies that must be loaded prior to importing this module
# RequiredAssemblies = @()

# Script files (.ps1) that are run in the caller's environment prior to importing this module.
# ScriptsToProcess = @()

# Type files (.ps1xml) to be loaded when importing this module
# TypesToProcess = @()

# Format files (.ps1xml) to be loaded when importing this module
# FormatsToProcess = @()

# Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
# NestedModules = @()

# Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
FunctionsToExport = 'Get-Vector'

# Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
CmdletsToExport = @()

# Variables to export from this module
VariablesToExport = @('Vector')

# Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
AliasesToExport = 'Get-Vector2', 'Get-Vector3', 'Get-Vector4', 'V1', 'V2', 'V3', 'V4', 'Vector', 'Vector1', 'Vector2', 'Vector3', 'Vector4'

# DSC resources to export from this module
# DscResourcesToExport = @()

# List of all modules packaged with this module
# ModuleList = @()

# List of all files packaged with this module
# FileList = @()

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags       = 'PowerShell', 'Vector', 'Math'
        # A URL to the main website for this project.
        ProjectURI = 'https://github.com/PoshWeb/Vector'
        # A URL to the license for this module.
        LicenseURI = 'https://github.com/PoshWeb/Vector/blob/main/LICENSE'

        # A URL to an icon representing this module.
        # IconUri = ''

        # ReleaseNotes of this module
        ReleaseNotes = @'
## Vector 0.1.1

* `Vector` is an eponoym (#15)
  * This module exposes one command with many aliases
* `Vector` converts `Matrix3x2` and `Matrix4x4` into vectors (#16) 
* Vectors return their type when provided no input (#14)
* Added `README.md.ps1` (#17)

---

Additional History in [CHANGELOG](https://github.com/PoshWeb/Vector/blob/main/CHANGELOG.md)

'@

        PSIntro = @'
# Vector

Numbers are great!

When we measure things with one number, it's technically called a scalar.

When we measure things with more than one number, it's called a [vector](https://en.wikipedia.org/wiki/Vector_%28mathematics_and_physics%29)

We can do lots of things with vectors.  We can add or substract them, multiply and divide them.

Vectors are very useful.

This module helps you use Vectors in PowerShell

## Vectors in PowerShell

Vectors are actually built into PowerShell.

Because PowerShell is built atop of the .NET Framework,
and the .NET Framework has had vector support for over a decade, 
PowerShell has had vectors for over a decade.

~~~PowerShell
# Create a 2D vector
[Numerics.Vector2]::new(1,2)
# Create a 3D vector
[Numerics.Vector3]::new(1,2,3)
# Create a 4D vector
[Numerics.Vector4]::new(1,2,3,4)
~~~

This module exists to make vectors a bit more useful by providing commands to construct them.

### Getting Vectors

There are a few commands in this module:

* `Get-Vector`
* `Get-Vector2`
* `Get-Vector3`
* `Get-Vector4`

Each command constructs a vector of the corresponding dimension.

A Vector with one dimension is just a list.

We can also drop the `Get` and just refer to them by vector number

~~~PowerShell
Vector2 1 2 
Vector3 1 2 3
Vector4 1 2 3 4
~~~

We can be even shorter, and use `V2`, `V3`, and `V4`

~~~PowerShell
v2 1 2
v3 1 2 3
v4 1 2 3 4
~~~

We can turn anything into a series of vectors.

~~~PowerShell
v2 1
v3 1
v4 1
~~~

Strings can become vectors, too! (after all, each byte is already a number)

~~~PowerShell
v2 "hi"
v3 "hi"
v4 "hi"
~~~

### Vector Operators

.NET vectors are _very_ powerful, and overload many operators.

For example, we can add, subtract, multiply, or divide by a scalar.

~~~PowerShell
# Let's start with addition.  
# We can add a scalar to a vector.
(v2 1 2) + 1 
(v3 1 2 3) + 1 
(v4 1 2 3 4) + 1

# Let's try substraction:
(v2 1 2) - 1 
(v3 1 2 3) - 1 
(v4 1 2 3 4) - 1

# How about multiplication?
(v2 1 2) * 2
(v3 1 2 3) * 2
(v4 1 2 3 4) * 2

# What about division?
(v2 1 2) / 2
(v3 1 2 3) / 2
(v4 1 2 3 4) / 2
~~~

We can also work with other vectors:

~~~PowerShell
# Adding vectors:
(v2 1 2) + (v2 1 2)
(v3 1 2 3) + (v3 1 2 3)
(v4 1 2 3 4) + (v4 1 2 3 4)

# Subtracting vectors:
(v2 1 2) - (v2 1 2)
(v3 1 2 3) - (v3 1 2 3)
(v4 1 2 3 4) - (v4 1 2 3 4)

# Multiplying vectors:
(v2 1 2) * (v2 1 2)
(v3 1 2 3) * (v3 1 2 3)
(v4 1 2 3 4) * (v4 1 2 3 4)

# Dividing vectors:
(v2 1 2) / (v2 1 2)
(v3 1 2 3) / (v3 1 2 3)
(v4 1 2 3 4) / (v4 1 2 3 4)
~~~

### Vector Methods

Vectors have a large number of methods to work with.

Let's start simple, by calculating the length of a given vector.

~~~PowerShell
(v2 1 1).Length()
(v3 1 1 1).Length()
(v4 1 1 1 1).Length()
~~~

Many of the most useful things we can do with a vector are exposed as a static methods:

~~~PowerShell
(v2 1 1) | Get-Member -Static
(v3 1 1 1) | Get-Member -Static
(v4 1 1 1 1) | Get-Member -Static
~~~


We can access static method with `::`

For a small example, let's find the distance between vectors:

~~~PowerShell
$vector1 = v2 1 2
$vector2 = v2 2 1
$vector1::Distance($vector1, $vector2)
~~~

For another simple example, let's find a few point between two points, using
[Linear Interpolation `lerp`](https://learn.microsoft.com/en-us/dotnet/api/system.numerics.vector2.lerp?wt.mc_id=MVP_321542)

~~~PowerShell
$vector1 = v2 1 5
$vector2 = v2 1 -5
$vector1::Lerp($vector1, $vector2, 0.25)
$vector1::Lerp($vector1, $vector2, 0.5)
$vector1::Lerp($vector1, $vector2, 0.75)
~~~

All of this would not be possible without the great work of the .NET team to build such incredibly useful data structures.

Hopefully this module helps us all work with vectors!
'@

        # Prerelease string of this module
        # Prerelease = ''

        # Flag to indicate whether the module requires explicit user acceptance for install/update/save
        # RequireLicenseAcceptance = $false

        # External dependent modules of this module
        # ExternalModuleDependencies = @()

    } # End of PSData hashtable

} # End of PrivateData hashtable

# HelpInfo URI of this module
# HelpInfoURI = ''

# Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

