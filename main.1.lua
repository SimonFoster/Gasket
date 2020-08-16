require "complex"

function love.load()
    radius = 0
    c1 = { 400, 300, 200 }
end

function love.update( dt )
    radius = ( radius + ( 30 * dt )) % 200
    c2 = { 400, 100+radius, radius }
    c3 = { 400, 300+radius, 200-radius }
end

function love.draw()

    local function descartes( c1, c2, c3 )

    	-- http://en.wikipedia.org/wiki/Descartes'_theorem
	
    	local x1, y1, r1 = unpack(c1)
    	local x2, y2, r2 = unpack(c2)
    	local x3, y3, r3 = unpack(c3)
	
    	local k1, k2, k3 = 1/r1, 1/r2, 1/r3
    	local z1, z2, z3 = x1 + y1 * math.i, x2 + y2 * math.i, x3 + y3 * math.i
    	
    	local t1 = k1 + k2 + k3
    	if type(t1) ~= 'number' then
    	    io.write( '.' )
    	    t1 = t1:real()
    	end
    	local t2 = 2 * math.sqrt( k1 * k2 + k2 * k3 + k3 * k1 )
    	if type(t2) ~= 'number' then
    	    io.write( '.' )
    	    t2 = t2:real()
    	end
    	local t3 = z1 * k1 + z2 * k2 + z3 * k3
    	local t4 = 2 * math.sqrt( k1 * k2 * z1 * z2 + k2 * k3 * z2 * z3 + k3 * k1 * z3 * z1 )
	
    	return t1, t2, t3, t4
    end

    local c4 = { c1[1], c1[2], -c1[3] } 
    local t1, t2, t3, t4 = descartes( c2, c3, c4 )
    
    love.graphics.circle( 'line', unpack(c1) )
    love.graphics.circle( 'line', unpack(c2) )
    love.graphics.circle( 'line', unpack(c3) )
    
    local k, r, z, x, y
    
    k = t1 + t2
    r = 1 / k 
    
    z = ( t3 + t4 ) / k
    x, y = z:real(), z:imag()
    love.graphics.circle( 'line', x, y, r )

    k = t1 - t2
    r = 1 / k 
    z = ( t3 - t4 ) / k
    x, y = z:real(), z:imag() 
    love.graphics.circle( 'line', x, y, r )
end



