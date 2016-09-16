local Display_Object = {}

function Display_Object.new(image, x, y, width, height)
	assert(image)
	local self = {}
	for k, v in pairs(Display_Object) do
		self[k] = Display_Object[k]
	end

	self.x = x or 0
	self.y = y or 0
	self.image = image
	self.sw = self.image:getWidth()
	self.sh = self.image:getHeight()
	self.width = width or self.sw
	self.height = height or self.sh
	return self
end

function Display_Object:draw()
	local quad = love.graphics.newQuad(
			0, 
			0, 
			self.sw, 
			self.sh, 
			self.width, 
			self.height)
	love.graphics.draw(self.image, quad, self.x, self.y)
end

function Display_Object:intersects_rect(d_object)
	assert(d_object)
	local a_min = self.x
	local a_max = a_min + self.width
	local b_min = d_object.x
	local b_max = d_object.x + d_object.width

	if b_min > a_min then
		a_min = b_min 
	end
	if b_max < a_max then
		a_max = b_max
	end
	if a_max <= a_min then
		return false
	end

	a_min = self.y
	a_max = a_min + self.height
	b_min = d_object.y
	b_max = b_min + d_object.height

	if b_min > a_min then
		a_min = b_min 
	end
	if b_max < a_max then
		a_max = b_max
	end
	if a_max <= a_min then
		return false
	end

	return true
end

function Display_Object:intersects_circle(d_object)
	local a_radius = (self.width + self.height) / 2.0
	local b_radius = (d_object.width + d_object.height) / 2.0

	local delta_x = math.abs(
			(self.x + self.width / 2.0) - 
			(d_object.x + d_object.width / 2.0))
	local delta_y = math.abs(
			(self.y + self.height / 2.0) - 
			(d_object.y + d_object.height / 2.0))
	local distance = math.sqrt(delta_x^2 + delta_y^2)
	if distance < (a_radius + b_radius) / 2.0 then
		return true
	end
	return false
end

return Display_Object
