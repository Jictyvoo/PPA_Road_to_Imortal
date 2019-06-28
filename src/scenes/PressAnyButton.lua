local PressAnyButton = {}

PressAnyButton.__index = PressAnyButton

function PressAnyButton:new()
    local this = {
        background = love.graphics.newImage("assets/textures/menu_background.png"),
        messages = {"Pressione qualquer botão", "Você tem certeza que quer jogar?", "Último Aviso"},
        current = 1, sound = love.audio.newSource("assets/sounds/button_pressed.mp3", "static"),
        width = love.graphics.getWidth() * 0.9, y = love.graphics.getHeight() * 0.8, x = love.graphics.getWidth() * 0.1,
        elapsedTime = 0, textbox = nil, dontPlay = love.audio.newSource("assets/sounds/dont_play_this_game.mp3", "static"),
        alreadyPlayed = false
    }
    scaleDimension:calculeScales("menuBackground", this.background:getWidth(), this.background:getHeight(), 0, 0)
    
    return setmetatable(this, PressAnyButton)
end

function PressAnyButton:deleteTextBox()
    self.textbox = nil; self.elapsedTime = 0
    sceneDirector:clearStack("mainMenu")
end

function PressAnyButton:keypressed(key, scancode, isrepeat)
    if not self.textbox then
        if self.elapsedTime > 1.1 then
            self.elapsedTime = 0
            self.current = self.current + 1
            self.sound:play()
        end
        if self.current > #self.messages then
            self.textbox = gameDirector:getLibrary("TextBox"):new({"\n\n\n\n\nOs personagens deste jogo são fictícios Todas as vozes são péssimas porque o dono das mesmas acha que falsete é o seu jeito careca de ser Esse jogo foi feito às pressas e não deve ser visto ou jogado por ninguém Corre-se risco de ter seus olhos queimados por tanta idiotice que você vai ver Fique avisado, e passe mal"}, gameDirector:getLibrary("Scribe"), self, {y = 30, h = love.graphics.getHeight() - 20})
        end
    end
end

function PressAnyButton:update(dt)
    self.elapsedTime = self.elapsedTime + dt
    if self.textbox then
        if not self.alreadyPlayed then self.dontPlay:play(); self.alreadyPlayed = true end
        self.textbox:update(dt)
        if self.elapsedTime >= 11 then
            self.textbox:changeText()
        end
    end
end

function PressAnyButton:draw()
    local message = self.messages[self.current]
    if message then
        local currentFont = love.graphics.getFont()
        local _, lines = currentFont:getWrap(message, self.width)
        local fontHeight = currentFont:getHeight()
        love.graphics.printf(message, self.x, self.y - (fontHeight / 2 * #lines), self.width, "center")
    end
    if self.textbox then self.textbox:draw() end
end

return PressAnyButton
