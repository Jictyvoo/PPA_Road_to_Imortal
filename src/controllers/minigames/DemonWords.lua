local DemonWords = {}

DemonWords.__index = DemonWords

function DemonWords:new()    
    local this = setmetatable({
        validWords = require "models.PortugueseWords",
        elapsedTime = 0, buttons = {parentName = "demonWords"}
    }, DemonWords)
    this.buttons.parentName = nil
    return this
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
