local Class = require "libs.hump.class"
local Anim8 = require "libs.anim8"
local Timer = require "libs.hump.timer"
--local Hbox = require "src.game.Hbox"
--local Sounds = require "src.game.Sounds"

local slimeSprite = love.graphics.newImage("assets/images/green.png")
local slimeGrid = Anim8.newGrid(16, 32, slimeSprite:getWidth(), slimeSprite:getHeight())
local slimeAnim = Anim8.newAnimation(slimeGrid('1-11',1),0.2)

local Green = Class{}

function Green:init(x,y)
    self.x = nil
    --middle of the screen
    self.y = nil
    self.animations = {}
    self.sprites = {}

    self:setAnimation("slime",slimeSprite, slimeAnim)
end

function Green:setAnimation(st,sprite,anim)
    self.animations[st] = anim
    self.sprites[st] = sprite
end

function Green:update(dt)
    self.animations.slime:update(dt)
end

function Green:draw()
    love.graphics.setColor(1, 1, 1)
    self.animations.slime:draw(self.sprites.slime, self.x, self.y, 0, 2, 2)
end

return Green



