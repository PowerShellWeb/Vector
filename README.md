# Vector
[![Vector](https://img.shields.io/powershellgallery/dt/Vector)](https://www.powershellgallery.com/packages/Vector/)
## Vectors in PowerShell
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

## Installing and Importing

You can install Vector from the [PowerShell gallery](https://powershellgallery.com/)

~~~PowerShell
Install-Module Vector -Scope CurrentUser -Force
~~~

Once installed, you can import the module with:

~~~PowerShell
Import-Module Vector -PassThru
~~~


You can also clone the repo and import the module locally:

~~~PowerShell
git clone https://github.com/PowerShellWeb/Vector
cd ./Vector
Import-Module ./ -PassThru
~~~

## Functions
Vector has 1 function
### Get-Vector
#### Gets vectors

Gets a vector in one, two, three, or four dimensions.

This will convert a variety of types into numbers.

`Vector1` will return a list of numbers
`Vector2` will return a list of `[Numerics.Vector2]`
`Vector3` will return a list of `[Numerics.Vector3]`
`Vector4` will return a list of `[Numerics.Vector4]`

<details>
<summary>Notes</summary>

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

</details>
<details open>
<summary>Examples</summary>

#### Example 1

Create a vector out of two numbers
~~~PowerShell
Vector2 1 2
~~~


#### Example 2

~~~PowerShell
(Vector2 1 2) + (Vector2 2 1)
~~~


#### Example 3

~~~PowerShell
(Vector2 1 2) - (Vector2 2 1)
~~~


#### Example 4

Create a thousand vectors
~~~PowerShell
$vectors = Vector2 1..2kb
~~~


#### Example 5

Create a thousand vectors in random order, using the pipeline
~~~PowerShell
$vectors = 1..2kb | Get-Random -Count 2kb | Vector2
~~~


#### Example 6

Create a vector from a string
~~~PowerShell
$vector = Vector2 "hi"
~~~


#### Example 7

Create a vector out of two numbers
~~~PowerShell
Vector3 1 2 3
~~~


#### Example 8

~~~PowerShell
(Vector3 1 2 3 ) + (Vector3 3 2 1)
~~~


#### Example 9

~~~PowerShell
(Vector3 1 2 3 ) - (Vector3 3 2 1)
~~~


#### Example 10

Create a thousand vectors
~~~PowerShell
$vectors = Vector3 1..3kb
~~~


#### Example 11

Create a thousand vectors in random order, using the pipeline
~~~PowerShell
$vectors = 1..3kb | Get-Random -Count 3kb | Vector3
~~~


#### Example 12

Create a vector from a string
~~~PowerShell
$vector = Vector3 "hi"
~~~


#### Example 13

Create a vector out of four numbers
~~~PowerShell
Vector4 1 2 3 4
~~~


#### Example 14

~~~PowerShell
(Vector4 1 2 3 4 ) + (Vector4 4 3 2 1 )
~~~


#### Example 15

~~~PowerShell
(Vector4 1 2 3 4 ) - (Vector4 4 3 2 1)
~~~


#### Example 16

Create a thousand vectors
~~~PowerShell
$vectors = Vector4 1..4kb
~~~


#### Example 17

Create a thousand vectors in random order, using the pipeline
~~~PowerShell
$vectors = 1..4kb | Get-Random -Count 4kb | Vector4
~~~


#### Example 18

Create vectors from a string
~~~PowerShell
Vector4 "hi"
~~~

</details>
<details open>
<summary>Links</summary>

* [system.numerics.vector2 (Learn DotNet)](https://learn.microsoft.com/en-us/dotnet/api/system.numerics.vector2?wt.mc_id=MVP_321542)
* [system.numerics.vector3 (Learn DotNet)](https://learn.microsoft.com/en-us/dotnet/api/system.numerics.vector3?wt.mc_id=MVP_321542)
* [system.numerics.vector4 (Learn DotNet)](https://learn.microsoft.com/en-us/dotnet/api/system.numerics.vector4?wt.mc_id=MVP_321542)

</details>
