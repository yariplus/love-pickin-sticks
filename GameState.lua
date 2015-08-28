local GameState = {
	update      = function() end,
	draw        = function() end,
	keypressed  = function() end,
	keyreleased = function() end
}

function GameState:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

return GameState