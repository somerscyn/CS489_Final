local Class = require 'libs.hump.class'
local Push = require 'libs.push'
local Globals = require 'src.Globals'
local stagemanager = require 'src.stages.StageManager'
local Anim8 = require "libs.anim8"
--local Sounds = require "src.Sounds"
local Class = require "libs.hump.class"
local Tween = require "libs.tween"
local obj = require 'src.Objects.GameObjects'





local Player = Class{}

function Player:init(x, y, manager)
    self.x = x
    self.y = y
    self.scale = 1
    self.speed = 300
    
    self.padding = 10

    self.health = 6

    self.attack = 10

    self.image = love.graphics.newImage('assets/images/player.png')
    self.width = 50 * self.scale
    self.height = 50 * self.scale

    self.stageImg = love.graphics.newImage('assets/images/MapS0.png')


    self.stagemanager = manager
    
----Animation 
    self.sprites = {
        idle = love.graphics.newImage('assets/jeymarSam/samurai-idle-down.png'),
        walkUp = love.graphics.newImage('assets/jeymarSam/samurai-walk-up.png'),
        walkDown = love.graphics.newImage('assets/jeymarSam/samurai-walk-down.png'),
    }
    
    -- Build Anim8 grids and animations
    local frameW, frameH = 50, 50 

    self.grids = {
        idle = Anim8.newGrid(frameW, frameH, self.sprites.idle:getWidth(), self.sprites.idle:getHeight()),
        walkUp = Anim8.newGrid(frameW, frameH, self.sprites.walkUp:getWidth(), self.sprites.walkUp:getHeight()),
        walkDown = Anim8.newGrid(frameW, frameH, self.sprites.walkDown:getWidth(), self.sprites.walkDown:getHeight()),
    }
    
    self.animations = {
        idle = Anim8.newAnimation(self.grids.idle('1-4', 1), 0.2),
        walkUp = Anim8.newAnimation(self.grids.walkUp('1-7', 1), 0.15),
        walkDown = Anim8.newAnimation(self.grids.walkDown('1-8', 1), 0.15),
    }
    
    self.currentKey = "idle"
    self.currentAnimation = self.animations[self.currentKey]
end


function Player:update(dt)

        local nextX = self.x
        local nextY = self.y

        local moving = false
        

        if love.keyboard.isDown("w") then 
            nextY = nextY - self.speed * dt
            self.currentKey = "walkUp"
            moving = true
        end
        if love.keyboard.isDown("s") then 
            nextY = nextY + self.speed * dt 
            self.currentKey = "walkDown"
            moving = true
        end
        if love.keyboard.isDown("a") then nextX = nextX - self.speed * dt end
        if love.keyboard.isDown("d") then nextX = nextX + self.speed * dt end

        if not moving then
            self.currentKey = "idle"
        end
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
        hb = self:getHurtBox()
        for _, obj in ipairs(objects) do
            if obj:checkCollision(nextX, nextY, self.width, self.height) and obj.type == "obstacle" then
                -- Collision detected, stop movement
                collided = true
                break

            elseif obj:checkCollision(nextX, nextY, self.width, self.height) and obj.type == "mob" then
                if love.keyboard.isDown("k") then
                    obj.health = obj.health - self.attack
                    print(obj.health)
                end
            end
            if obj:checkCollision(hb.x, hb.y, hb.width, hb.height) and obj.type == "mob" then
                -- Collision detected, stop movement
                self.health = self.health - 0.5
            end
        end
        --print(self.x, self.y, self.width, self.height)
        
        if not collided then
            self.x = nextX
            self.y = nextY
        end
        self.currentAnimation:update(dt)
end

function Player:getHurtBox()
    return{
        x = self.x + self.padding,
        y = self.y + self.padding,
        width = self.width - self.padding * 2,
        height = self.height - self.padding * 2
    }

end

function Player:draw()
    --love.graphics.draw(self.stageImg, stageX, stageY)
    --love.graphics.draw(self.image, self.x, self.y, 0, self.scale, self.scale)
    self.currentAnimation:draw(self.sprites[self.currentKey], self.x, self.y, 0, self.scale, self.scale)


    if debugFlag then
        love.graphics.setColor(1, 0, 0, 0.5) -- red semi-transparent
        love.graphics.rectangle("line", self.x + 10, self.y+10, self.width - 20, self.height - 20)
        love.graphics.setColor(1, 1, 1, 1)

    end

end



return Player