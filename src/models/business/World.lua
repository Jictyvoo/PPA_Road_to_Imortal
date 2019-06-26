local World ={}

World.__index = World

function World:new()
    return setmetatable({
        world = love.physics.newWorld(0, 12, sleep)
    }, World)
end

function World:getWorld()
    return self.world
end

function World:setGravity(x, y)
    self.world:setGravity(x, y)
end

function World:update(dt)
    self.world:update(dt)
end

return World
