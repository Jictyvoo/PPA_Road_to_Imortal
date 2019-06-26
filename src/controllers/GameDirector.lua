--Models
local World = require "models.business.World"

--Actors
local Player = require "models.entities.Player"

--Libs
local MoonJohn = require "libs.MoonJohn"
local Sanghost = require "libs.Sanghost.Sanghost"
local Pixelurite = require "libs.Pixelurite"

--Controllers

--Gui Components
local ButtonManager = require "util.ui.ButtonManager"

local GameDirector = {}

GameDirector.__index = GameDirector

function GameDirector:new()
    local world = World:new()
    local this = {
        world = world,
        player = Player:new(world),
        gameState = Sanghost:new(),
        --Libraries
        libraries = {
            MoonJohn = MoonJohn, Sanghost = Sanghost, Pixelurite = Pixelurite,
            ButtonManager = ButtonManager
        }
    }
    return setmetatable(this, GameDirector)
end

function GameDirector:getPlayer()
    return self.player
end

function GameDirector:getLibrary(library)
    return self.libraries[library]
end

function GameDirector:keypressed(key, scancode, isrepeat)
end

function GameDirector:keyreleased(key, scancode)
end

function GameDirector:getEntityByFixture(fixture)
    if fixture:getUserData() == "Player" then
        return self.characterController
    end
    return nil
end

function GameDirector:getWorld()
    return self.world
end

function GameDirector:update(dt)
    self.world:update(dt)
end

function GameDirector:draw()
    self.player:draw()
end

return GameDirector
