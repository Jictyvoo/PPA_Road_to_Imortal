local FinalLevel = {}; FinalLevel.__index = FinalLevel

function FinalLevel:new()
    local this = setmetatable({
        
    }, FinalLevel)
    return this
end

return FinalLevel
