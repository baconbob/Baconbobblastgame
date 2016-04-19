local rotation = 0
local accerelation = 0
local x = 0
local y = 0
local buttons = {"quit", "exit MENU"}
local invertspin = false
local width
local height
local x1 = 50
local y1 = 50
local sfx
local speed = 2
local mouse
local Enemy = require "Enemy"
local enemies = {}
local milliseconds = 0
local fraction = 1/10
local object_to_main =  {}

function love.draw()
  love.graphics.draw(eft, 0, 0, r, 1, 1)
  love.graphics.draw(mario,1530,70, rotation, 2, 2)
  love.graphics.print("the accerelation; " .. accerelation, 10, 37.5)
  love.graphics.setBackgroundColor(10,100, 100, 255)
  --if accerelation > 50
  --then love.graphics.draw(GABEN, (width/2), (height/2), -rotation, 0.5, 0.5)
  --end
  love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 12.5)
  love.graphics.draw(mainchar, x1, y1, 0, 1, 1, ox, oy, kx, ky)
  love.graphics.print("Current speed:" .. speed,10,25)
  love.graphics.print("Current position x:" .. x1 .. " \nCurrent position y:" .. y1,10,50)

  for i = 1, #enemies do
	enemies[i]:draw()
	end
end

function love.update(dt)
  milliseconds = milliseconds + dt
  if milliseconds >= 1
  then enemies[#enemies+1] = Enemy.new("GABENN.png", math.random(0, width), math.random(0, height))
	  milliseconds = 0  end
  if invertspin then
    rotation = rotation + math.rad(accerelation)
  else
    rotation = rotation - math.rad(accerelation)
  end
  accerelation = accerelation + 0.01

  y = love.mouse.getY()
  x = love.mouse.getX()
  if love.keyboard.isDown("w") then y1 = y1 - speed end
  if love.keyboard.isDown("a") then x1 = x1 - speed end
  if love.keyboard.isDown("s") then y1 = y1 + speed end
  if love.keyboard.isDown("d") then x1 = x1 + speed end
  if x1+250>width then x1=width-250 end
  if y1+75>height then y1=height-75 end
  if y1<0 then y1=0 end
  if x1<0 then x1=0 end
  --[[for i,v in ipairs(enemies) do
    object_to_main.x = x1 - v.x
    object_to_main.y = y1 - v.y
    v.x = v.x +(object_to_main.x* 0.1)
    v.y = v.y +(object_to_main.y* 0.1)
  end]] --THIS IS THE SHIT FOR COIN= POINTS
  for k,v in pairs(enemies) do
    v.x=v.x + x1*0.001
    v.y=v.y + y1*0.001
  end
if speed > 2 then
 speed = speed * 0.996
 else speed = 2
 end


end

function love.load()
  mario = love.graphics.newImage("tracking-dot.png")
  --GABEN = love.graphics.newImage("GABENN.png")
  love.window.setMode(0, 0,{fullscreen=true,vsync=false})
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
  eft = love.graphics.newImage("space.jpg")
  imageData = love.graphics.newImage("cursor.png")
  cursor = love.mouse.newCursor( imageData:getData(), 5, 5 )
  love.mouse.setCursor(cursor)
  mainchar = love.graphics.newImage("blyatt.png")
  sfx = love.audio.newSource("xplosion.wav","stream")
  love.physics.setMeter(64)
  math.randomseed(os.time())
end

function love.keypressed(key)
  if key == "r" then
    speed=accerelation
    accerelation = 0
    print (speed)
  end
  if key == "escape" then
    local buttonpressed = love.window.showMessageBox("MENU", "What do you want to do blyat", buttons)
    if buttonpressed == 1 then love.event.quit()
    elseif buttonpressed == 2 then end
  end
  if key == "t" then invertspin=not invertspin end
  if key == "q" then sfx:play() end
end
