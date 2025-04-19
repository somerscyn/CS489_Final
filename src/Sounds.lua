local sounds = {}  -- create an empty table

sounds["positive"] = love.audio.newSource("assets/sounds/positive.wav","static")
sounds["positive"]:setVolume(0.3)
sounds["ominous"] = love.audio.newSource("assets/sounds/ominous.wav","static")
sounds["ominous"]:setVolume(0.3)
sounds["swish"] = love.audio.newSource("assets/sounds/swish.wav","static")
sounds["swish"]:setVolume(0.3)
sounds["playStateMusic"] = love.audio.newSource("assets/sounds/music1.mp3","static")
sounds["swish"]:setVolume(0.3)

return sounds