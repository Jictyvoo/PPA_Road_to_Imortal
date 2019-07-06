local Bullet = {}; Bullet.__index = Bullet

function Bullet:new(world, x, y, orientation, speed, image, parent, category, mask)
    local this = {
        world = world or love.physics.newWorld(0, 12),
        orientation = orientation or "right", parent = parent,
        speed = speed or 800, elapsedTime = 0, lifeTime = 1.4,
        body = nil, shape = nil, fixture = nil,
        image = image
    }
    
    --aplying physics
    this.body = love.physics.newBody(this.world, x or 0, y or 0, "kinematic")
    this.shape = love.physics.newRectangleShape(25, 64)
    this.fixture = love.physics.newFixture(this.body, this.shape, 0)
    this.fixture:setUserData({object = this, type = "Bullet"})
    this.fixture:setCategory(category or 2); this.fixture:setMask(unpack(mask))
    
    if this.orientation == "right" then
        this.updateFunction = function(dt) this.body:setLinearVelocity(this.speed, 0) end
    elseif this.orientation == "left" then
        this.updateFunction = function(dt) this.body:setLinearVelocity(-this.speed, 0) end
    elseif this.orientation == "up" then
        this.updateFunction = function(dt) this.body:setLinearVelocity(0, -this.speed) end
    elseif this.orientation == "down" then
        this.updateFunction = function(dt) this.body:setLinearVelocity(0, this.speed) end
    end
    
    return setmetatable(this, Bullet)
end

function Bullet:selfRemove()
    self.parent:removeBullet(self.fixture)
end

function Bullet:destroy()
    self.fixture:destroy(); self.shape = nil; self.body:destroy()
end

function Bullet:getFixture()
    return self.fixture
end

function Bullet:update(dt)
    self.speed = self.speed + 5
    self.updateFunction(dt)
    self.elapsedTime = self.elapsedTime + dt
    if self.elapsedTime >= self.lifeTime then
        self.parent:removeBullet(self.fixture)
    end
end

function Bullet:draw()
    if self.image then
        love.graphics.draw(self.image, self.body:getX(), self.body:getY(), 0, 1, 1, 12.5, 32)
        love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
    end
end

return Bullet
