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
    end
end

local function endContact(a, b, col)
end

return {beginContact = beginContact, endContact = endContact}
