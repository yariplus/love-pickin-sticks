statePlay = GameState:new({
	update = function ()
		for i=1, #game.field.entities, 1 do
			local entity = game.field.entities[i]
			if math.sqrt(math.pow((game.field.player.x + 16) - (entity.x + 16), 2) + math.pow((game.field.player.y + 48) - (entity.y + 24), 2)) < 16 then
				entity.placeRandomDistanceFrom(entity, game.field.player.x, game.field.player.y, 500)
				audPickup:play()
				collected = collected + 1
			end
	    end
	    game.field.player.update()
	end,
	draw = function ()
		for x=0,24 do
			for y=0,18 do
				love.graphics.draw( grass, 32*x, 32*y )
			end
		end
		love.graphics.setColor(0, 0, 0)
		love.graphics.rectangle( "fill", 0, 0, 800, 30 )
		love.graphics.setColor(255, 255, 255)

		for i=1, #game.field.entities, 1 do
			local entity = game.field.entities[i]
			love.graphics.draw( entity.img, entity.x, entity.y )
	    end

		love.graphics.draw( game.field.player.img, game.field.player.states[game.field.player.state].quads[frame], game.field.player.x, game.field.player.y )
		love.graphics.print(" STICKS COLLECTED: " .. tostring(collected), 10, 8 )
	end,
	keypressed = function ( key, isrepeat )
		if key == "s" then game.field.player.state = "movedown";  frame = 1 end
		if key == "w" then game.field.player.state = "moveup";    frame = 1 end
		if key == "a" then game.field.player.state = "moveleft";  frame = 1 end
		if key == "d" then game.field.player.state = "moveright"; frame = 1 end
	end,
	keyreleased = function ( key, isrepeat )
		if key == "s" and game.field.player.state == "movedown"  then game.field.player.state = "down";  frame = 1; resetMovement() end
		if key == "w" and game.field.player.state == "moveup"    then game.field.player.state = "up";    frame = 1; resetMovement() end
		if key == "a" and game.field.player.state == "moveleft"  then game.field.player.state = "left";  frame = 1; resetMovement() end
		if key == "d" and game.field.player.state == "moveright" then game.field.player.state = "right"; frame = 1; resetMovement() end
	end
})

resetMovement = function ()
	if love.keyboard.isDown("s") then game.field.player.state = "movedown";  frame = 1 end
	if love.keyboard.isDown("w") then game.field.player.state = "moveup";    frame = 1 end
	if love.keyboard.isDown("a") then game.field.player.state = "moveleft";  frame = 1 end
	if love.keyboard.isDown("d") then game.field.player.state = "moveright"; frame = 1 end
end