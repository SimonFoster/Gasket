require "complex2"

z0 = complex2.Complex.new( 2, 0 )
z1 = complex2.Complex.new( 3, 4 )
z2 = complex2.Complex.new( 5, 6 )
z3 = z1 * z2
z4 = complex2.Complex.new( 0, 1 )


print( z1 + z2, z2 + z1 )
print( z1 + 10, 10 + z1 )
print( z1 * z2, z2 * z1 )
print( z3 / z1, z2 )
print( z3 / z2, z1 )
print( z3 * 2 / 2, z3 )
print( z3 / 2, z3 * 0.5 )
print( z0 ^ 2, z0 * z0 )
print( z1 ^ 2, z1 * z1 )
print( z4 ^ 2, z4 * z4 )