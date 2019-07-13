local MainMenuScene = {}

MainMenuScene.__index = MainMenuScene

local addButton = function(this, buttonName, sceneName, buttonDimensions, originalSize, callback)
    local scaleButtonName = "menu" .. buttonName
    scaleDimension:calculeScales(scaleButtonName, unpack(buttonDimensions))
    scaleDimension:relativeScale(scaleButtonName, originalSize)
    local scales = scaleDimension:getScale(scaleButtonName)

    --buttonName, x, y, width, height, image, originalImage, animation, 70
    local button = gameDirector:getLibrary("Button"):new("", scales.x, scales.y, scales.width, scales.height, this.buttonsQuads, this.buttonsImage)
    button.callback = callback or function(self) sceneDirector:switchScene(sceneName); sceneDirector:reset(sceneName); this.music:pause() end
    button:setScale(scales.relative.x, scales.relative.y)
    
    this.buttonNames[scaleButtonName] = button
end

function MainMenuScene:new()
    local this = {
        background = love.graphics.newImage("assets/textures/menu_background.png"),
        music = love.audio.newSource("assets/sounds/crazy_little_ears.mp3", "static"),
        buttonsImage = nil, buttonsQuads = nil,
        buttonNames = {}
    }
    this.music:setLooping(true)
    scaleDimension:calculeScales("menuBackground", this.background:getWidth(), this.background:getHeight(), 0, 0)
    local spriteSheet = gameDirector:getLibrary("Pixelurite").getSpritesheet():new("start_button", "assets/gui/", nil)
    local spriteQuads = spriteSheet:getQuads()
    this.buttonsQuads = {
        normal = spriteQuads["normal"],
        hover = spriteQuads["hover"],
        pressed = spriteQuads["pressed"],
        disabled = spriteQuads["disabled"]
    }
    this.buttonsImage = spriteSheet:getAtlas()
    -- Added subscene to SceneDirector
    sceneDirector:addSubscene("catchNoob", require "scenes.subscenes.CatchNoob":new())
    local x, y, width, height = this.buttonsQuads["normal"]:getViewport()
    local originalSize = {width = width, height = height}
    addButton(this, 'StartGame', "inGame", {50, 50, 80, 80}, originalSize, function(self)
        sceneDirector:switchSubscene("catchNoob"); this.music:pause()
    end)
    addButton(this, 'Credits', "credits", {320, 320, 420, 120}, originalSize)

    return setmetatable(this, MainMenuScene)
end

function MainMenuScene:entering(fromScene)
    if fromScene == "pressAny" then
        gameDirector:loadScene("tinkerMacro", "controllers.minigames.TinkerMacro")
        gameDirector:loadScene("chatGado", "controllers.minigames.ChatGado")
        gameDirector:loadScene("demonWords", "controllers.minigames.DemonWords")
        gameDirector:loadScene("singPPA", "controllers.minigames.SingPPA")
    end
end

function MainMenuScene:keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    end
end

function MainMenuScene:keyreleased(key, scancode)
end

function MainMenuScene:mousemoved(x, y, dx, dy, istouch)
    self.buttonNames['menuStartGame']:mousemoved(x, y, dx, dy, istouch)
end

function MainMenuScene:mousepressed(x, y, button)
    for _, button in pairs(self.buttonNames) do
        button:mousepressed(x, y, button)
    end
end

function MainMenuScene:mousereleased(x, y, button)
    for _, button in pairs(self.buttonNames) do
        button:mousereleased(x, y, button)
    end
end

function MainMenuScene:wheelmoved(x, y)
end

function MainMenuScene:update(dt)
    self.music:play()
end

function MainMenuScene:draw()
    local width, height = love.graphics.getDimensions()
    local scales = scaleDimension:getScale("menuBackground")
    love.graphics.draw(self.background, 0, 0, 0, scales.scaleX, scales.scaleY)
    self.buttonNames['menuStartGame']:draw()
end

function MainMenuScene:resize(w, h)
    for index, value in pairs(self.buttonNames) do
        local scales = scaleDimension:getScale(index)
        value:setXY(scales.x, scales.y)
        value:setDimensions(scales.width, scales.height)
        value:setScale(scales.relative.x, scales.relative.y)
    end
end

return MainMenuScene
