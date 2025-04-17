function love.load()
    love.window.setMode(1280, 720, {resizable = true})
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1)
    love.graphics.setColor(1, 1, 1)
end

function love.update(dt)
    -- Update logic here
end

function love.draw()
    love.graphics.print("Hello, World!", 400, 300)
end 

