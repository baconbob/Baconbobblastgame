local Vector_2 = {}

function Vector_2.new(x, y)
	self = {}
	for k, v in pairs(Vector_2) do
		self[k] = Vector_2[k];
	end

	self.x = x
	self.y = y
	return self
end

function Vector_2:length()
	return math.sqrt(self.x^2 + self.y^2)
end

function Vector_2:normalize()
	return Vector_2.new(self.x / self:length(), self.y / self:length())
end

return Vector_2
