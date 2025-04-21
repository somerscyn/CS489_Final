--whole file needs to be changed
local Timer = require "libs.hump.timer"
local tween = require "libs.tween"
local Class = require "libs.hump.class"
local Anim8 = require "libs.anim8"

local FloatObj = Class{}
function FloatObj:init(img)
    self.x = gameWidth/2 - 200 -- center of the screen
    self.y = gameHeight + 50 -- start below the screen
    self.img = img
    self.tweenObj = nil
end

function FloatObj:tween(newY)
    self.tweenObj = tween.new(1,self,{y=newY})
end

function FloatText:draw()
    love.graphics.setColor(0, 0, 0, 0.5) -- RGBA (0.5 = 50% opacity)
    love.graphics.rectangle("fill", 0, self.y, gameWidth, 80, 5, 5) -- Draw a rounded rectangle

    -- Draw the white text
    love.graphics.setColor(1, 1, 1, 1) -- RGBA (1 = fully opaque)
    love.graphics.print(self.text, self.x, self.y, 0, 5,5)
end

function FloatText:reset()
    self.y = gameHeight + 50 -- reset to start below the screen
end

function FloatText:update(dt)
    if self.tweenObj then
        self.tweenObj:update(dt)
    end
end

return FloatText