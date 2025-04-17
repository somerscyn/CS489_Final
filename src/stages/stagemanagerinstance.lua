local StageManager = require "src.stages.StageManager"
local createS0 = require "src.stages.createS0"
local createS1 = require "src.stages.createS1"

local manager = StageManager()

manager.createStage[0] = createS0 
manager.createStage[1] = createS1

return manager