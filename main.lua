Entity    = require "Entity"
Stick     = require "Stick"
GameState = require "GameState"

require "statePlay"
require "ayne"
require "game"

function love.load()
	game.load(game)
end

function love.update()
	game.state.update()
end

function love.draw()
	game.state.draw()
end

function love.keypressed( key, isrepeat )
	game.state.keypressed( key, isrepeat )
	if key == "escape" then love.event.quit() end
end

function love.keyreleased( key, isrepeat )
	game.state.keyreleased( key, isrepeat )
end
