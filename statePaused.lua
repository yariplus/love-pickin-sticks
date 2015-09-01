statePaused = GameState:new({
	update = function ()
	end,
	draw = function ()
		game.drawField()
	end,
	drawGUI = function()
		love.graphics.setColor(0, 0, 0)
		love.graphics.rectangle( "fill", 0, 0, 800, 30 )
		love.graphics.setColor(255, 255, 255)
		love.graphics.print(" STICKS COLLECTED: " .. tostring(collected), 10, 8 )
		love.graphics.setColor(0, 0, 0)
		love.graphics.rectangle( "fill", 200, 200, 400, 100 )
		love.graphics.setColor(255, 255, 255)
		love.graphics.print(" Paused ", 350, 240 )
	end,
	keypressed = function ( key, isrepeat )
		if key == "escape" and not isrepeat then
			game.state = statePlay
			if love.keyboard.isDown("s") then game.field.player.state = "movedown";  frame = 1 else if game.field.player.state == "movedown"  then game.field.player.state = "down";  frame = 1 end end
			if love.keyboard.isDown("w") then game.field.player.state = "moveup";    frame = 1 else if game.field.player.state == "moveup"    then game.field.player.state = "up";    frame = 1 end end
			if love.keyboard.isDown("a") then game.field.player.state = "moveleft";  frame = 1 else if game.field.player.state == "moveleft"  then game.field.player.state = "left";  frame = 1 end end
			if love.keyboard.isDown("d") then game.field.player.state = "moveright"; frame = 1 else if game.field.player.state == "moveright" then game.field.player.state = "right"; frame = 1 end end
		end
	end,
	keyreleased = function ( key )
	end
})