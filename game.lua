game = {
	load = function(self)
		math.randomseed(os.time())
		love.graphics.setBackgroundColor(45, 192, 255)
		grass = love.graphics.newImage( "graphics/grass.png" )
		audPickup = love.audio.newSource( "audio/pickup.wav" )
		audDinosaur = love.audio.newSource( "audio/SuburbanDinosaur_Moosader.ogg" )
		audDinosaur:setLooping(true)

		--love.window.setFullscreen(true);

		self.state = statePlay
		table.insert(self.field.entities, Stick:new())
		table.insert(self.field.entities, Stick:new())
		table.insert(self.field.entities, Stick:new())

		audDinosaur:play()

		timer = 1
		frame = 1
		tickdelay = 3
		framedelay = 1
		move = "none"
		collected = 0
	end,
	field = {
		entities = { },
		player = ayne,
		time = 0
	},
	state = nil,
	drawField = function()
		for x=0,24 do
			for y=0,18 do
				love.graphics.draw( grass, 32*x, 32*y )
			end
		end

		for i=1, #game.field.entities, 1 do
			local entity = game.field.entities[i]
			love.graphics.draw( entity.img, entity.x, entity.y )
	    end

		love.graphics.draw( game.field.player.img, game.field.player.states[game.field.player.state].quads[frame], game.field.player.x, game.field.player.y )
	end
}