Entity    = require "Entity"
Stick     = require "Stick"
GameState = require "GameState"

require "statePlay"
require "statePaused"
require "ayne"
require "game"

function love.load()
	game.load(game)
	myShader = love.graphics.newShader[[
		number time = 5;
		extern number px;
		extern number py;
		vec2 p = vec2(px, py);
		vec3 rgb2hsv(vec3 c) {
		    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
		    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
		    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

		    float d = q.x - min(q.w, q.y);
		    float e = 1.0e-10;
		    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
		}
		vec3 hsv2rgb(vec3 c) {
		    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
		    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
		    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
		}
		vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ) {
			vec4 pixel = Texel(texture, texture_coords );
			number dis = distance(screen_coords, p);

			  vec3 newpixel = rgb2hsv(pixel.rgb);
			  newpixel.g = newpixel.g - (time / 5) * dis / 1000;
			  newpixel.b = newpixel.b - (time / 2) * dis / 1000;
			  newpixel = hsv2rgb(newpixel.rgb);
			  pixel.r = newpixel.r;
			  pixel.g = newpixel.g;
			  pixel.b = newpixel.b;

		  return pixel;
		}
	]]
end

game.shader = false

function love.update()
	game.state.update()
	if game.shader then
		myShader:send("px", game.field.player.x + 16)
		myShader:send("py", 600 - game.field.player.y - 24)
	end
	--myShader:send("time", game.field.time)
end

function love.draw()
	if game.shader then
		love.graphics.setShader(myShader)
	end
	game.state.draw()
	love.graphics.setShader()
	game.state.drawGUI()
	love.graphics.print("", 10, 560)
	love.graphics.print(string.format("Current FPS: %.4f", 1000 / (love.timer.getAverageDelta() * 1000)), 10, 580)
end

function love.keypressed( key, isrepeat )
	game.state.keypressed( key, isrepeat )
end

function love.keyreleased( key, isrepeat )
	game.state.keyreleased( key, isrepeat )
end
