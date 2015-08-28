local Entity = {
	x    = 0,
	y    = 0,
	xoff = 16,
	yoff = 16,
	w    = 32,
	h    = 32,
	img  = love.graphics.newImage( "graphics/noise.png" ),
	update = function() end;
}

function Entity:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return Entity