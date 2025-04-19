local Class = require 'libs.hump.class'
local GameObject = require 'src.Objects.GameObject'

local Rock = Class{__includes = GameObject}

function Rock:init(x, y, width, height)
    self.image = love.graphics.newImage('assets/images/rock.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    GameObject.init(self, x, y, self.width, self.height)
end