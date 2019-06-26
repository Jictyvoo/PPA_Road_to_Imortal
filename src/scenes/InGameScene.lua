local InGameScene = {}

InGameScene.__index = InGameScene

function InGameScene:new()    
    return setmetatable({
    }, InGameScene)
end

function InGameScene:update(dt)
    gameDirector:update(dt)
end

function InGameScene:draw()
    gameDirector:draw()
end

return InGameScene
