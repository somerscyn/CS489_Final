local Class = require "libs.hump.class"
local Anim8 = require "libs.anim8"
local Timer = require "libs.hump.timer"
--local Hbox = require "src.game.Hbox"
--local Sounds = require "src.game.Sounds"

local slimeSprite = love.graphics.newImage("assets/images/slime.png")
local slimeGrid = Anim8.newGrid(16, 32, slimeSprite:getWidth(), slimeSprite:getHeight())
local slimeAnim = Anim8.newAnimation(slimeGrid('1-11',1),0.2)

local Slime = Class{}

function Slime:init()
    self.x = love.graphics.getWidth() / 2
    --middle of the screen
    self.y = love.graphics.getHeight() / 2
    self.animations = {}
    self.sprites = {}

    self:setAnimation("slime",slimeSprite, slimeAnim)
end

function Slime:setAnimation(st,sprite,anim)
    self.animations[st] = anim
    self.sprites[st] = sprite
end

function Slime:update(dt)
    self.animations.slime:update(dt)
end

function Slime:draw()
    love.graphics.setColor(1, 1, 1)
    self.animations.slime:draw(self.sprites.slime, self.x, self.y, 0, 2, 2)
end

return Slime



