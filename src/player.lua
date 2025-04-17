local Class = require 'libs.hump.class'
local Push = require 'libs.push'
local Player = Class{}
local Globals = require 'src.Globals'

function  Player:init(x, y)
    self.x = x
    self.y = y
    self.width = 16
    self.height = 16
    self.speed = 120
    self.image = love.graphics.newImage('assets/images/player.png')
end


function Player:update(dt)
    if love.keyboard.isDown("w") then self.y = self.y - self.speed * dt end
    if love.keyboard.isDown("s") then self.y = self.y + self.speed * dt end
    if love.keyboard.isDown("a") then self.x = self.x - self.speed * dt end
    if love.keyboard.isDown("d") then self.x = self.x + self.speed * dt end
end

function Player:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

return Player