local LifeForm = {}; LifeForm.__index = LifeForm

function LifeForm:new(total)
    return setmetatable({
        totalLife = total,
        currentLife = total
    }, LifeForm)
end

function LifeForm:takeDamage(amount)
    self.currentLife = self.currentLife - amount
    return self.currentLife <= 0
end

function LifeForm:restoreLife() self.currentLife = self.totalLife end

function LifeForm:isAlive() return self.currentLife > 0 end

return LifeForm
