local Enemy = {}
function Enemy:display ()
  love.graphics.draw(self.image,self.x,self.y, 0, 1, 1)
end
function Enemy.new (x,y,file)
  e = {}
  e.display = Enemy.display
  e.x = x
  e.y = y
  e.image = love.graphics.newImage(file)
  return e

end
return Enemy
