local Class = require 'libs.hump.class'
local Push = require 'libs.push'
local Player = Class{}
local Globals = require 'src.Globals'
local stagemanager = require 'src.stages.StageManager'

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
    love.graphics.draw(self.image, self.x, self.y, 0, self.scale, self.scale)
    --code to draw background image

end

return Player