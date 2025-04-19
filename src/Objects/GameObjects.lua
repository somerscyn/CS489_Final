-- src/game/GameObject.lua
local Class = require 'libs.hump.class'

local GameObject = Class{}

function GameObject:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
end

function GameObject:draw()
    love.graphics.setColor(0, 0, 0) -- red translucent
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(1, 1, 1, 1)
end

function GameObject:checkCollision(x, y, w, h)
    return x < self.x + self.width and
           self.x < x + w and
           y < self.y + self.height and
           self.y < y + h
end

return GameObject
