local Class = require 'libs.hump.class'
local GameObject = require 'src.Objects.GameObjects'

local Rock = Class{__includes = GameObject}

function Rock:init(x, y, width, height)
    self.image = love.graphics.newImage('assets/images/rock.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    GameObject.init(self, x, y, self.width, self.height)
end

function Rock:draw()
    love.graphics.setColor(1, 1, 1, 1) -- white
    love.graphics.draw(self.image, self.x, self.y, 0, 0.1, 0.1)
end

function Rock:update(dt)
    -- Update logic for the rock object can be added here if needed
end

return Rock