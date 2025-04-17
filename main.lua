local Push = require 'libs.push'
local Player = require 'src.Player'

function love.load()

    love.window.setTitle("Retro Musashi")

    love.window.setMode(1280, 720, {resizable = true})
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1)
    love.graphics.setColor(1, 1, 1)

    player = Player(400, 300)
    titleFont = love.graphics.newFont("assets/fonts/Kaph-Regular.ttf",26)

end

function love.update(dt)
    if gameState == "play" then
        player:update(dt)
        -- Update logic for the start state
    end


    player:update(dt)
    -- Update logic here

end

function love.draw()

    if gameState == "start" then
<<<<<<< HEAD
=======
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Press something to contine", 200, gameHeight/2, 0 , 5,5)
>>>>>>> b56e64c04b2f65d247ff53c8e31bcd325ff2a50a
        drawStartState()
    end

    --Push:start()
    if gameState == "play" then
        drawPlayState()
    end
    --Push:finish()
end 

<<<<<<< HEAD

=======
>>>>>>> b56e64c04b2f65d247ff53c8e31bcd325ff2a50a
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
   -- love.graphics.printf("Retro Musashi", titleFont,0,20,gameWidth,"center") 
    love.graphics.printf("Press Enter to Start",0,100,gameWidth,"center") 
        
end

function drawPlayState()

    --stagemanager:currentStage():drawBg()

    --camera:attach()

   -- stagemanager:currentStage():draw()
    love.graphics.setColor(1,1,1) -- white
    player:draw()
    
    --camera:detach()

    --hud:draw()
end