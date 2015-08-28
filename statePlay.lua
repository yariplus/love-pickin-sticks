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
		game.drawField()
	end,
	keypressed = function ( key, isrepeat )
		if key == "s" and not isrepeat then game.field.player.state = "movedown";  frame = 1 end
		if key == "w" and not isrepeat then game.field.player.state = "moveup";    frame = 1 end
		if key == "a" and not isrepeat then game.field.player.state = "moveleft";  frame = 1 end
		if key == "d" and not isrepeat then game.field.player.state = "moveright"; frame = 1 end
		if key == "escape" and not isrepeat then game.state = statePaused end
	end,
	keyreleased = function ( key )
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