module( ..., package.seeall )

Complex = {};  Complex.__index = Complex

function Complex.new( r, i )
    return setmetatable( { r, i }, Complex )
end

function Complex.polar( r, theta )
	o = { r * math.cos( theta ), r * math.sin( theta ) }
    return setmetatable( o, Complex )
end

function Complex.unpack( op )
    if getmetatable( op ) == Complex then return unpack( op ) end
	if type( op ) == 'number' then return op, 0 end
	error( "Can't unpack", op )
end

function Complex.__add( op1, op2 )
    local a, b = Complex.unpack( op1 )
    local c, d = Complex.unpack( op2 )
    return Complex.new( a + c, b + d )
end

function Complex.__sub( op1, op2 )
    local a, b = Complex.unpack( op1 )
    local c, d = Complex.unpack( op2 )
    return Complex.new( a - c, b - d )
end

function Complex.__mul( op1, op2 )
    local a, b = Complex.unpack( op1 )
    local c, d = Complex.unpack( op2 )
	local real = ( a * c ) - ( b * d )
    local imag = ( a * d ) + ( b * c )
    return Complex.new( real, imag )
end

function Complex.__div( op1, op2 )
    local a, b = Complex.unpack( op1 )
    local c, d = Complex.unpack( op2 )
	local denom = ( c * c ) + ( d * d )
	local real = (( a * c ) + ( b * d )) / denom
	local imag = (( b * c ) - ( a * d )) / denom
    return Complex.new( real, imag )
end

function Complex.__pow( op1, op2 )
	if getmetatable( op1 ) == Complex 
		and type( op2 ) == 'number' then
		local a, b = unpack( op1 )
		local r = ( math.sqrt(( a * a ) + ( b * b ))) ^ op2
		local theta = ( math.atan( b /a )) * op2
		return Complex.polar( r, theta )
	end
	error( "Can't raise ", op1, " to power of ", op2 )
end

function Complex.__tostring( op1 )
	a, b = unpack( op1 )
	return string.format( '(%f+%fj)', a, b )
end
