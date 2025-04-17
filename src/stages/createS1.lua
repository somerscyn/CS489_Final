
local Stage = require "src.stages.Stage"
local BasicTileset = require "src.tiling.BasicTileset"
local Background = require "src.tiling.Background"

local function createS1()
    local stage = Stage(20,50,BasicTileset)
    local mapdata = require "src.game.maps.map1"
    stage:readMapData(mapdata)

    --local objdata = require "src.game.maps.map1objects"
    --stage:readObjectsData(objdata)

    -- Backgrounds
    local bg1 = Background("assets/images/Background1.jpg")

    stage:addBackground(bg1)
 

    -- Initial Player Pos
    stage.initialPlayerX = 1*16
    stage.initialPlayerY = 13*16 

    return stage
end

return createS1
