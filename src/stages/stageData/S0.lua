local GameObject = require 'src.Objects.GameObjects'
local Rock = require 'src.Objects.Rock'
return {
    background = 'assets/images/MapS0.png',
    objects = {
        Rock(100, 100, 50, 50),
        Rock(300, 200, 60, 60),
    }
}