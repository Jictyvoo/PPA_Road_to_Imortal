local Player = {}

Player.__index = Player

function Player:new(spriteAnimation, world, Bullet, LifeForm)
    assert(spriteAnimation, "Is needed a animation for this entity")
    local this = {
        speed = 250, Bullet = Bullet, life = LifeForm:new(5),
        movement = {vertical = 0, horizontal = 0}, clicked = {vertical = "", horizontal = ""},
        world = world or love.physics.newWorld(0, 12),
        spriteAnimation = spriteAnimation, bullets = {},
        controlKeys = {
            left = "left", right = "right", up = "up", down = "down",
            a = "left", d = "right", w = "up", s = "down"
        }, bulletImage = love.graphics.newImage("assets/sprites/singPPA/player_rocket.png")
    }
    
    --aplying physics
    this.body = love.physics.newBody(this.world, 400, 500, "dynamic")
    this.shape = love.physics.newCircleShape(64)
    this.fixture = love.physics.newFixture(this.body, this.shape, 1)
    this.body:setFixedRotation(true)
    this.fixture:setUserData({object = this, type = "Player"})
    this.fixture:setCategory(2); this.fixture:setMask(2, 3)
    
    return setmetatable(this, Player)
end

function Player:removeBullet(fixture)
    if self.bullets[fixture] then self.bullets[fixture]:destroy(); self.bullets[fixture] = nil end
end

function Player:keypressed(key, scancode, isrepeat)
    if self.controlKeys[key] then
        if self.controlKeys[key] == "left" then self.movement.horizontal = -1; self.clicked.horizontal = "left"
        elseif self.controlKeys[key] == "right" then self.movement.horizontal = 1; self.clicked.horizontal = "right"
        elseif self.controlKeys[key] == "up" then self.movement.vertical = -1; self.clicked.vertical = "up"
        elseif self.controlKeys[key] == "down" then self.movement.vertical = 1; self.clicked.vertical = "down"
        end
    elseif key == "space" then
        local temporaryBullet = self.Bullet:new(self.world, self.body:getX(), self.body:getY() + 10, "up", 600, self.bulletImage, self, 4, {2})
        self.bullets[temporaryBullet:getFixture()] = temporaryBullet
    end
end

function Player:keyreleased(key, scancode)
    if self.controlKeys[key] then
        if self.controlKeys[key] == "left" and self.clicked.horizontal == "left" then self.movement.horizontal = 0
        elseif self.controlKeys[key] == "right" and self.clicked.horizontal == "right" then self.movement.horizontal = 0
        elseif self.controlKeys[key] == "up" and self.clicked.vertical == "up" then self.movement.vertical = 0
        elseif self.controlKeys[key] == "down" and self.clicked.vertical == "down" then self.movement.vertical = 0
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

function Player:takeDamage() self.life:takeDamage(1) end

function Player:isAlive() return self.life:isAlive() end

function Player:configureKeys(action, key)
    if self.controlKeys[action] then self.controlKeys[action] = key end
end

function Player:reset()
    self.body:setLinearVelocity(0, 0); self.body:setX(400); self.body:setY(500)
    self.movement = {vertical = 0, horizontal = 0}; self.life:restoreLife()
end

function Player:compareFixture(fixture)
    return self.fixture == fixture
end

function Player:update(dt)
    self.spriteAnimation:update(dt)
    self.body:setLinearVelocity(self.speed * self.movement.horizontal, self.speed * self.movement.vertical)
    for fixture, bullet in pairs(self.bullets) do
        bullet:update(dt)
    end
end

function Player:draw()
    self.spriteAnimation:draw(self.body:getX(), self.body:getY(), 0.5, 0.5)
    for fixture, bullet in pairs(self.bullets) do
        bullet:draw()
    end
    --love.graphics.circle("line", self.body:getX(), self.body:getY(), 64)
end

return Player
