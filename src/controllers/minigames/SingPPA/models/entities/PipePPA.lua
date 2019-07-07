local PipePPA = {}

PipePPA.__index = PipePPA

function PipePPA:new(world, spriteAnimation, Bullet, LifeForm)
    assert(spriteAnimation, "Is needed a animation for this entity")
    local this = {
        speed = 250, Bullet = Bullet, life = LifeForm:new(40),
        movement = {vertical = 0, horizontal = 1},
        world = world or love.physics.newWorld(0, 12),
        spriteAnimation = spriteAnimation, elapsedTime = 0, bullets = {},
        bulletsTime = 0, bulletImage = love.graphics.newImage("assets/sprites/singPPA/enemy_rocket.png")
    }
    
    --aplying physics
    this.body = love.physics.newBody(this.world, 400, 200, "dynamic")
    this.shape = love.physics.newRectangleShape(168, 202)
    this.fixture = love.physics.newFixture(this.body, this.shape, 1)
    this.body:setFixedRotation(false); this.fixture:setUserData({object = this, type = "PipePPA"})
    this.fixture:setCategory(3); this.fixture:setMask(2, 3)
    
    return setmetatable(this, PipePPA)
end

function PipePPA:removeBullet(fixture)
    if self.bullets[fixture] then self.bullets[fixture]:destroy(); self.bullets[fixture] = nil end
end

function PipePPA:getPosition()
    return self.body:getX(), self.body:getY()
end

function PipePPA:setPosition(x, y)
    self.body:setX(x); self.body:setY(y)
end

function PipePPA:stopMoving() --will slide now
    --local xVelocity, yVelocity = self.body:getLinearVelocity()
    self.body:setLinearVelocity(0, 0)
end

function PipePPA:getDamage() self.life:takeDamage(1) end

function PipePPA:isDead() return not self.life:isAlive() end

function PipePPA:reset()
    self.body:setLinearVelocity(0, 0)
    self.body:setX(340); self.body:setY(200)
    self.movement = {vertical = 0, horizontal = 1}; self.life:restoreLife()
end

function PipePPA:compareFixture(fixture)
    return self.fixture == fixture
end

function PipePPA:update(dt)
    self.elapsedTime = self.elapsedTime + dt; self.bulletsTime = self.bulletsTime + dt
    if self.elapsedTime >= 2.3 then
        self.elapsedTime = 0
        self.movement.horizontal = self.movement.horizontal * -1
    end
    if self.bulletsTime >= 0.84 then
        self.bulletsTime = 0
        local temporaryBullet = self.Bullet:new(self.world, self.body:getX(), self.body:getY() + 10, "down", 600, self.bulletImage, self, 4, {3})
        self.bullets[temporaryBullet:getFixture()] = temporaryBullet
    end
    self.spriteAnimation:update(dt)
    self.body:setLinearVelocity(self.speed * self.movement.horizontal, self.speed * self.movement.vertical)
    --[[ After some time shoot into player --]]
    for fixture, bullet in pairs(self.bullets) do
        bullet:update(dt)
    end
end

function PipePPA:draw()
    self.spriteAnimation:draw(self.body:getX(), self.body:getY(), 1, 1, 84, 113, self.body:getAngle())
    --love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
    for fixture, bullet in pairs(self.bullets) do
        bullet:draw()
    end
end

return PipePPA
