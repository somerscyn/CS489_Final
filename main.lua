local Globals = require 'src.Globals'
local Push = require 'libs.push'
local Player = require 'src.Objects.Player'
local StageManager = require 'src.stages.StageManager'
local Slime = require 'src.Slime'
local Green = require 'src.Green'
local Class = require "libs.hump.class"
local FloatText = require "src.FloatText"
local Sounds = require "src.Sounds"

function love.load()

    love.window.setTitle("Retro Musashi")

    love.window.setMode(1280, 720, {resizable = true})
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1)
    love.graphics.setColor(1, 1, 1)

    player = Player(400, 300, manager)
    slime = Slime(400,300)
    green = Green(500, 600)
    floatText = FloatText("Good luck!", 200, 300)
    floatText:tween(300)
    floatText:tween(-100)

    titleFont = love.graphics.newFont("assets/fonts/Kaph-Regular.ttf",26)
end

function love.update(dt)
    if gameState == "play" then
        player:update(dt)
        slime:update(dt)
        green:update(dt)
        floatText:update(dt)
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
        Sounds["playStateMusic"]:play()
        Sounds["playStateMusic"]:setLooping(true)
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
    love.graphics.setColor(1,1,0) -- Yellow
    love.graphics.printf("Retro Musashi", titleFont,0,200,gameWidth,"center") 
    love.graphics.printf("Press Enter to Start",0,270,gameWidth,"center") 
    floatText:draw()
        
end

function drawPlayState()
    love.graphics.setColor(1,1,1) -- white
    player:draw()
    slime:draw()
    green:draw()
    floatText:draw()
    
end

function drawGameOverState()
    love.graphics.setColor(1,0,0) -- red
    love.graphics.printf("Game Over", titleFont,0,20,gameWidth,"center") 
    love.graphics.printf("Press Enter to Restart",0,100,gameWidth,"center")
    
end