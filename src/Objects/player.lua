local Class = require 'libs.hump.class'
local Push = require 'libs.push'
local Globals = require 'src.Globals'
local stagemanager = require 'src.stages.StageManager'
local Anim8 = require "libs.anim8"
--local Sounds = require "src.Sounds"
local Class = require "libs.hump.class"
local Tween = require "libs.tween"
local obj = require 'src.Objects.GameObjects'

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


local Player = Class{}

function Player:init(x, y, manager)
    self.x = x
    self.y = y
    self.scale = .25
    self.speed = 300

    self.health = 6

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

        local nextX = self.x
        local nextY = self.y

        if love.keyboard.isDown("w") then nextY = nextY - self.speed * dt end
        if love.keyboard.isDown("s") then nextY = nextY + self.speed * dt end
        if love.keyboard.isDown("a") then nextX = nextX - self.speed * dt end
        if love.keyboard.isDown("d") then nextX = nextX + self.speed * dt end
        -- Clamp to stage boundaries
        if nextX < stageX+5 then nextX = stageX+5 end
        if nextY < stageY+16 then nextY = stageY+16 end

        stageRight = stageX + stageWidth -16
        stageBottom = stageY + stageHeight 

        if nextX + self.width > stageWidth +stageX then nextX = stageRight-self.width  end
        if nextY + self.height > stageHeight + stageY then nextY = stageBottom - self.height  end

        if nextX < stageX + 5 then
            nextX = stageX + 5
            self.speed = 0
        elseif nextX + self.width > stageRight then
            nextX = stageRight - self.width
            self.speed = 0
        end

        self.speed = 300
    
        local currentStage = manager:CurrentStage()
        local objects = currentStage.objects
        local collided = false
        for _, obj in ipairs(objects) do
            if obj:checkCollision(nextX, nextY, self.width, self.height) and obj.type == "obstacle" then
                -- Collision detected, stop movement
                collided = true
                break
            end
        end
        --print(self.x, self.y, self.width, self.height)
        
        if not collided then
            self.x = nextX
            self.y = nextY
        end


end

function Player:draw()
    --love.graphics.draw(self.stageImg, stageX, stageY)
    love.graphics.draw(self.image, self.x, self.y, 0, self.scale, self.scale)
    if debugFlag then
        love.graphics.setColor(1, 0, 0, 0.5) -- red semi-transparent
        love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
        love.graphics.setColor(1, 1, 1, 1)
    end

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