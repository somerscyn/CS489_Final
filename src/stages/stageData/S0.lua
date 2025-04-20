local GameObject = require 'src.Objects.GameObjects'
local Rock = require 'src.Objects.Rock'
local Slime = require 'src.Objects.mobs.Slime'
return {
    background = 'assets/images/MapS1.png',
    objects = {
        Rock(580, 600, 50, 50),
        Rock(300, 200, 60, 60),
        Slime(400, 300, 50, 50),
    }
}