local Class = require "libs.hump.class"
local Tween = require "libs.tween"
local Stage = require "src.stages.Stage"



local StageManager = Class{}
function StageManager:init()
    self.stages = {}
    self.currentStage = nil
    self.currentStageIndex = 1
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
return StageManager