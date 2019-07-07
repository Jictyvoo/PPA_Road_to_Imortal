local currentPath   = (...):gsub('%.init$', '') .. "."

local DemonWords = {}; DemonWords.__index = DemonWords

function DemonWords:new()    
    local this = setmetatable({
        validWords = require "models.PortugueseWords", rng = love.math.newRandomGenerator(os.time()),
        elapsedTime = 0, buttons = {parentName = "demonWords"},
        thread = love.thread.newThread(string.format("%sFindWordsThread", currentPath):gsub("%.", "/") .. ".lua")
    }, DemonWords)
    local vowels = {"a", "e", "i", "o", "u"}
    this.thread:start(string.format("%s%s%s%s%s%s",
        vowels[this.rng:random(#vowels)], vowels[this.rng:random(#vowels)], vowels[this.rng:random(#vowels)],
        string.char(this.rng:random(97, 122)), string.char(this.rng:random(97, 122)), string.char(this.rng:random(97, 122))
    ):lower())
    this.buttons.parentName = nil
    return this
end

function DemonWords:keypressed(key, scancode, isrepeat)
end

function DemonWords:mousepressed(x, y, button)
end

function DemonWords:mousereleased(x, y, button)
end

function DemonWords:update(dt)
    self.elapsedTime = self.elapsedTime + dt
    local computerWord = love.thread.getChannel('findWords'):pop()
end

function DemonWords:draw()
end

return DemonWords
