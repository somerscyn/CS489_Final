local player = Class{}

function  Player:init(x, y)
    self.x = x
    self.y = y
    self.width = 16
    self.height = 16
    self.speed = 20
    --self.image = love.graphics.newImage('assets/player.png')
end


function Player:update(dt)
    if love.keyboard.isDown("w") then self.y = self.y - self.speed * dt end
    if love.keyboard.isDown("s") then self.y = self.y + self.speed * dt end
    if love.keyboard.isDown("a") then self.x = self.x - self.speed * dt end
    if love.keyboard.isDown("d") then self.x = self.x + self.speed * dt end
end

