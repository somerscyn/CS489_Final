local Globals = require 'src.Globals'
local Push = require 'libs.push'
local Player = require 'src.Objects.Player'
local StageManager = require 'src.stages.StageManager'
local Slime = require 'src.Slime'
local Stage = require 'src.stages.Stage'
local GameObject = require 'src.Objects.GameObjects' 
local S0 = require 'src.stages.stageData.S0'


function love.load()

    love.window.setTitle("Retro Musashi")

    love.window.setMode(1280, 720, {resizable = true})
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1)
    love.graphics.setColor(1, 1, 1)
    
    player = Player(400, 300, manager)
    slime = Slime(400, 300, manager)

    manager = StageManager()
    testStage = Stage(S0.background, S0.objects, 0)
    manager:addStage(testStage)


    --manager:setPlayer(player)



    
    titleFont = love.graphics.newFont("assets/fonts/Kaph-Regular.ttf",26)
   -- manager:setStage(1) -- set stage 0

end

function love.update(dt)
    if gameState == "play" then
        player:update(dt)
        manager:update(dt)
        --Update logic for the start state
    end


end

function love.draw()

    if gameState == "start" then
        love.graphics.setColor(1, 1, 1)
        drawStartState()
    end

    --Push:start()
    if gameState == "play" then
        drawPlayState()
    end
    if gameState == "gameover" then
        drawGameOverState()
    end
    --Push:finish()
end 

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    if key and gameState == "start" then
        gameState = "play"
    end
end

function drawStartState()
    love.graphics.setColor(0.3,0.3,0.3) -- dark gray
    --stagemanager:currentStage():drawBg()
    --stagemanager:currentStage():draw() -- draw Stage zero
    love.graphics.setColor(1,1,0) -- Yellow
    love.graphics.printf("Retro Musashi", titleFont,0,200,gameWidth,"center") 
    love.graphics.printf("Press Enter to Start",0,270,gameWidth,"center") 
        
end

function drawPlayState()

    --stagemanager:currentStage():drawBg()

    --camera:attach()

   -- stagemanager:currentStage():draw()
    love.graphics.setColor(1,1,1) -- white
    

    manager:draw()
    slime:draw()
    player:draw()
    
    --camera:detach()

    --hud:draw()
end

function drawGameOverState()
    love.graphics.setColor(1,0,0) -- red
    love.graphics.printf("Game Over", titleFont,0,20,gameWidth,"center") 
    love.graphics.printf("Press Enter to Restart",0,100,gameWidth,"center") 
end