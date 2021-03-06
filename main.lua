require "complex2"
require "strict"

main = {}

function love.load()
	local x, y, r = 400, 200, 100 
	local sin = r * math.sin( math.pi/6 )
	local cos = r * math.cos( math.pi/6 )
    main.c1 = { x, 			y, 			r }
    main.c2 = { x-2*sin, 	y+2*cos, 	r }
    main.c3 = { x+2*sin, 	y+2*cos, 	r }
end

function love.update( dt )
    main.circle = 1
end

function love.draw()

    local function circle( c )
        local x, y, r = unpack( c )
        print( main.circle, x, y, r )
		love.graphics.circle( 'line', x, y, math.abs(r) )
		love.graphics.print( 'C' .. main.circle, x, y )
		main.circle = main.circle + 1
    end
    
    local function descartes( c1, c2, c3, order )

		local x1, y1, r1 = unpack( c1 )
		local x2, y2, r2 = unpack( c2 )
		local x3, y3, r3 = unpack( c3 )
		
		local k1, k2, k3 = 1/r1, 1/r2, 1/r3
		local z1 = complex2.Complex.new( x1, y1 )
		local z2 = complex2.Complex.new( x2, y2 )
		local z3 = complex2.Complex.new( x3, y3 )
		
		local t1 = k1 + k2 + k3
		local t2 = 2 * math.sqrt( k1 * k2 + k2 * k3 + k3 * k1 )
		local t3 = z1 * k1 + z2 * k2 + z3 * k3
		local t4 = 2 * ( k1 * k2 * z1 * z2 + k2 * k3 * z2 * z3 + k3 * k1 * z3 * z1 )^0.5
	
		local k, r, z, x, y
		
		k = t1 + t2
		r = 1 / k     
		z = ( t3 + t4 ) / k
		x, y = unpack( z )
		local c4 = { x, y, r }
		circle( c4 )

		k = t1 - t2
		r = 1 / k 
		z = ( t3 - t4 ) / k
		x, y = unpack( z )
		local c5 = { x, y, r }
		circle( c5 )

		if order > 0 then
			local order = order - 1
			descartes( c1, c2, c4, order )
			descartes( c1, c2, c5, order )
			descartes( c2, c3, c4, order )
			descartes( c2, c3, c5, order )
			descartes( c3, c1, c4, order )
			descartes( c3, c1, c5, order )
		end
	end

	circle( main.c1 )
	circle( main.c2 )
	circle( main.c3 )
	
	descartes( main.c1, main.c2, main.c3, 1 )
    
end



