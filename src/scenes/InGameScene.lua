local InGameScene = {}

InGameScene.__index = InGameScene

function InGameScene:new()    
    this = setmetatable({
        textbox = nil,
        ppaAnimation = gameDirector:getLibrary("Pixelurite").configureSpriteSheet("ppa_animation", "assets/sprites/", true, nil, 1, 1, true),
        workstation = love.graphics.newImage("assets/textures/workstation_background.png"),
        microphone = love.graphics.newImage("assets/sprites/microphone.png"), gameScreen = love.graphics.newImage("assets/textures/monitor_game.png"),
        sound = love.audio.newSource("assets/sounds/button_pressed.mp3", "static"),
        elapsedTime = 0,
        buttons = {parentName = "inGame"}
    }, InGameScene)
    gameDirector:addButton(this, this.buttons, 'TinkerMacro', "tinkerMacro", {160, 384, 80, 170}, {width = 160, height = 384})
    gameDirector:addButton(this, this.buttons, 'ChatGado', "chatGado", {141, 83, 465, 200}, {width = 141, height = 83})
    gameDirector:addButton(this, this.buttons, 'SingPPA', "singPPA", {100, 105, 435, 240}, {width = 100, height = 105})
    this.buttons.parentName = nil
    this.textbox = gameDirector:getLibrary("TextBox"):new(require "models.TextScript":get(), gameDirector:getLibrary("Scribe"), this)
    return this
end

function InGameScene:deleteTextBox()
    self.textbox = nil; self.elapsedTime = 0
end

function InGameScene:keypressed(key, scancode, isrepeat)
    if self.elapsedTime > 3.5 and self.textbox then
        self.elapsedTime = 0
        self.sound:play()
        self.textbox:keypressed(key, scancode, isrepeat)
    end
end

function InGameScene:mousepressed(x, y, button)
    if self.elapsedTime > 3.5 and self.textbox then
        self.elapsedTime = 0
        self.sound:play()
        self.textbox:mousepressed(x, y, button)
    end
    if not self.textbox then
        for _, button in pairs(self.buttons) do button:mousepressed(x, y, button) end
    end
end

function InGameScene:mousereleased(x, y, button)
    if not self.textbox then
        for _, button in pairs(self.buttons) do button:mousereleased(x, y, button) end
    end
end

function InGameScene:update(dt)
    self.elapsedTime = self.elapsedTime + dt
    self.ppaAnimation:update(dt)
    if self.textbox then self.textbox:update(dt) end
end

function InGameScene:draw()
    local x = 120; local y = 300; local scale = 2
    love.graphics.draw(self.workstation, 0, 0, r, sx, sy, ox, oy)
    self.ppaAnimation:draw(self.textbox and x or 180, self.textbox and y or 380, self.textbox and scale or 3, self.textbox and scale or 3)
    if self.textbox then self.textbox:draw()
    else
        love.graphics.draw(self.gameScreen, 464, 198, r, sx, sy, ox, oy)
        love.graphics.draw(self.microphone, 435, 235, r, sx, sy, ox, oy)
    end
    for _, button in pairs(self.buttons) do
        button:draw()
    end
end

return InGameScene
