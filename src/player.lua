local Class = require 'libs.hump.class'
local Push = require 'libs.push'
local Player = Class{}
local Globals = require 'src.Globals'
local stagemanager = require 'src.stages.StageManager'
local Anim8 = require "libs.anim8"
--local Sounds = require "src.game.Sounds"
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



function  Player:init(x, y, manager)
    self.x = x
    self.y = y
    self.scale = .25
    self.speed = 300

    self.image = love.graphics.newImage('assets/images/player.png')
    self.width = self.image:getWidth() * self.scale
    self.height = self.image:getHeight() * self.scale

    self.stageImg = love.graphics.newImage('assets/images/MapS0.png')
    stageWidth = self.stageImg:getWidth()
    stageHeight = self.stageImg:getHeight()

    self.stagemanager = manager

    self.animations = {}
    self.sprites = {}
    self:createAnimations()
end


function Player:update(dt)

        local nextX = self.x
        local nextY = self.y

        if love.keyboard.isDown("w") then nextY = nextY - self.speed * dt end
        if love.keyboard.isDown("s") then nextY = nextY + self.speed * dt end
        if love.keyboard.isDown("a") then nextX = nextX - self.speed * dt end
        if love.keyboard.isDown("d") then nextX = nextX + self.speed * dt end
        -- Clamp to stage boundaries
        if nextX < stageX then nextX = stageX end
        if nextY < stageY then nextY = stageY end

        if nextX + self.width > stageWidth then nextX = stageWidth - self.width end
        print(stageWidth, stageHeight)
        if nextY + self.height > stageHeight then nextY = stageHeight - self.height end
    
        self.x = nextX
        self.y = nextY
end

function Player:draw()
    love.graphics.draw(self.stageImg, stageX, stageY)
    bg = love.graphics.newImage('assets/images/Background1.jpg')
    --love.graphics.draw(bg)
   -- love.graphics.draw(self.stageImg)
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