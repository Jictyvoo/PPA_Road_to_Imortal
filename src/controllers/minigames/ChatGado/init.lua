local currentPath   = (...):gsub('%.init$', '') .. "."
local Label = require "util.Label"

local ChatGado = {}; ChatGado.__index = ChatGado

function ChatGado:new()    
    local this = setmetatable({
        shipPPA = love.graphics.newImage("assets/sprites/ShipPPA.png"),
        elapsedTime = 0, background = love.graphics.newImage("assets/textures/chat_gado.png"),
        buttons = {parentName = "chatGado"},
        decisionStates = require(string.format("%smodels.DecisionStates", currentPath)),
        allMessages = {}, restart = false,
        labels = {
            Label:new(20, 90, 500, 80, "", color, "left"), Label:new(20, 180, 500, 80, "", {0.64, 0.31, 0.59}, "left"),
            Label:new(20, 270, 500, 80, "", color, "left"), Label:new(20, 360, 500, 80, "", {0.64, 0.31, 0.59}, "left")
        }
    }, ChatGado)

    local spriteSheet = gameDirector:getLibrary("Pixelurite").getSpritesheet():new("letterButton", "assets/sprites/demonWords/", nil)
    local spriteQuads = spriteSheet:getQuads(); this.buttonsImage = spriteSheet:getAtlas()
    this.buttonsQuads = {
        normal = spriteQuads["normal"], hover = spriteQuads["hover"], pressed = spriteQuads["pressed"], disabled = spriteQuads["disabled"]
    }
    local x, y, width, height = this.buttonsQuads["normal"]:getViewport()
    local originalSize = {width = width, height = height}; x, y = 20, 500
    for index = 1, 3 do
        gameDirector:addButton(this, this.buttons, tostring(index), true, "", {140, 80, x, y}, originalSize, 
        function(self) this:changeState(self:getName()) end, true); x = x + 160
    end
    this.buttons.parentName = nil

    this:updateButtonsText()

    return this
end

function ChatGado:updateButtonsText()
    local count = 1; local stateOptions = {}
    for option, text in pairs(self.decisionStates:getOptions() or {}) do table.insert(stateOptions, option) end
    for _, button in pairs(self.buttons) do
        button:setName(stateOptions[count] or ""); count = count + 1
        if button:getName() == "start" then self.restart = true; self.elapsedTime = 0; button:disableButton()
        elseif button:getName() == "" then button:disableButton()
        else button:enableButton() end
    end
end

function ChatGado:addMessage(text)
    if #self.allMessages >= 4 then table.remove(self.allMessages, 1) end
    table.insert(self.allMessages, text)
end

function ChatGado:changeState(stateSelected)
    self:addMessage("PeterPPA: " .. self.decisionStates:getOptionText(stateSelected))
    self.decisionStates:chooseState(stateSelected)
    self:addMessage("Gabriela José Maria: " .. self.decisionStates:getText())
    self:updateButtonsText()
end

function ChatGado:cleanMessages()
    for count = 1, 4 do table.remove(self.allMessages, 1) end
end

function ChatGado:keypressed(key, scancode, isrepeat)
end

function ChatGado:mousemoved(x, y, dx, dy, istouch)
    for _, button in pairs(self.buttons) do button:mousemoved(x, y, dx, dy, istouch) end
end

function ChatGado:mousepressed(x, y, button)
    for _, button in pairs(self.buttons) do button:mousepressed(x, y, button) end
end

function ChatGado:mousereleased(x, y, button)
    for _, button in pairs(self.buttons) do button:mousereleased(x, y, button) end
end

function ChatGado:update(dt)
    self.elapsedTime = self.elapsedTime + dt
    if self.elapsedTime >= 5 then
        self.elapsedTime = 0
        if self.restart then
            self:cleanMessages(); self.restart = false
            for _, button in pairs(self.buttons) do if button:getName() ~= "" then button:enableButton() end end
        elseif self.decisionStates:isFinished() then sceneDirector:previousScene()
        end
    end
end

function ChatGado:draw()
    love.graphics.draw(self.background, 0, 0, r, sx, sy, ox, oy)
    for _, button in pairs(self.buttons) do button:draw() end
    local currentFont = love.graphics.getFont(); love.graphics.setFont(gameDirector:getFonts().tovariSans_small)
    for index, label in pairs(self.labels) do label:setText(self.allMessages[index] or ""); label:draw() end
    love.graphics.setFont(currentFont)
    love.graphics.draw(self.shipPPA, 600 , 80, nil, 0.7, 0.7, ox, oy)
end

return ChatGado
