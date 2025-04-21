local Class = require "libs.hump.class"
local Tween = require "libs.tween"
local Stage = require "src.stages.Stage"



local StageManager = Class{}
function StageManager:init()
    self.stages = {}
    self.currentStage = nil
    self.currentStageIndex = 1
     -- Example dimensions and max rooms
end

function StageManager:addStage(stage)
    table.insert(self.stages, stage)
end

function StageManager:draw()
    self.stages[self.currentStageIndex]:draw()
end

function StageManager:update(dt)
    self.stages[self.currentStageIndex]:update(dt)
end

function StageManager:NextStage()
    self.currentStageIndex = self.currentStageIndex + 1
end

function StageManager:CurrentStage()
    return self.stages[self.currentStageIndex]
end

function StageManager:GenerateFloor(width, height, maxRooms)
    -- Create a grid to represent our floor layout
--010  
--011 
--010
--000
    self.roomGrid = {}
    for x = 1, width do
        self.roomGrid[x] = {}
        for y = 1, height do
            self.roomGrid[x][y] = {
                exists = false,
                visited = false,
                type = "none",
                connections = {north = false, south = false, east = false, west = false}
            }
        end
    end

    -- where player initialy starts on the grid
    local entranceX, entranceY = math.random(1, width), math.random(1, height)
    self.roomGrid[entranceX][entranceY] = {
        exists = true,
        visited = true,
        type = "entrance",
        connections = {north = false, south = false, east = false, west = false}
    
    }

    -- random walk alg
    local currentX, currentY = entranceX, entranceY
    local roomsPlaced = 1
    
    -- Continue generating until we've placed enough rooms
    while roomsPlaced < maxRooms do
        -- Pick a random direction
        local directions = {"up", "down", "left", "right"}
        local dirIndex = math.random(1, #directions)
        local direction = directions[dirIndex]
        
        local newX, newY = currentX, currentY
        
        -- Calculate new position based on direction
        if direction == "up" then
            newY = newY - 1
        elseif direction == "down" then
            newY = newY + 1
        elseif direction == "right" then
            newX = newX + 1
        elseif direction == "left" then
            newX = newX - 1
        end

        -- Check if the new position is valid
        if newX >= 1 and newX <= width and newY >= 1 and newY <= height then
            if not self.roomGrid[newX][newY].exists then
                -- Create a new room
                self.roomGrid[newX][newY] = {
                    exists = true,
                    visited = false,
                    type = "normal",
                    connections = {up = false, down = false, left = false, right = false}
                }
                
                -- Connect the rooms
                if direction == "north" then
                    self.roomGrid[currentX][currentY].connections.up = true
                    self.roomGrid[newX][newY].connections.down = true
                elseif direction == "south" then
                    self.roomGrid[currentX][currentY].connections.down = true
                    self.roomGrid[newX][newY].connections.up = true
                elseif direction == "east" then
                    self.roomGrid[currentX][currentY].connections.left = true
                    self.roomGrid[newX][newY].connections.right = true
                elseif direction == "west" then
                    self.roomGrid[currentX][currentY].connections.right = true
                    self.roomGrid[newX][newY].connections.left = true
                end
                
                roomsPlaced = roomsPlaced + 1
                currentX, currentY = newX, newY
            end
        end
    end
    self.roomGrid[currentX][currentY].type = "exit"

    self:CreateStages()


end

function StageManager:CreateStages()
    self.stages = {}
        -- Loop through the grid and create stages for each room that exists
        for x = 1, #self.roomGrid do
            for y = 1, #self.roomGrid[x] do
                local room = self.roomGrid[x][y]
                if room.exists then
                    local stageData = self:GenerateStageObjects(x, y, room.type, room.connections)
                    local stage = Stage(stageData.background, stageData.objects, stageData.music)
                    
                    -- Store the grid position in the stage for navigation
                    stage.gridX = x
                    stage.gridY = y
                    stage.roomType = room.type
                    stage.connections = room.connections
                    
                    -- Set initial player position if this is the entrance
                    if room.type == "entrance" then
                        stage.initialPlayerX = 500
                        stage.initialPlayerY = 300
                        self.currentStageIndex = #self.stages + 1
                    end
                    
                    self:addStage(stage)
                end
            end
        end
end



function StageManager:GenerateStageObjects(x, y, roomType, connections)
        local objects = {}
        local background = "assets/images/MapS1.png"
        local music

        local enemyCount = math.random(1, 5)
        for i = 1, enemyCount do
            local enemyX = math.random(stageX, stageX + stageWidth - 50)
            local enemyY = math.random(stageY, stageY + stageHeight - 50)
            table.insert(objects, require('src.Objects.mobs.Slime')(enemyX, enemyY, 50, 50))
        end

        local obstacleCount = math.random(2, 5)
        for i = 1, obstacleCount do
            local obsX = math.random(stageX + 100, stageX + stageWidth - 50)
            local obsY = math.random(stageY + 100, stageY + stageHeight - 50)
            local obsSize = math.random(30, 60)
            table.insert(objects, require('src.Objects.Rock')(obsX, obsY, obsSize, obsSize))
        end

        return {
            background = background,
            objects = objects,
            music = music
        }
end
return StageManager