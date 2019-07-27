--Models
local World = require "models.business.World"

--Libs
local MoonJohn = require "libs.MoonJohn"
local Sanghost = require "libs.Sanghost.Sanghost"
local Pixelurite = require "libs.Pixelurite"
local Scribe = require "libs.scribe.Scribe"

--Controllers

--Util
local TextBox = require "util.TextBox"

--Gui Components
local Button = require "util.ui.Button"
local ProgressBar = require "util.ui.ProgressBar"

local GameDirector = {}

GameDirector.__index = GameDirector

function GameDirector:new()
    local world = World:new()
    local this = {
        world = world,
        gameState = Sanghost:new(),
        --Libraries
        libraries = {
            MoonJohn = MoonJohn, Sanghost = Sanghost, Pixelurite = Pixelurite,
            ProgressBar = ProgressBar, Button = Button, Scribe = Scribe, TextBox = TextBox
        },
        fonts = {
            default = love.graphics.getFont(),
            tovariSans = love.graphics.newFont("assets/fonts/TovariSans.ttf", 36),
            tovariSans_small = love.graphics.newFont("assets/fonts/TovariSans.ttf", 22)
        }
    }
    return setmetatable(this, GameDirector)
end

function GameDirector:addButton(this, buttonList, buttonName, showText, sceneName, buttonDimensions, originalSize, callback, disableButton)
    local scaleButtonName = buttonList.parentName .. buttonName
    scaleDimension:calculeScales(scaleButtonName, unpack(buttonDimensions))
    scaleDimension:relativeScale(scaleButtonName, originalSize)
    local scales = scaleDimension:getScale(scaleButtonName)

    --buttonName, x, y, width, height, image, originalImage, animation, 70
    local button = self.libraries["Button"]:new(showText and buttonName or "", scales.x, scales.y, scales.width, scales.height, this.buttonsQuads, this.buttonsImage)
    button.callback = callback or function(self) sceneDirector:switchScene(sceneName); sceneDirector:reset(sceneName); if this.music then this.music:pause() end; if disableButton then self:disableButton() end end
    button:setScale(scales.relative.x, scales.relative.y)
    
    buttonList[scaleButtonName] = button
end

function GameDirector:loadScene(sceneName, requiredFile)
    sceneDirector:addScene(sceneName, require (requiredFile):new()) --[[ Added sceneName Scene --]]
end

function GameDirector:getLibrary(library)
    return self.libraries[library]
end

function GameDirector:getFonts() return self.fonts end

function GameDirector:getWorld() return self.world end

function GameDirector:update(dt) self.world:update(dt) end

function GameDirector:draw()
end

return GameDirector
