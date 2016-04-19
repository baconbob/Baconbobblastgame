local Enemy = require 'Enemy'
local Vector_2 = require 'Vector_2'
local enemies = {}

function love.load()
	enemies[1] = Enemy.new("GABENN.png", 40, 40)
	love.window.setMode(0, 0, {fullscreen = false, vsync=true})
	enemies[1]:move_to(Vector_2.new(800, 600))
end

function love.update(dt)
	enemies[1]:update()
end


function love.draw()
	enemies[1]:draw()
end
