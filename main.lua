function love.load()
	love.graphics.setBackgroundColor(45, 192, 255)
	grass = love.graphics.newImage( "graphics/grass.png" )
	audPickup = love.audio.newSource( "audio/pickup.wav" )
	audDinosaur = love.audio.newSource( "audio/SuburbanDinosaur_Moosader.ogg" )
	audDinosaur:setLooping(true)
	audDinosaur:play()

	math.randomseed(os.time())

	ayne = {
		img = love.graphics.newImage( "graphics/ayne.png" ),
		state = "down",
		states = {
			movedown = {
				quads = {
					love.graphics.newQuad(0, 0, 32, 48, 96, 192),
					love.graphics.newQuad(64, 0, 32, 48, 96, 192)
				},
				framedelay = 5,
				move = function()
					ayne.y = ayne.y + ayne.speed
					if ayne.y + 48 > 600 then ayne.y = 600 - 48; ayne.state = "down"; frame = 1 end
				end
			},
			moveup = {
				quads = {
					love.graphics.newQuad(0, 48, 32, 48, 96, 192),
					love.graphics.newQuad(64, 48, 32, 48, 96, 192)
				},
				framedelay = 5,
				move = function()
					ayne.y = ayne.y - ayne.speed
					if ayne.y < 30 then ayne.y = 30; ayne.state = "up"; frame = 1 end
				end
			},
			moveleft = {
				quads = {
					love.graphics.newQuad(0, 96, 32, 48, 96, 192),
					love.graphics.newQuad(32, 96, 32, 48, 96, 192),
					love.graphics.newQuad(64, 96, 32, 48, 96, 192)
				},
				framedelay = 4,
				move = function()
					ayne.x = ayne.x - ayne.speed
					if ayne.x < 0 then ayne.x = 0; ayne.state = "left"; frame = 1 end
				end
			},
			moveright = {
				quads = {
					love.graphics.newQuad(0, 144, 32, 48, 96, 192),
					love.graphics.newQuad(32, 144, 32, 48, 96, 192),
					love.graphics.newQuad(64, 144, 32, 48, 96, 192)
				},
				framedelay = 4,
				move = function()
					ayne.x = ayne.x + ayne.speed
					if ayne.x + 32 > 800 then ayne.x = 800 - 32; ayne.state = "right"; frame = 1 end
				end
			},
			down  = { quads = { love.graphics.newQuad(32, 0, 32, 48, 96, 192) } },
			up    = { quads = { love.graphics.newQuad(32, 48, 32, 48, 96, 192) } },
			left  = { quads = { love.graphics.newQuad(32, 96, 32, 48, 96, 192) } },
			right = { quads = { love.graphics.newQuad(32, 144, 32, 48, 96, 192) } }
		},
		speed = 4,
		x = 380,
		y = 250
	}

	stick = {
		img = love.graphics.newImage( "graphics/stick.png" ),
		x = 0,
		y = 0
	}

	timer = 1
	frame = 1
	tickdelay = 3
	framedelay = 1
	move = "none"
	moveStick()
	collected = 0
end

function love.update()
	timer = timer + 1
	if timer == tickdelay then
		timer = 1
		if ayne.states[ayne.state].framedelay ~= nil then
			framedelay = framedelay + 1
			if framedelay >= ayne.states[ayne.state].framedelay then
				framedelay = 1
				frame = frame + 1
				if frame > table.getn(ayne.states[ayne.state].quads) then frame = 1 end
			end
		end
	end

	if ayne.states[ayne.state] and ayne.states[ayne.state].move then ayne.states[ayne.state].move() end

	testCollision()
end

function love.draw()
	for x=0,24 do
		for y=0,18 do
			love.graphics.draw( grass, 32*x, 32*y )
		end
	end
	love.graphics.setColor(0, 0, 0)
	love.graphics.rectangle( "fill", 0, 0, 800, 30 )
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw( stick.img, stick.x, stick.y )
	love.graphics.draw( ayne.img, ayne.states[ayne.state].quads[frame], ayne.x, ayne.y )
	love.graphics.print(" STICKS COLLECTED: " .. tostring(collected), 10, 8 )
end

function love.keypressed( key, isrepeat )
	if key == "s" then ayne.state = "movedown";  frame = 1 end
	if key == "w" then ayne.state = "moveup";    frame = 1 end
	if key == "a" then ayne.state = "moveleft";  frame = 1 end
	if key == "d" then ayne.state = "moveright"; frame = 1 end
end

function love.keyreleased( key, isrepeat )
	if key == "s" and ayne.state == "movedown"  then ayne.state = "down";  frame = 1; resetMovement() end
	if key == "w" and ayne.state == "moveup"    then ayne.state = "up";    frame = 1; resetMovement() end
	if key == "a" and ayne.state == "moveleft"  then ayne.state = "left";  frame = 1; resetMovement() end
	if key == "d" and ayne.state == "moveright" then ayne.state = "right"; frame = 1; resetMovement() end
end

function resetMovement()
	if love.keyboard.isDown("s") then ayne.state = "movedown";  frame = 1 end
	if love.keyboard.isDown("w") then ayne.state = "moveup";    frame = 1 end
	if love.keyboard.isDown("a") then ayne.state = "moveleft";  frame = 1 end
	if love.keyboard.isDown("d") then ayne.state = "moveright"; frame = 1 end
end

function moveStick()
	stick.x = math.random(32, 800 - 96)
	stick.y = math.random(64, 600 - 30 - 96)
end

function testCollision()
	if math.sqrt(math.pow((ayne.x + 16) - (stick.x + 16), 2) + math.pow((ayne.y + 48) - (stick.y + 24), 2)) < 16 then
		moveStick()
		audPickup:play()
		collected = collected + 1
	end
end
