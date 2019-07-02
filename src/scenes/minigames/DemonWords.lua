local DemonWords = {}

DemonWords.__index = DemonWords

function DemonWords:new()    
    local this = setmetatable({
        tinkerAnimation = gameDirector:getLibrary("Pixelurite").configureSpriteSheet("tinker_side", "assets/sprites/", true, nil, 1, 1, true),
        thisIsHowILike = love.audio.newSource("assets/sounds/assim_que_eu_gosto.mp3", "static"),
        elapsedTime = 0,
        buttons = {parentName = "inGame"}
    }, DemonWords)
    this.buttons.parentName = nil
    return this
end

function DemonWords:deleteTextBox()
    self.textbox = nil; self.elapsedTime = 0
end

function DemonWords:keypressed(key, scancode, isrepeat)
end

function DemonWords:mousepressed(x, y, button)
end

function DemonWords:mousereleased(x, y, button)
end

function DemonWords:update(dt)
    self.elapsedTime = self.elapsedTime + dt
end

function DemonWords:draw()
end

return DemonWords
