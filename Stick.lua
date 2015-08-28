local Stick = Entity:new({
	img = love.graphics.newImage( "graphics/stick.png" )
})

function Stick:new()
	o = {}
	setmetatable(o, self)
	self.__index = self

	repeat
		o.x = math.random(32, 800 - 96)
		o.y = math.random(64, 600 - 30 - 96)
		local distance = math.sqrt(math.pow((o.x + 16) - (game.field.player.x + 16), 2) + math.pow((o.y + 48) - (game.field.player.y + 24), 2))
	until distance > 100 and distance < 300

	return o
end

Stick.placeRandomDistanceFrom = function (self, x, y, distance)
	self.x = math.random(32, 800 - 96)
	self.y = math.random(64, 600 - 30 - 96)
	local distance = math.sqrt(math.pow((x + 16) - (self.x + 16), 2) + math.pow((y + 48) - (self.y + 24), 2))
	if distance < 100 or distance > 300 then self.placeRandomDistanceFrom(self, x, y, distance) end
end

return Stick