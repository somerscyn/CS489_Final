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
    love.graphics.print("Hello, World!", 400, 300)
end 

