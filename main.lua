local Push = require 'libs.push'
local Player = require 'src.Player'

function love.load()

    love.window.setTitle("Retro Musashi")

    love.window.setMode(1280, 720, {resizable = true})
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1)
    love.graphics.setColor(1, 1, 1)

    player = Player(400, 300)
end

function love.update(dt)
    player:update(dt)
    -- Update logic here

end

function love.draw()
    --Push:start()

    player:draw()
    love.graphics.print("Hello, World!", 400, 300)

    --Push:finish()
end 

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function drawStartState()
    love.graphics.setColor(0.3,0.3,0.3) -- dark gray
    --stagemanager:currentStage():drawBg()
    --stagemanager:currentStage():draw() -- draw Stage zero
    player:draw() -- and the player sprite
    love.graphics.setColor(1,1,0) -- Yellow
    love.graphics.printf("Retro Musashi", titleFont,0,20,gameWidth,"center") -- Title    love.graphics.printf("Press Enter to Play", 0,140,gameWidth,"center")
    love.graphics.printf("Press Enter to Start",0,100,gameWidth,"center") -- Title    love.graphics.printf("Press Enter to Play", 0,140,gameWidth,"center")
        
end

function drawPlayState()

    --stagemanager:currentStage():drawBg()

    --camera:attach()

   -- stagemanager:currentStage():draw()
    player:draw()
    
    --camera:detach()

    --hud:draw()
end