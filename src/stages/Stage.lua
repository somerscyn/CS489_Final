local Class = require "libs.hump.class"
local Matrix = require "libs.matrix"



local Stage = Class{}
function Stage:init(background, objects, mobs, music)

    self.initialPlayerY = 0
    self.initialPlayerX = 0

    self.music = nil -- this stage music
    self.mobs = mobs -- mobs
    self.objects = objects -- game objects

end

function Stage:update(dt)
    for _, obj in ipairs(self.objects) do
        if obj.update then
            obj:update(dt)
        end
    end
    for _, mob in ipairs(self.mobs) do
        if mob.update then
            mob:update(dt)
        end
    end
end


function Stage:draw()
    for _, obj in ipairs(self.objects) do
        if obj.draw then
            obj:draw()
        end
    end
end


return Stage