local World ={}

World.__index = World

local function beginContact(a, b, col)
end

local function endContact(a, b, col)
end

function World:new()
    local world = love.physics.newWorld(0, 12, sleep)
    world:setCallbacks(beginContact, endContact)
    return setmetatable({
        callbacks = {},
        world = world
    }, World)
end

function World:addCallback(identity, callback, type)
    if not self.callbacks[identity] then self.callbacks[identity] = {beginContact = nil, endContact = nil} end
    self.callbacks[identity][type] = callback
end

function World:changeCallbacks(identity)
    if self.callbacks[identity] then
        self.world:setCallbacks(self.callbacks[identity].beginContact, self.callbacks[identity].endContact)
    end
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
