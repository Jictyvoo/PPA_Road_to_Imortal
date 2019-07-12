local ChatGado = {}

ChatGado.__index = ChatGado

function ChatGado:new()    
    local this = setmetatable({
        thisIsHowILike = love.audio.newSource("assets/sounds/assim_que_eu_gosto.mp3", "static"),
        elapsedTime = 0, background = love.graphics.newImage("assets/textures/chat_gado.png"),
        buttons = {parentName = "inGame"}
    }, ChatGado)
    this.buttons.parentName = nil
    return this
end

function ChatGado:deleteTextBox()
    self.textbox = nil; self.elapsedTime = 0
end

function ChatGado:keypressed(key, scancode, isrepeat)
end

function ChatGado:mousepressed(x, y, button)
end

function ChatGado:mousereleased(x, y, button)
end

function ChatGado:update(dt)
    self.elapsedTime = self.elapsedTime + dt
end

function ChatGado:draw()
    love.graphics.draw(self.background, 0, 0, r, sx, sy, ox, oy)
end

return ChatGado
