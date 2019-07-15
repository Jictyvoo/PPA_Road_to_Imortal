local GameOver = {}; GameOver.__index = GameOver

function GameOver:new()
    local this = setmetatable({
        width = 600, x = 100, y = 300, elapsedTime = 0
    }, GameOver)
    return this
end

function GameOver:keypressed(key, scancode, isrepeat)
    if self.elapsedTime >= 2.4 then sceneDirector:exitSubscene(); self.elapsedTime = 0 end
end

function GameOver:mousepressed(x, y, button)
    if self.elapsedTime >= 2.4 then sceneDirector:exitSubscene(); self.elapsedTime = 0 end
end

function GameOver:update(dt)
    self.elapsedTime = self.elapsedTime + dt
end

function GameOver:draw()
    local message = "Game Over\nPressione qualquer tecla para se lascar de novo"
    local currentFont = love.graphics.getFont()
    local _, lines = currentFont:getWrap(message, self.width)
    local fontHeight = currentFont:getHeight()
    love.graphics.printf(message, self.x, self.y - (fontHeight / 2 * #lines), self.width, "center")
end

return GameOver
