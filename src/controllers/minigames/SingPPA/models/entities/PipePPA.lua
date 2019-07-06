local PipePPA = {}

PipePPA.__index = PipePPA

function PipePPA:new(world, spriteAnimation, pipeImages, Bullet)
    assert(spriteAnimation, "Is needed a animation for this entity")
    local this = {
        speed = 250, Bullet = Bullet,
        movement = {vertical = 0, horizontal = 0},
        world = world or love.physics.newWorld(0, 12),
        spriteAnimation = spriteAnimation, pipe = pipeImages
    }
    
    --aplying physics
    this.body = love.physics.newBody(this.world, 400, 200, "dynamic")
    this.shape = love.physics.newRectangleShape(168, 202)
    this.fixture = love.physics.newFixture(this.body, this.shape, 1)
    this.body:setFixedRotation(false); this.fixture:setUserData({object = this, type = "PipePPA"})
    this.fixture:setCategory(3); this.fixture:setMask(2, 3)
    
    return setmetatable(this, PipePPA)
end

function PipePPA:getPosition()
    return self.body:getX(), self.body:getY()
end

function PipePPA:setPosition(x, y)
    self.body:setX(x); self.body:setY(y)
end

function PipePPA:stopMoving() --will slide now
    local xVelocity, yVelocity = self.body:getLinearVelocity()
    self.body:setLinearVelocity(0, yVelocity)
end

function PipePPA:reset()
    self.body:setLinearVelocity(0, 0)
    self.body:setX(340); self.body:setY(100)
    self.movement = {vertical = 0, horizontal = 0}
end

function PipePPA:compareFixture(fixture)
    return self.fixture == fixture
end

function PipePPA:update(dt)
    self.spriteAnimation:update(dt)
    self.body:setLinearVelocity(self.speed * self.movement.horizontal, self.speed * self.movement.vertical)
    --[[ After some time shoot into player --]]
end

function PipePPA:draw()
    love.graphics.draw(self.pipe.back, self.body:getX() - 84, self.body:getY() - 101, r, 2, 2, ox, oy)
    self.spriteAnimation:draw(self.body:getX() - 4, self.body:getY() - 81, 1, 1)
    love.graphics.draw(self.pipe.front, self.body:getX() - 84, self.body:getY() - 101, r, 2, 2, ox, oy)
    love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
end

return PipePPA
