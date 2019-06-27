local PressAnyButton = {}

PressAnyButton.__index = PressAnyButton

function PressAnyButton:new()
    local this = {
        background = love.graphics.newImage("assets/textures/menu_background.png"),
        messages = {"Pressione qualquer botão", "Você tem certeza que quer jogar?", "Último Aviso"},
        current = 1, sound = love.audio.newSource("assets/sounds/button_pressed.mp3", "static"),
        width = love.graphics.getWidth() * 0.9, y = love.graphics.getHeight() * 0.8, x = love.graphics.getWidth() * 0.1,
        elapsedTime = 0
    }
    scaleDimension:calculeScales("menuBackground", this.background:getWidth(), this.background:getHeight(), 0, 0)
    
    return setmetatable(this, PressAnyButton)
end

function PressAnyButton:keypressed(key, scancode, isrepeat)
    if self.elapsedTime > 1.1 then
        self.elapsedTime = 0
        self.current = self.current + 1
        self.sound:play()
    end
    if self.current > #self.messages then
        sceneDirector:clearStack("mainMenu")
    end
end

function PressAnyButton:update(dt)
    self.elapsedTime = self.elapsedTime + dt
end

function PressAnyButton:draw()
    local message = self.messages[self.current]
    if message then
        local currentFont = love.graphics.getFont()
        local _, lines = currentFont:getWrap(message, self.width)
        local fontHeight = currentFont:getHeight()
        love.graphics.printf(message, self.x, self.y - (fontHeight / 2 * #lines), self.width, "center")
    end
end

return PressAnyButton
