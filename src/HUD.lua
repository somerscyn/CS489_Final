local Player = require 'src.Objects.Player'
local Class = require 'libs.hump.class'

local HUD = Class{}
function HUD:init(player)
    self.player = player
    self.hearts = player.health/2
    self.damage = player.attack

    self.x = 20
    self.y = 20

    self.font = love.graphics.newFont(12)

end

function HUD:draw()
    love.graphics.setFont(self.font)
    love.graphics.setColor(1, 1, 1, 1) -- white
    love.graphics.print("Health: " .. self.hearts, self.x, self.y)
    love.graphics.print("Damage: " .. self.damage, self.x, self.y + 20)

    -- Draw hearts
  --  for i = 1, self.hearts do
    --    love.graphics.draw(heartImage, self.x + (i - 1) * 20, self.y + 40)
    --end

end


function HUD:update(dt)
    self.hearts = self.player.health/2
end
return HUD