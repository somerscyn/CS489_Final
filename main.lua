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
    if gameState == "play" then
        player:update(dt)
        -- Update logic for the start state
    end


    player:update(dt)
    -- Update logic here

end

function love.draw()

    if gameState == "start" then
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Press something to contine", 200, gameHeight/2, 0 , 5,5)
    end

    --Push:start()
    if gameState == "play" then
        drawPlayState()
    end
    --Push:finish()
end 


function drawPlayState()
    love.graphics.setColor(1, 1, 1)
    player:draw()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

