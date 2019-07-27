local Label = {}; Label.__index = Label

function Label:new(x, y, w, h, text, color, align)
    local this = setmetatable({
        position = {x = x or 0, y = y or 0}, w = w, h = h,
        text = text or "", align = align or "center",
        color = color or {1, 1, 1, 1}
    }, Label)
    return this
end

function Label:setText(text)
    self.text = text
end

function Label:addText(text)
    self.text = self.text .. text
end

function Label:draw()
    local currentFont = love.graphics.getFont()
    local _, lines = currentFont:getWrap(self.text, self.w)
    local fontHeight = currentFont:getHeight()
    local red, green, blue, alpha = love.graphics.getColor()
    love.graphics.setColor(unpack(self.color))
    love.graphics.printf(self.text, self.position.x, self.position.y - (fontHeight /2 * #lines), self.w, self.align)
    love.graphics.setColor(red, green, blue, alpha)
    --love.graphics.rectangle("line", self.position.x, self.position.y - self.h /2, self.w, self.h)
end

return Label
