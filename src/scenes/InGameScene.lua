local InGameScene = {}

InGameScene.__index = InGameScene

function InGameScene:new()    
    this = setmetatable({
        textbox = nil
    }, InGameScene)
    this.textbox = gameDirector:getLibrary("TextBox"):new(require "models.TextScript":get(), gameDirector:getLibrary("Scribe"), this)
    return this
end

function InGameScene:keypressed(key, scancode, isrepeat)
    self.textbox:keypressed(key, scancode, isrepeat)
end

function InGameScene:mousepressed(x, y, button)
    self.textbox:mousepressed(x, y, button)
end

function InGameScene:update(dt)
    self.textbox:update(dt)
end

function InGameScene:draw()
    self.textbox:draw()
end

return InGameScene
