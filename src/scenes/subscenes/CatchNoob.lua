local CatchNoob = {}; CatchNoob.__index = CatchNoob

function CatchNoob:new()
    local this = setmetatable({
        background = love.graphics.newImage("assets/textures/menu_background.png"),
        x = 0, y = 0, rng = love.math.newRandomGenerator(os.time()), selected = 1,
        noobElements = {
            sounds = {
                love.audio.newSource("assets/sounds/noob_1.mp3", "static"),
                love.audio.newSource("assets/sounds/noob_2.mp3", "static"),
                love.audio.newSource("assets/sounds/noob_3.mp3", "static")
            },
            sprites = {
                love.graphics.newImage("assets/textures/noob_side.png"),
                love.graphics.newImage("assets/textures/noob_topbot.png")
            }
        },
        laughtSound = love.audio.newSource("assets/sounds/hahahahaha.mp3", "static"),
        elapsedTime = 0, currentSprite = 1, orientation = true, --normal = true | inverted = false
        amount = 0, totalTime = 0, mouseClickTime = 0
    }, CatchNoob)
    this:reset(); this.selected = 1
    return this
end

function CatchNoob:reset()
    self.selected = self.rng:random(#self.noobElements.sounds)
    self.currentSprite = self.rng:random(#self.noobElements.sprites)
    self.orientation = self.rng:random(200) >= 100
    if self.currentSprite == 1 then
        if self.orientation then self.x = 800
        else self.x = 0 end
        self.y = 400
    else
        if self.orientation then self.y = 500
        else self.y = 100 end
        self.x = (love.graphics.getWidth() / 2)
    end
    self.elapsedTime = 0
end

function CatchNoob:mousepressed(x, y, button)
    if self.mouseClickTime <= self.totalTime + 1.2 then
        local validX = false; local validY = false
        if self.currentSprite == 1 then
            validY = y >= 240; validX = self.orientation and (x >= 640) or (x <= 160)
        else
            validX = x >= 300 and x <= 450
            validY = self.orientation and (y >= 335) or (y <= 260)
        end
        if validX and validY then self.amount = self.amount + 1 end
        self.mouseClickTime = self.totalTime
    end
    if self.amount >= 5 then
        self.laughtSound:play()
        sceneDirector:exitSubscene(); sceneDirector:switchScene("inGame")
    end
end

function CatchNoob:update(dt)
    self.elapsedTime = self.elapsedTime + dt; self.totalTime = self.totalTime + dt
    if self.elapsedTime >= 0.9 and not self.noobElements.sounds[self.selected]:isPlaying() then
        -- after reached max will play sound
        self:reset()
    elseif self.elapsedTime == dt then
        self.noobElements.sounds[self.selected]:play()
    end
end

function CatchNoob:draw()
    love.graphics.draw(self.noobElements.sprites[self.currentSprite], self.x, self.y, r,
    0.5 * (self.currentSprite == 1 and (self.orientation and 1 or -1) or 1),
    0.5 * (self.currentSprite == 2 and (self.orientation and 1 or -1) or 1),
    self.noobElements.sprites[self.currentSprite]:getWidth() / 2, 
    self.noobElements.sprites[self.currentSprite]:getHeight() / 2)
end

return CatchNoob
