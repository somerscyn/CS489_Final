local Stage = require 'src.stages.Stage'
local Background = require 'src.tiling.Background'
local Tileset = require "src.tiling.BasicTileset"

local function createS0()
        local stage = Stage(80,45,Tileset)
        for row = 1, 80 do -- 15*16 = 240pixels
            for col = 1, 45 do -- 30*16 = 480 pixels
                if row < 75 then
                    stage.map[row][col] = nil
                elseif row == 75 then
                    stage.map[row][col] = stage.tileset:get(2)
                else
                    stage.map[row][col] = stage.tileset:get(10)
                end
            end -- end for col
        end -- end for row
    
        -- Backgrounds
        local bg1 = Background("assets.images.Background1")
    
        stage:addBackground(bg1)
    
        -- Initial Player Pos
        stage.initialPlayerX = 1*16
        stage.initialPlayerY = 8*16
        
        return stage
    end -- end funcion createS0

return createS0