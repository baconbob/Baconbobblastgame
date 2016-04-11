local rotation = 0
local accerelation = 0
local x = 0
local y = 0
local buttons = {"quit", "exit MENU"}
local invertspin = false
local width
local height
local speed = 300
local x1 = 50
local y1 = 50
local sfx


function love.draw()
  love.graphics.draw(eft, 0, 0, r, 1, 1)
  --love.graphics.draw(mario,x,y, rotation, 0.3, 0.3)
  love.graphics.print("the accerelation; " .. accerelation, 10, 30)
  love.graphics.setBackgroundColor(10,100, 100, 255)
  --if accerelation > 50
  --then love.graphics.draw(GABEN, (width/2), (height/2), -rotation, 0.5, 0.5)
  --end
  love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
  love.graphics.draw(mainchar, x1, y1, 0, 1, 1, ox, oy, kx, ky)
end


function love.update(dt)
  if invertspin then
    rotation = rotation + math.rad(accerelation)
  else
    rotation = rotation - math.rad(accerelation)
  end
  accerelation = accerelation + 0.05

  y = love.mouse.getY()
  x = love.mouse.getX()
  if love.keyboard.isDown("w") then y1 = y1 - 5 end
  if love.keyboard.isDown("a") then x1 = x1 - 5 end
  if love.keyboard.isDown("s") then y1 = y1 + 5 end
  if love.keyboard.isDown("d") then x1 = x1 + 5 end
  if x1+250>width then x1=width-250 end


end

function love.load()
  --mario = love.graphics.newImage("MARIO-BABY.png")
  --GABEN = love.graphics.newImage("GABENN.png")
  love.window.setMode(0, 0,{fullscreen=true,vsync=true})
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
  eft = love.graphics.newImage("space.jpg")
  imageData = love.graphics.newImage("cursor.png")
  cursor = love.mouse.newCursor( imageData:getData(), 5, 5 )
  love.mouse.setCursor(cursor)
  mainchar = love.graphics.newImage("blyatt.png")
  sfx = love.audio.newSource("xplosion.wav","stream")
end

function love.keypressed(key)
  if key == "r" then accerelation = 0
  end
  if key == "escape" then
    local buttonpressed = love.window.showMessageBox("MENU", "What do you want to do blyat", buttons)
    if buttonpressed == 1 then love.event.quit()
    elseif buttonpressed == 2 then end
  end
  if key == "t" then invertspin=not invertspin end
  if key == "q" then sfx:play() end
end
