local Player = {}

Player.__index = Player

function Player:new(spriteAnimation, world)
    assert(spriteAnimation, "Is needed a animation for this actor")
    local this = {
        move = false,
        inGround = false,
        speed = 250,
        jumpForce = -200,
        orientation = "right",
        animation = "idle",
        previousAnimation = "idle",
        looking = nil,
        world = world or love.physics.newWorld(0, 12),
        spriteAnimation = spriteAnimation,
        controlKeys = {
            left = "left", right = "right", up = "up", down = "down",
            a = "left", d = "right", w = "up", s = "down"
        }
    }
    
    --aplying physics
    this.body = love.physics.newBody(this.world, 0, 0, "dynamic")
    this.shape = love.physics.newCircleShape(26)
    this.fixture = love.physics.newFixture(this.body, this.shape, 1)
    this.body:setFixedRotation(true)
    this.fixture:setUserData("Player")
    this.fixture:setCategory(1)
    this.fixture:setMask(2, 3)
    this.fixture:setFriction(0)
    
    return setmetatable(this, Player)
end

function Player:keypressed(key, scancode, isrepeat)

end

function Player:keyreleased(key, scancode)

end

function Player:getPosition()
    return self.body:getX(), self.body:getY()
end

function Player:setPosition(x, y)
    self.body:setX(x); self.body:setY(y)
end

function Player:stopMoving()
    local xVelocity, yVelocity = self.body:getLinearVelocity()
    self.body:setLinearVelocity(0, yVelocity)
end

function Player:configureKeys(action, key)
    if self.controlKeys[action] then self.controlKeys[action] = key end
end

function Player:reset()
    self.move = false
    self.inGround = true
    self.looking = nil
    self.body:setLinearVelocity(0, 0)
    self.body:setX(900); self.body:setY(900)
    self.orientation = "right"
    self.animation = "idle"
    self.previousAnimation = "idle"
end

function Player:touchGround(isTouching)

end

function Player:getOrientation()
    return self.orientation
end

function Player:compareFixture(fixture)
    return self.fixture == fixture
end

function Player:update(dt)

end

function Player:draw()

end

return Player
