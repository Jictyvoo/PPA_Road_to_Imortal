local GameOver = {}; GameOver.__index = GameOver

function GameOver:new()
    local this = setmetatable({
        width = 600, x = 100, y = 300, elapsedTime = 0, waitTime = 0
    }, GameOver)
    return this
end

function GameOver:keypressed(key, scancode, isrepeat)
    sceneDirector:exitSubscene()
end

function GameOver:mousepressed(x, y, button)
    sceneDirector:exitSubscene()
end

function GameOver:draw()
    local message = "Game Over\nPressione qualquer tecla para se lascar de novo"
    local currentFont = love.graphics.getFont()
    local _, lines = currentFont:getWrap(message, self.width)
    local fontHeight = currentFont:getHeight()
    love.graphics.printf(message, self.x, self.y - (fontHeight / 2 * #lines), self.width, "center")
end

return GameOver
