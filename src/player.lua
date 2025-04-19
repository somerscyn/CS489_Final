local Class = require 'libs.hump.class'
local Push = require 'libs.push'
local Player = Class{}
local Globals = require 'src.Globals'
local stagemanager = require 'src.stages.StageManager'
local Anim8 = require "libs.anim8"
local Sounds = require "src.game.Sounds"
local Class = require "libs.hump.class"
local Tween = require "libs.tween"

local idleSprite = love.graphics.newImage(
    "assets/samurai/sprites/IDLE.png")
local idleGrid = Anim8.newGrid(64,64,
    idleSprite:getWidth(),idleSprite:getHeight())
local idleAnim = Anim8.newAnimation(idleGrid('1-10',1), 0.3)

local runSprite = love.graphics.newImage(
    "assets/samurai/sprites/RUN.png")
local runGrid = Anim8.newGrid(64,64,
    runSprite:getWidth(),runSprite:getHeight())
local runAnim = Anim8.newAnimation( runGrid('1-16',1), 0.1)

local jumpSprite = love.graphics.newImage(
    "graphics/char/Jump-All-Sheet.png")
local jumpGrid = Anim8.newGrid(64,64,
    jumpSprite:getWidth(),jumpSprite:getHeight())
local jumpAnim = Anim8.newAnimation( jumpGrid('1-15',1), 0.1)

-- Attack Animation Resources
local attackSprite = love.graphics.newImage("graphics/char/Attack-Sheet.png")
local attackGrid = Anim8.newGrid(96, 80, attackSprite:getWidth(), attackSprite:getHeight())
local attack1Anim = Anim8.newAnimation(attackGrid('1-4',1),0.15)
local attack2Anim = Anim8.newAnimation(attackGrid('5-8',1),0.15)

-- Getting Hit Animation Resources (reusing Jump Sprites)
local hitSprite = jumpSprite
local hitGrid = jumpGrid
local hitAnim = Anim8.newAnimation(hitGrid('13-14',1,2,1),0.3)
-- Gets the frames 13-14, line 1, and frame 2, line 1

-- Dying animation resources
local dieSprite = love.graphics.newImage("graphics/char/Dead-Sheet.png")
local dieGrid = Anim8.newGrid(80, 80, dieSprite:getWidth(), dieSprite:getHeight())
local dieAnim = Anim8.newAnimation(dieGrid('1-8',1),0.1)

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

    self.animations = {}
    self.sprites = {}
    self:createAnimations()
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

function Player:createAnimations()
    self.animations["idle"] = idleAnim
    self.animations["run"] = runAnim
    self.animations["jump"] = jumpAnim
    self.animations["attack1"] = attack1Anim
    self.animations["attack2"] = attack2Anim
    self.animations["hit"] = hitAnim
    self.animations["die"] = dieAnim

    -- Set the default animation to idle
    self.currentAnimation = "idle"
end

return Player