local TinkerMacro = {}

TinkerMacro.__index = TinkerMacro

function TinkerMacro:new()    
    local this = setmetatable({
        dotaTerrain = love.graphics.newImage("assets/textures/dota_terrain.png"),
        tinkerAnimation = gameDirector:getLibrary("Pixelurite").configureSpriteSheet("tinker_side", "assets/sprites/tinkerMacro/", true, nil, 1, 1, true),
        thisIsHowILike = love.audio.newSource("assets/sounds/assim_que_eu_gosto.mp3", "static"),
        elapsedTime = 0, visibleButtons = {}, hiddenButtons = {}, rng = love.math.newRandomGenerator(os.time()),
        buttons = {parentName = "tinkerMacro"}, macroButton = nil, waitTime = 2, totalVisible = 0, totalButtons = 0,
        buttonsClicked = 0, laserSound = love.audio.newSource("assets/sounds/tinker_laser.mp3", "static"), waitStop = 0, waitMacro = 6
    }, TinkerMacro)

    local spriteSheet = gameDirector:getLibrary("Pixelurite").getSpritesheet():new("macro_button", "assets/sprites/tinkerMacro/", nil)
    local spriteQuads = spriteSheet:getQuads()
    this.buttonsQuads = {
        normal = spriteQuads["normal"], hover = spriteQuads["hover"],
        pressed = spriteQuads["pressed"], disabled = spriteQuads["disabled"]
    }
    this.buttonsImage = spriteSheet:getAtlas()
    local x, y, width, height = this.buttonsQuads["normal"]:getViewport()
    local originalSize = {width = width, height = height}
    gameDirector:addButton(this, this.buttons, 'Activate Macro', false, "", {160, 60, 80, 170}, originalSize, function(self) this:enableMacro() end)

    local buttonImage = love.graphics.newImage("assets/sprites/tinkerMacro/button.png"); this.buttonsImage = nil
    this.buttonsQuads = {normal = buttonImage, hover = buttonImage, pressed = buttonImage, disabled = buttonImage}
    originalSize = {width = buttonImage:getWidth(), height = buttonImage:getHeight()}
    x = 280; y = 140
    for letter in string.gmatch("abcdefghijklmnopqrstuvxwyz123456789", ".") do
        gameDirector:addButton(this, this.buttons, letter, true, "", {40, 40, x, y}, originalSize, function(self) this:hidden(letter) end)
        this.visibleButtons[letter] = false; this.hiddenButtons[letter] = true; x = x + 50; this.totalButtons = this.totalButtons + 1
        if x >= 700 then x = 280; y = y + 50 end
    end
    this.macroButton = this.buttons["tinkerMacroActivate Macro"]; this.buttons["tinkerMacroActivate Macro"] = nil
    this.buttons.parentName = nil
    return this
end

function TinkerMacro:hidden(letter)
    self.visibleButtons[letter] = false; self.hiddenButtons[letter] = true
    self.buttonsClicked = self.buttonsClicked + 1; self.totalVisible = self.totalVisible - 1
end

function TinkerMacro:enableMacro()
    self.waitStop = 0.5; self.laserSound:play()
end

function TinkerMacro:keypressed(key, scancode, isrepeat)
    local buttonName = string.format("tinkerMacro%s", key)
    if self.buttons[buttonName] and self.visibleButtons[key] then self:hidden(key) end
end

function TinkerMacro:mousepressed(x, y, button)
    if self.waitMacro <= 0 then self.macroButton:mousepressed(x, y, button) end
    for _, button in pairs(self.buttons) do
        button:mousepressed(x, y, button)
    end
end

function TinkerMacro:mousereleased(x, y, button)
    if self.waitMacro <= 0 then self.macroButton:mousereleased(x, y, button) end
    for _, button in pairs(self.buttons) do
        button:mousereleased(x, y, button)
    end
end

function TinkerMacro:update(dt)
    self.elapsedTime = self.elapsedTime + dt
    if self.totalVisible >= 15 then self.waitMacro = self.waitMacro - dt end
    if self.waitStop > 0 then
        if self.elapsedTime >= self.waitStop then
            self.thisIsHowILike:play(); sceneDirector:previousScene()
        end
    else
        if self.elapsedTime >= self.waitTime then
            if self.buttonsClicked >= 6 then self.waitTime = self.waitTime - 0.5 end
            local finished = false
            repeat
                local totalVisible = 0
                local random = self.rng:random(self.totalButtons); local count = 1
                if self.totalVisible >= 10 then random = -1 end
                for key, value in pairs(self.hiddenButtons) do
                    if value then
                        if random > 0 then
                            if count == random then
                                self.hiddenButtons[key] = false; self.visibleButtons[key] = true;
                                finished = true; self.totalVisible = self.totalVisible + 1
                            end
                        else
                            self.hiddenButtons[key] = false; self.visibleButtons[key] = true;
                            self.totalVisible = self.totalVisible + 1
                        end
                    else
                        totalVisible = totalVisible + 1
                        self.totalVisible = self.totalVisible + 1
                    end
                    count = count + 1
                end
                if totalVisible >= #self.visibleButtons then finished = true end
            until finished
            self.elapsedTime = 0
        end
    end
    self.tinkerAnimation:update(dt)
end

function TinkerMacro:draw()
    love.graphics.draw(self.dotaTerrain, 0, 0, r, sx, sy, ox, oy)
    love.graphics.printf("Solte o Laser do Tinker", 0, 40, love.graphics.getWidth(), "center")
    self.tinkerAnimation:draw(160, 400, 2.5, 2.5)
    if self.waitMacro <= 0 then self.macroButton:draw() end
    for _, button in pairs(self.buttons) do
        if self.visibleButtons[_:sub(-1)] then button:draw() end
    end
end

return TinkerMacro
