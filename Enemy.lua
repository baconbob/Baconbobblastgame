local Enemy = {}

function Enemy.new(file, x, y)
	self = {}
	for k, v in pairs(Enemy) do
		self[k] = Enemy[k];
	end

	self.x = x or 0
	self.y = y or 0
	self.image = love.graphics.newImage(file)
	self.w = self.image:getWidth()
	self.h = self.image:getHeight()
	return self
end

function Enemy:draw()
	love.graphics.draw(self.image, self.x, self.y, 0, 0.1)
end

function Enemy:intersects(box)
	a_min = self.x
	a_max = a_min + self.w
	b_min = box.x
	b_max = b_min + box.w

	if b_min > a_min then a_min = b_min end
	if b_max < a_max then a_max = b_max end
	if a_max <= a_min then return false end

	a_min = self.y
	a_max = a_min + self.h
	b_min = box.y
	b_max = b_min + box.h

	if b_min > a_min then a_min = b_min end
	if b_max < a_max then a_max = b_max end
	if a_max <= a_min then return false end

	return true
end

return Enemy
