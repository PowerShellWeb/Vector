#1. Getting Vectors

# Numbers are great!

# When we measure things with one number, it's technically called a scalar.

# When we measure things with more than one number, it's called a vector

# We can do lots of things with vectors.  We can add or substract them, multiply and divide them.

# Vectors are very useful.

# Let's see how we can get a vector:

# Create a 2D vector
[Numerics.Vector2]::new(1,2)
# Create a 3D vector
[Numerics.Vector3]::new(1,2,3)
# Create a 4D vector
[Numerics.Vector4]::new(1,2,3,4)


# The Vector module gives us three vector commands:
Get-Vector2 1 2 
Get-Vector3 1 2 3
Get-Vector4 1 2 3 4

# We can drop the `get`
Vector2 1 2 
Vector3 1 2 3
Vector4 1 2 3 4

# We can use the shorthand `v2`, `v3`, `v4`
v2 1 2
v3 1 2 3
v4 1 2 3 4

# We can create vectors from a number
v2 1
v3 1
v4 1

# Strings can be vectors, too (we just get the bytes)
v2 "hi"
v3 "hi"
v4 "hi"

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

# We can also work with other vectors:

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


# We can also negate a vector:
-(v2 1 2)
-(v3 1 2 3)
-(v4 1 2 3 4)

# We can compare two vectors to see if they are equal
(v2 1 2) -eq (v2 1 2)
(v3 1 2 3) -eq (v3 1 2 3)
(v4 1 2 3 4) -eq (v4 1 2 3 4)

# We can also see if they are not equal
(v2 1 2) -ne (v2 1 2)
(v3 1 2 3) -ne (v3 1 2 3)
(v4 1 2 3 4) -ne (v4 1 2 3 4)

