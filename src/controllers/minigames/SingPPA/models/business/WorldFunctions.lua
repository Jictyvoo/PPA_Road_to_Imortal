local function verifyUserData(a, b, firstType, secondType)
    if a:getUserData().type == firstType and b:getUserData().type == secondType then
        return a, b
    elseif b:getUserData().type == firstType and a:getUserData().type == secondType then
        return b, a
    else
        return false, false
    end
end

local function beginContact(a, b, col)
    local bullet, pipePPA = verifyUserData(a, b, "Bullet", "PipePPA")
    if bullet and pipePPA then
        bullet:getUserData().object:selfRemove(); pipePPA:getUserData().object:stopMoving()
    else
        local player = nil
        bullet, player = verifyUserData(a, b, "Bullet", "Player")
        if bullet and player then
            bullet:getUserData().object:selfRemove(); player:getUserData().object:takeDamage()
            player:getUserData().object:stopMoving()
        end
    end
end

local function endContact(a, b, col)
    local bullet, pipePPA = verifyUserData(a, b, "Bullet", "PipePPA")
    if bullet and pipePPA then
        pipePPA:getUserData().object:getDamage()
    end
end

local function constructWall(world, Wall)
    Wall:new(world, 400, 0, {w = 800, h = 2}, image, rotation)
    Wall:new(world, 0, 300, {w = 2, h = 600}, image, rotation)
    Wall:new(world, 400, 600, {w = 800, h = 2}, image, rotation)
    Wall:new(world, 800, 300, {w = 2, h = 600}, image, rotation)
end

return {beginContact = beginContact, endContact = endContact, constructWall = constructWall}
