local Class = require "libs.hump.class"
local Anim8 = require "libs.anim8"
local Timer = require "libs.hump.timer"
--local Hbox = require "src.game.Hbox"
--local Sounds = require "src.game.Sounds"
local GameObject = require "src.Objects.GameObjects"

local slimeSprite = love.graphics.newImage("assets/images/slime.png")
local slimeGrid = Anim8.newGrid(16, 32, slimeSprite:getWidth(), slimeSprite:getHeight())
--local slimeAnim = Anim8.newAnimation(slimeGrid('1-11',1),0.2)

local slimeFrames = slimeGrid('1-11', 1)
local slimeAnim = Anim8.newAnimation(slimeFrames, 0.1)

local Slime = Class{__includes = GameObject}

function Slime:init(x,y, width, height)

    -- hard coded values for collision box... not quite sure why 48 and 32 work
    GameObject.init(self, x, y, 48, 32)
    self.animations = {}
    self.sprites = {}

    self.speed = 200
    self.health = 1
    self.frames = slimeFrames

    self.type = "mob"

    self:setAnimation("slime", slimeSprite, slimeAnim:clone())
end

function Slime:setAnimation(st,sprite,anim)
    self.animations[st] = anim
    self.sprites[st] = sprite
end

function Slime:update(dt, player)
    self.animations.slime:update(dt)


    local frame = self.animations.slime.position
    print(frame)
    if player and frame > 7 and frame < 11 then
        self:chasePlayer(player.x, player.y, dt)
    end
end

function Slime:draw()
    love.graphics.setColor(1, 1, 1)

    local scale = 3
    local offsetY = self.height * scale - self.height 
    self.animations.slime:draw(
        self.sprites.slime,
        self.x,
        self.y - offsetY, 
        0,
        scale,
        scale
    )

    if debugFlag then
        love.graphics.setColor(1, 0, 0, 0.5) -- red semi-transparent
        love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
        love.graphics.setColor(1, 1, 1, 1)
    end
end

function Slime:chasePlayer(playerX, playerY, dt)

    --manhattan distance used for movement
    local dx = playerX - self.x
    local dy = playerY - self.y
    local distance = math.sqrt(dx * dx + dy * dy)

    if distance > 0 then
        local directionX = dx / distance
        local directionY = dy / distance

        self.x = self.x + directionX * self.speed * dt
        self.y = self.y + directionY * self.speed * dt
    end
end



return Slime



