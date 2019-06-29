function love.load()
    --set default constants
    love.graphics.setDefaultFilter('nearest', 'nearest')
    scaleDimension = require "util.ScaleDimension":new(); scaleDimension:setGameScreenScale(800, 600)
    gameDirector = require "controllers.GameDirector":new()
    love.graphics.setFont(gameDirector:getFonts().tovariSans)
    sceneDirector = gameDirector:getLibrary("MoonJohn").MoonJohn:new(require "scenes.SplashScreen":new())
    --Adding Scenes to SceneDirector
    local inGame = require "scenes.InGameScene":new(gameDirector:getWorld().world)
    sceneDirector:setDefaultTransition(function() return gameDirector:getLibrary("MoonJohn").Transitions:FadeOut() end)

    sceneDirector:addScene("pressAny", require "scenes.PressAnyButton":new())
    sceneDirector:addScene("mainMenu", require "scenes.MainMenuScene":new())
    sceneDirector:addScene("credits", require "scenes.CreditsScene":new())
    --[[sceneDirector:addScene("configurations", require "scenes.ConfigurationScene":new())--]]
    sceneDirector:addScene("inGame", inGame)
end

function love.keypressed(key, scancode, isrepeat)
    sceneDirector:keypressed(key, scancode, isrepeat)
end

function love.keyreleased(key, scancode)
    sceneDirector:keyreleased(key, scancode)
end

function love.mousemoved(x, y, dx, dy, istouch)
    sceneDirector:mousemoved(x, y, dx, dy, istouch)
end

function love.mousepressed(x, y, button)
    sceneDirector:mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
    sceneDirector:mousereleased(x, y, button)
end

function love.wheelmoved(x, y)
    sceneDirector:wheelmoved(x, y)
end

function love.update(dt)
    sceneDirector:update(dt)
end

function love.draw()
    sceneDirector:draw()
end

function love.resize(w, h)
    scaleDimension:screenResize(w, h)
    sceneDirector:resize(w, h)
end
