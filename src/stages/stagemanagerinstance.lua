local StageManager = require "src.stages.StageManager"
local createS0 = require "src.stages.createS0"


local manager = StageManager()

manager.createStage[1] = createS0 

return manager