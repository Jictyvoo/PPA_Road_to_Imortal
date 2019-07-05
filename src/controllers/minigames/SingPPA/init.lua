local currentPath   = (...):gsub('%.init$', '') .. "."
--Actors
local Player = require(string.format("%smodels.entities.Player", currentPath))

local SingPPA = {}; SingPPA.__index = SingPPA

local function genOrderedIndex(tableToOrder)
    local orderedIndex = {}
    for key in pairs(tableToOrder) do
        table.insert(orderedIndex, key)
    end
    table.sort(orderedIndex)
    return orderedIndex
end

local states = {
    {
        update = function(self, dt)
            if self.totalPipesClicked >= 12 then
                self.currentState = self.allStates[2]
            end
            self.singPPA:update(dt)
        end, draw = function(self)
            love.graphics.draw(self.background, 0, 0)
            local x, y, totalCount = 40, 40, 1
            for count = 1, 4 do
                for index = 1, 7 do
                    love.graphics.draw(self.pipe.back, x, y, r, sx, sy, ox, oy)
                    if self.randomized == totalCount then
                        self.singPPA:draw(x + 40, y + 20, 0.5, 0.5)
                    end
                    love.graphics.draw(self.pipe.front, x, y, r, sx, sy, ox, oy)
                    x = x + 105; totalCount = totalCount + 1
                end
                x = 40; y = y + 140
            end
        end, keypressed = function(self, key, scancode, isrepeat)
        end, keyreleased = function(self, key, scancode)
        end
    }, {
        update = function(self, dt)
            gameDirector:update(dt)
            self.singPPA:update(dt); self.player:update(dt)
        end, draw = function(self)
            love.graphics.draw(self.background, 0, 0)
            love.graphics.draw(self.pipe.back, 400, 300, r, 2, 2, ox, oy)
            self.singPPA:draw(480, 320, 1, 1)
            love.graphics.draw(self.pipe.front, 400, 300, r, 2, 2, ox, oy)
            self.player:draw()
        end, keypressed = function(self, key, scancode, isrepeat)
            self.player:keypressed(key, scancode, isrepeat)
        end, keyreleased = function(self, key, scancode)
            self.player:keyreleased(key, scancode)
        end
    }
}

function SingPPA:new()
    local earsShip = gameDirector:getLibrary("Pixelurite").configureSpriteSheet("ears_ship", "assets/sprites/singPPA/", true, nil, 1, 1, true)
    local this = setmetatable({
        singPPA = gameDirector:getLibrary("Pixelurite").configureSpriteSheet("sing_ppa", "assets/sprites/singPPA/", true, nil, 1, 1, true),
        background = love.graphics.newImage("assets/textures/sing_stage.png"),
        earsBleeding = love.audio.newSource("assets/sounds/ears_bleeding.mp3", "static"),
        thanksSOB = love.audio.newSource("assets/sounds/valeu_fdp.mp3", "static"),
        pipe = {
            front = love.graphics.newImage("assets/sprites/singPPA/ppa_pipe_front.png"),
            back = love.graphics.newImage("assets/sprites/singPPA/ppa_pipe_back.png")
        }, elapsedTime = 0, playOnce = false, rng = love.math.newRandomGenerator(os.time()), randomized = 0,
        buttons = {parentName = "singPPA"}, musicPaused = false, totalPipesClicked = 0, currentState = states[1], allStates = states,
        player = Player:new(earsShip, gameDirector:getWorld():getWorld()),
    }, SingPPA)
    local x, y, totalCount = 40, 40, 1
    for count = 1, 4 do
        for index = 1, 7 do
            gameDirector:addButton(this, this.buttons, string.format('SingPPA_%s', totalCount), false, "", {90, 110, x, y}, {width = 90, height = 110},
            function(self) self:disableButton(); this.musicPaused = true; this.earsBleeding:pause(); this.thanksSOB:play() end, true)
            this.buttons[string.format('singPPASingPPA_%s', totalCount)]:disableButton()
            x = x + 105; totalCount = totalCount + 1;
        end
        x = 40; y = y + 140
    end
    this:randomizeSingingPPA()

    this.buttons.parentName = nil
    return this
end

function SingPPA:entering(previousScene)
    if not self.playOnce then self.earsBleeding:play(); self.playOnce = true end
    self.totalPipesClicked = 0; self.currentState = self.allStates[2]
end

function SingPPA:getEntityByFixture(fixture)
    if fixture:getUserData() == "Player" then
        return self.characterController
    end
    return nil
end

function SingPPA:randomizeSingingPPA()
    self.randomized = self.rng:random(28)
    self.totalPipesClicked = self.totalPipesClicked + 1
    for _, index in pairs(genOrderedIndex(self.buttons)) do
        if string.format('singPPASingPPA_%s', self.randomized) == index then
            self.buttons[index]:enableButton()
        end
    end
end

function SingPPA:keypressed(key, scancode, isrepeat)
    self.currentState.keypressed(self, key, scancode, isrepeat)
end

function SingPPA:keyreleased(key, scancode)
    self.currentState.keyreleased(self, key, scancode)
end

function SingPPA:mousepressed(x, y, button)
    for _, button in pairs(self.buttons) do button:mousepressed(x, y, button) end
end

function SingPPA:mousereleased(x, y, button)
    for _, button in pairs(self.buttons) do button:mousereleased(x, y, button) end
end

function SingPPA:update(dt)
    if self.musicPaused then
        self.elapsedTime = self.elapsedTime + dt
        if self.elapsedTime >= 0.4 then self.earsBleeding:play(); self.musicPaused = false; self:randomizeSingingPPA() self.elapsedTime = 0 end
    elseif not self.earsBleeding:isPlaying() then
        sceneDirector:previousScene()
    end
    self.currentState.update(self, dt)
end

function SingPPA:draw()
    self.currentState.draw(self)
    --[[for _, button in pairs(self.buttons) do button:draw() end--]]
end

return SingPPA
