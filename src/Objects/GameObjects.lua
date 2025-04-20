-- src/game/GameObject.lua
local Class = require 'libs.hump.class'

local GameObject = Class{}

function GameObject:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.type = "gameObject" -- default type
end

function GameObject:draw()
    love.graphics.setColor(0, 0, 0) -- red translucent
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(1, 1, 1, 1)

    if debugMode then
        love.graphics.setColor(1, 0, 0, 0.5) -- red semi-transparent
        love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
        love.graphics.setColor(1, 1, 1, 1)
    end
end

function GameObject:checkCollision(x, y, w, h)
    --print (self.x, self.y, self.width, self.height)
    return x < self.x + self.width and
           self.x < x + w and
           y < self.y + self.height and
           self.y < y + h     
end

return GameObject
