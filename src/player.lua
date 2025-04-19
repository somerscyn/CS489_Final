local Class = require 'libs.hump.class'
local Push = require 'libs.push'
local Player = Class{}
local Globals = require 'src.Globals'
local stagemanager = require 'src.stages.StageManager'

function  Player:init(x, y, manager)
    self.x = x
    self.y = y
    self.scale = .5
    self.speed = 300

    self.image = love.graphics.newImage('assets/images/player.png')
    self.width = self.image:getWidth() * self.scale
    self.height = self.image:getHeight() * self.scale
    self.stageImg = love.graphics.newImage('assets/images/MapS0.png')

    self.stagemanager = manager
end


function Player:update(dt)
    if self.x > 0 and self.x < gameWidth - self.width then
        if love.keyboard.isDown("w") then self.y = self.y - self.speed * dt end
        if love.keyboard.isDown("s") then self.y = self.y + self.speed * dt end
        if love.keyboard.isDown("a") then self.x = self.x - self.speed * dt end
        if love.keyboard.isDown("d") then self.x = self.x + self.speed * dt end
    end
end

function Player:draw()
    bg = love.graphics.newImage('assets/images/Background1.jpg')
    love.graphics.draw(bg)
    love.graphics.draw(self.stageImg)
    love.graphics.draw(self.image, self.x, self.y, 0, self.scale, self.scale)
    --code to draw background image

end

return Player