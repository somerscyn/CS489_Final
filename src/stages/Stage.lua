local Class = require "libs.hump.class"
local Matrix = require "libs.matrix"
local Globals = require "src.globals"



local Stage = Class{}
function Stage:init(background, objects, music)

    self.initialPlayerY = 0
    self.initialPlayerX = 0

    self.background = love.graphics.newImage(background) -- background image
    self.music = nil -- this stage music 
    self.objects = objects 

    self.gridX = nil
    self.gridY = nil
    self.roomType = nil
    self.connections = nil

end

function Stage:update(dt)
    for _, obj in ipairs(self.objects) do
        if obj.update and obj.type == "mob"then
            obj:update(dt, player)
        elseif obj.update then
            obj:update(dt)
        end
    end
end


function Stage:draw()
    love.graphics.draw(self.background, stageX, stageY)
    for _, obj in ipairs(self.objects) do
        if obj.draw then
            obj:draw()
        end
    end
end


return Stage