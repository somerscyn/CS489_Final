local sounds = {}  -- create an empty table

sounds["positive"] = love.audio.newSource("sounds/positive.wav","static")
sounds["positive"]:setVolume(0.3)
sounds["ominous"] = love.audio.newSource("sounds/ominous.wav","static")
sounds["ominous"]:setVolume(0.3)
sounds["swish"] = love.audio.newSource("sounds/swish.wav","static")
sounds["swish"]:setVolume(0.3)

return sounds