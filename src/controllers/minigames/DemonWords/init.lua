local currentPath   = (...):gsub('%.init$', '') .. "."

local DemonWords = {}; DemonWords.__index = DemonWords

function DemonWords:new()    
    local this = setmetatable({
        background = love.graphics.newImage("assets/textures/demonWords_background.png"),
        validWords = require "models.PortugueseWords", rng = love.math.newRandomGenerator(os.time()),
        elapsedTime = 0, buttons = {parentName = "demonWords"}, timesShuffled = 0,
        buttons = {parentName = "demonWords"}, currentWord = "", wordsFinded = {},
        timeRemainning = gameDirector:getLibrary("ProgressBar"):new(50, 300, 400, 20, {0.58, 0.75, 0.98}, 16, 16),
        thread = love.thread.newThread(string.format("%sFindWordsThread", currentPath):gsub("%.", "/") .. ".lua")
    }, DemonWords)

    local buttonImage = love.graphics.newImage("assets/sprites/tinkerMacro/button.png")
    this.buttonsQuads = {normal = buttonImage, hover = buttonImage, pressed = buttonImage, disabled = buttonImage}
    local originalSize = {width = buttonImage:getWidth(), height = buttonImage:getHeight()}
    local x = 90; local y = 200
    for letter in string.gmatch("123456789", ".") do
        gameDirector:addButton(this, this.buttons, letter, true, "", {40, 40, x, y}, originalSize, 
        function(self) self:disableButton(); this:appendLetter(self:getName()) end, true)
        x = x + 50
        if x >= 700 then x = 280; y = y + 50 end
    end

    gameDirector:addButton(this, this.buttons, "Verificar", true, "", {241, 62, 546, 522}, originalSize, function(self) this:verifyWord() end, true)
    this.buttons.parentName = nil
    this:shuffleNewLetters()
    return this
end

function DemonWords:shuffleNewLetters()
    local vowels = {"a", "e", "i", "o", "u"}
    self.letters = {
        vowels[self.rng:random(#vowels)], vowels[self.rng:random(#vowels)], vowels[self.rng:random(#vowels)],
        string.char(self.rng:random(97, 122)), string.char(self.rng:random(97, 122)), string.char(self.rng:random(97, 122)),
        vowels[self.rng:random(#vowels)], string.char(self.rng:random(97, 122)), vowels[self.rng:random(#vowels)]
    }
    self.thread:start(string.format("%s%s%s%s%s%s%s%s%s", unpack(self.letters)):lower(), currentPath); local count = 1
    for _, button in pairs(self.buttons) do
        button:setName(self.letters[count]); count = count + 1
    end
    self.timesShuffled = self.timesShuffled + 1; self.timeRemainning:fill()
    if self.timesShuffled > 3 then sceneDirector:previousScene() end
end

function DemonWords:appendLetter(letter)
    if #self.currentWord < 6 then
        self.currentWord = self.currentWord .. letter
    end
end

function DemonWords:verifyWord()
    if self.validWords[self.currentWord] then table.insert(self.wordsFinded, self.currentWord) end
    for _, button in pairs(self.buttons) do button:enableButton() end
end

function DemonWords:keypressed(key, scancode, isrepeat)
end

function DemonWords:mousepressed(x, y, button)
    for _, button in pairs(self.buttons) do button:mousepressed(x, y, button) end
end

function DemonWords:mousereleased(x, y, button)
    for _, button in pairs(self.buttons) do button:mousereleased(x, y, button) end
end

function DemonWords:update(dt)
    self.elapsedTime = self.elapsedTime + dt; self.timeRemainning:decrement(dt)
    local computerWord = love.thread.getChannel('findWords'):pop()
    if self.timeRemainning:getValue() <= 0 and not self.thread:isRunning() then
        self:shuffleNewLetters()
    end
end

function DemonWords:draw()
    love.graphics.draw(self.background, 0, 0, r, sx, sy, ox, oy)
    self.timeRemainning:draw()
    for _, button in pairs(self.buttons) do
        button:draw()
    end
end

return DemonWords
