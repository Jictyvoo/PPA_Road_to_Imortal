local Player = {}

Player.__index = Player

function Player:new(spriteAnimation, world)
    assert(spriteAnimation, "Is needed a animation for this entity")
    local this = {
        speed = 250,
        movement = {vertical = 0, horizontal = 0},
        world = world or love.physics.newWorld(0, 12),
        spriteAnimation = spriteAnimation,
        controlKeys = {
            left = "left", right = "right", up = "up", down = "down",
            a = "left", d = "right", w = "up", s = "down"
        }
    }
    
    --aplying physics
    this.body = love.physics.newBody(this.world, 400, 500, "dynamic")
    this.shape = love.physics.newCircleShape(64)
    this.fixture = love.physics.newFixture(this.body, this.shape, 1)
    this.body:setFixedRotation(true)
    this.fixture:setUserData("Player")
    this.fixture:setCategory(1)
    this.fixture:setMask(2, 3)
    this.fixture:setFriction(0)
    
    return setmetatable(this, Player)
end

function Player:keypressed(key, scancode, isrepeat)
    if self.controlKeys[key] then
        if self.controlKeys[key] == "left" then self.movement.horizontal = -1
        elseif self.controlKeys[key] == "right" then self.movement.horizontal = 1
        elseif self.controlKeys[key] == "up" then self.movement.vertical = -1
        elseif self.controlKeys[key] == "down" then self.movement.vertical = 1
        end
    end
end

function Player:keyreleased(key, scancode)
    if self.controlKeys[key] then
        if self.controlKeys[key] == "left" then self.movement.horizontal = 0
        elseif self.controlKeys[key] == "right" then self.movement.horizontal = 0
        elseif self.controlKeys[key] == "up" then self.movement.vertical = 0
        elseif self.controlKeys[key] == "down" then self.movement.vertical = 0
        end
    end
end

function Player:getPosition()
    return self.body:getX(), self.body:getY()
end

function Player:setPosition(x, y)
    self.body:setX(x); self.body:setY(y)
end

function Player:stopMoving() --will slide now
    local xVelocity, yVelocity = self.body:getLinearVelocity()
    self.body:setLinearVelocity(0, yVelocity)
end

function Player:configureKeys(action, key)
    if self.controlKeys[action] then self.controlKeys[action] = key end
end

function Player:reset()
    self.body:setLinearVelocity(0, 0)
    self.body:setX(900); self.body:setY(900)
    self.movement = {vertical = 0, horizontal = 0}
end

function Player:compareFixture(fixture)
    return self.fixture == fixture
end

function Player:update(dt)
    self.spriteAnimation:update(dt)
    self.body:setLinearVelocity(self.speed * self.movement.horizontal, self.speed * self.movement.vertical)
end

function Player:draw()
    self.spriteAnimation:draw(self.body:getX(), self.body:getY(), 0.5, 0.5)
    --love.graphics.circle("line", self.body:getX(), self.body:getY(), 64)
end

return Player
