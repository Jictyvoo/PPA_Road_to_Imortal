local PressAnyButton = {}

PressAnyButton.__index = PressAnyButton

function PressAnyButton:new()
    local this = {
        background = love.graphics.newImage("assets/textures/menu_background.png"),
        messages = {"Pressione qualquer botão", "Você tem certeza que quer jogar?", "Último Aviso"},
        current = 1,
        elapsedTime = 0
    }
    
    scaleDimension:calculeScales("menuBackground", this.background:getWidth(), this.background:getHeight(), 0, 0)
    
    return setmetatable(this, PressAnyButton)
end

function PressAnyButton:keypressed(key, scancode, isrepeat)
    self.current = self.current + 1
    if self.current > #self.messages then
        sceneDirector:clearStack("mainMenu")
    end
end

function PressAnyButton:update(dt)
    self.elapsedTime = self.elapsedTime + dt
    if self.elapsedTime > 2 then
        self.current = self.current + 1
        self.elapsedTime = 0
    end
end

function PressAnyButton:draw()
    local message = self.messages[self.current]
    if message then
        local scales = scaleDimension:getScale(item)
        love.graphics.print(self[message],x,love.graphics.getHeight() * 0.8,r,sx,sy,ox,oy)
    end
end

return PressAnyButton
