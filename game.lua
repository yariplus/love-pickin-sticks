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
		player = ayne
	},
	state = nil
}