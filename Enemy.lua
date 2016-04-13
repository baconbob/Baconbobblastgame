local Enemy = {}

function Enemy.new(file, x, y)
	self = {}
	for k, v in pairs(Enemy) do
		self[k] = Enemy[k];
	end

	self.x = x or 0
	self.y = y or 0
	self.image = love.graphics.newImage(file)
	return self
end

function Enemy:draw()
	love.graphics.draw(self.image, self.x, self.y, 0, 0.1)
end

return Enemy
