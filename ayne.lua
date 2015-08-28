ayne = Entity:new({
	img = love.graphics.newImage( "graphics/ayne.png" ),
	state = "down",
	states = {
		movedown = {
			quads = {
				love.graphics.newQuad(0, 0, 32, 48, 96, 192),
				love.graphics.newQuad(64, 0, 32, 48, 96, 192)
			},
			framedelay = 5,
			move = function(self)
				self.y = self.y + self.speed
				if self.y + 48 > 600 then self.y = 600 - 48; self.state = "down"; frame = 1 end
			end
		},
		moveup = {
			quads = {
				love.graphics.newQuad(0, 48, 32, 48, 96, 192),
				love.graphics.newQuad(64, 48, 32, 48, 96, 192)
			},
			framedelay = 5,
			move = function(self)
				self.y = self.y - self.speed
				if self.y < 30 then self.y = 30; self.state = "up"; frame = 1 end
			end
		},
		moveleft = {
			quads = {
				love.graphics.newQuad(0, 96, 32, 48, 96, 192),
				love.graphics.newQuad(32, 96, 32, 48, 96, 192),
				love.graphics.newQuad(64, 96, 32, 48, 96, 192)
			},
			framedelay = 4,
			move = function(self)
				self.x = self.x - self.speed
				if self.x < 0 then self.x = 0; self.state = "left"; frame = 1 end
			end
		},
		moveright = {
			quads = {
				love.graphics.newQuad(0, 144, 32, 48, 96, 192),
				love.graphics.newQuad(32, 144, 32, 48, 96, 192),
				love.graphics.newQuad(64, 144, 32, 48, 96, 192)
			},
			framedelay = 4,
			move = function(self)
				self.x = self.x + self.speed
				if self.x + 32 > 800 then self.x = 800 - 32; self.state = "right"; frame = 1 end
			end
		},
		down  = { quads = { love.graphics.newQuad(32, 0, 32, 48, 96, 192) } },
		up    = { quads = { love.graphics.newQuad(32, 48, 32, 48, 96, 192) } },
		left  = { quads = { love.graphics.newQuad(32, 96, 32, 48, 96, 192) } },
		right = { quads = { love.graphics.newQuad(32, 144, 32, 48, 96, 192) } }
	},
	speed = 4,
	x = 380,
	y = 250,
	update = function ()
		timer = timer + 1
		if timer == tickdelay then
			timer = 1
			if game.field.player.states[game.field.player.state].framedelay ~= nil then
				framedelay = framedelay + 1
				if framedelay >= game.field.player.states[game.field.player.state].framedelay then
					framedelay = 1
					frame = frame + 1
					if frame > table.getn(game.field.player.states[game.field.player.state].quads) then frame = 1 end
				end
			end
		end

		if game.field.player.states[game.field.player.state] and game.field.player.states[game.field.player.state].move then game.field.player.states[game.field.player.state].move(game.field.player) end
	end
})