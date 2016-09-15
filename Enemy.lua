local Enemy = {}
local Vector_2 = require 'Vector_2'

function Enemy.new(file, x, y)
	self = {}
	for k, v in pairs(Enemy) do
		self[k] = Enemy[k];
	end

	self.x = x or 0
	self.y = y or 0
	self.image = file
	self.w = self.image:getWidth()
	self.h = self.image:getHeight()
	self.speed = 0.90
	return self
end

function Enemy:update()
	if self.moving then
		direction = Vector_2.new(self.goal.x - self.start.x, self.goal.y - self.start.y):normalize()
		move_vec = Vector_2.new(direction.x * self.speed, direction.y * self.speed)

		if Vector_2.new(self.x + move_vec.x - self.start.x, self.y + move_vec.y - self.start.y):length() > Vector_2.new(self.goal.x - self.start.x, self.goal.y - self.start.y):length() then
			self.x = self.goal.x
			self.y = self.goal.y
			self.moving = false
		else
			self.x = self.x + move_vec.x
			self.y = self.y + move_vec.y
		end
	end
end

function Enemy:draw()
	love.graphics.draw(self.image, self.x, self.y, 0, 1.3)
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
end


function Enemy:move_to(goal)
	self.start = Vector_2.new(self.x, self.y)
	self.goal = goal
	self.moving = true
end

return Enemy

--[[a_min = self.x
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

return true]]
