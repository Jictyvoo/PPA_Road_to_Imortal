local TextBox = {}; TextBox.__index = TextBox

function TextBox:new(texts, Scribe, parent)
    local function renderDefaultContainer( x, y, w, h )
        love.graphics.setColor( { 0.545, 0.963, 0.1, 192 } )
        love.graphics.rectangle( 'fill', x, y, w, h )
        love.graphics.setLineWidth( 2 )
        love.graphics.setColor( { 255, 255, 255 } )
        love.graphics.rectangle( 'line', x, y, w, h )
        love.graphics.setColor( { 128, 128, 128 } )
        love.graphics.rectangle( 'line', x+2, y+2, w-4, h-4 )
    end
    local this = setmetatable({
        texts = texts, index = 1, font = love.graphics.getFont(),
        scribeParameters = {
            text = texts[1],
            x = 10,
            color = {0, 0, 0},
            bg = renderDefaultContainer
        }, parent = parent
    }, TextBox)
    this.scribeParameters.y = (love.graphics.getHeight() - (this.font:getHeight() * 4 ) - 10) - (10 * 2)
    this.scribeParameters.w = love.graphics.getWidth() - 10 - 10
    this.scribeParameters.h = (this.font:getHeight() * 4) + ( 10 * 2 )
    this.textbox = Scribe(this.scribeParameters)
    return this
end

function TextBox:changeText()
    if self.index < #self.texts then
        self.index = self.index + 1
        self.textbox:setText(self.texts[self.index])
    else
        self.parent:deleteTextBox()
    end
end

function TextBox:keypressed(key, scancode, isrepeat)
    if key == "space" then
        self:changeText()
    end
end

function TextBox:update(dt)
    self.textbox:update(dt)
end

function TextBox:draw()
    self.textbox:draw()
    love.graphics.setColor(1, 1, 1, 1)
end

function TextBox:mousepressed(x, y, button)
    self:changeText()
end

return TextBox
