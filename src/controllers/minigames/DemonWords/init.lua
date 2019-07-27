local currentPath   = (...):gsub('%.init$', '') .. "."
local Label = require "util.Label"

local DemonWords = {}; DemonWords.__index = DemonWords

function DemonWords:new()    
    local this = setmetatable({
        background = love.graphics.newImage("assets/textures/demonWords_background.png"),
        distractionPPA = gameDirector:getLibrary("Pixelurite").configureSpriteSheet("distractionPPA", "assets/sprites/demonWords/", true, nil, 1, 1, true),
        validWords = require "models.PortugueseWords", rng = love.math.newRandomGenerator(os.time()),
        elapsedTime = 0, buttons = {parentName = "demonWords"}, timesShuffled = 0,
        computerSound = love.audio.newSource("assets/sounds/tictacpc.mp3", "static"),
        buttons = {parentName = "demonWords"}, currentWord = "", wordsFinded = {}, allWords = Label:new(25, 410, 490, 160, "", nil, nil),
        currentWordLabel = Label:new(574, 430, 180, 90, "", nil, nil),
        timeRemainning = gameDirector:getLibrary("ProgressBar"):new(50, 300, 400, 20, {0.58, 0.75, 0.98}, 16, 16),
        thread = love.thread.newThread(string.format("%sFindWordsThread", currentPath):gsub("%.", "/") .. ".lua")
    }, DemonWords)

    local spriteSheet = gameDirector:getLibrary("Pixelurite").getSpritesheet():new("letterButton", "assets/sprites/demonWords/", nil)
    local spriteQuads = spriteSheet:getQuads(); this.buttonsImage = spriteSheet:getAtlas()
    this.buttonsQuads = {
        normal = spriteQuads["normal"], hover = spriteQuads["hover"], pressed = spriteQuads["pressed"], disabled = spriteQuads["disabled"]
    }
    local x, y, width, height = this.buttonsQuads["normal"]:getViewport()
    local originalSize = {width = width, height = height}
    x = 100; y = 200
    for letter in string.gmatch("123456789", ".") do
        gameDirector:addButton(this, this.buttons, letter, true, "", {40, 40, x, y}, originalSize, 
        function(self) self:disableButton(); this:appendLetter(self:getName()) end, true)
        x = x + 60; if x >= 460 then x = 190; y = y - 60 end
    end

    gameDirector:addButton(this, this.buttons, "Verificar", true, "", {241, 62, 546, 522}, originalSize, function(self) this:verifyWord() end, true)
    this.buttons.parentName = nil
    this:shuffleNewLetters()
    return this
end

function DemonWords:isLost()
    local computer, player = 0, 0
    for _, value in pairs(self.wordsFinded) do
        if value == "player" then player = player + 1 else computer = computer + 1 end
    end
    return computer > player + 12
end

function DemonWords:shuffleNewLetters()
    local vowels = {"a", "e", "i", "o", "u"}
    self.letters = {
        vowels[self.rng:random(#vowels)], vowels[self.rng:random(#vowels)], vowels[self.rng:random(#vowels)],
        string.char(self.rng:random(97, 122)), string.char(self.rng:random(97, 122)), string.char(self.rng:random(97, 122)),
        vowels[self.rng:random(#vowels)], string.char(self.rng:random(97, 122)), vowels[self.rng:random(#vowels)]
    }
    --[[ Removing all founded words from channel --]]
    while love.thread.getChannel('findWords'):pop() do end
    self.thread:start(string.format("%s%s%s%s%s%s%s%s%s", unpack(self.letters)):lower(), currentPath); local count = 1
    for _, button in pairs(self.buttons) do
        button:setName(self.letters[count]); button:enableButton(); count = count + 1
    end
    self.currentWord = ""; self.currentWordLabel:setText(self.currentWord)
    self.timesShuffled = self.timesShuffled + 1; self.timeRemainning:fill()
    if self.timesShuffled > 5 then
        if self:isLost() then sceneDirector:switchSubscene("gameOver"); self:reset()
        else sceneDirector:previousScene()
        end
    end
end

function DemonWords:reset()
    self.timesShuffled =  0; self.elapsedTime = 0; self.wordsFinded = {}
    self.currentWord = ""; self.currentWordLabel:setText(""); self.allWords:setText("")
end

function DemonWords:appendLetter(letter)
    if #self.currentWord < 6 then
        self.currentWord = self.currentWord .. letter
        self.currentWordLabel:setText(self.currentWord)
    end
end

function DemonWords:verifyWord()
    if self.validWords[self.currentWord] and not self.wordsFinded[self.currentWord] then self.wordsFinded[self.currentWord] = "player"; self.allWords:addText(self.currentWord .. "     ") end
    self.currentWord = ""; self.currentWordLabel:setText(self.currentWord)
    for _, button in pairs(self.buttons) do button:enableButton() end
end

function DemonWords:keypressed(key, scancode, isrepeat)
    for _, button in pairs(self.buttons) do if button:getName() == key and button:isEnabled() then button:executeCallback(); break end end
    if key == "return" then self:verifyWord() end
end

function DemonWords:mousemoved(x, y, dx, dy, istouch)
    for _, button in pairs(self.buttons) do button:mousemoved(x, y, dx, dy, istouch) end
end

function DemonWords:mousepressed(x, y, button)
    for _, button in pairs(self.buttons) do button:mousepressed(x, y, button) end
end

function DemonWords:mousereleased(x, y, button)
    for _, button in pairs(self.buttons) do button:mousereleased(x, y, button) end
end

function DemonWords:update(dt)
    self.elapsedTime = self.elapsedTime + dt; self.timeRemainning:decrement(dt)
    if self.elapsedTime >= 5 then
        local computerFind = nil; self.elapsedTime = 0
        repeat
            local computerFind = love.thread.getChannel('findWords'):pop()
            if computerFind then
                if not self.wordsFinded[computerFind] then
                    self.wordsFinded[computerFind] = "computer"; self.allWords:addText(computerFind .. "     ")
                    computerFind = nil; self.computerSound:play()
                end
            end
        until not computerFind
    end
    if self.timeRemainning:getValue() <= 0 and not self.thread:isRunning() then
        self:shuffleNewLetters()
    end
    self.distractionPPA:update(dt)
end

function DemonWords:draw()
    love.graphics.draw(self.background, 0, 0, r, sx, sy, ox, oy)
    self.distractionPPA:draw(670, 220, 0.7, 0.7)
    self.timeRemainning:draw()
    for _, button in pairs(self.buttons) do button:draw() end

    --Drawning current word
    self.currentWordLabel:draw(); self.allWords:draw()
end

return DemonWords
