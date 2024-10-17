local OutrawnUI = require("OutrawnUI.core")

local Button = {}
Button.__index = Button

function Button.new(x, y, width, height, text, onClick, options)
    local self = setmetatable({}, Button)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.text = text
    self.onClick = onClick
    self.options = options or {}
    self.colors = {
        background = self.options.backgroundColor or {0.5, 0.5, 0.5},
        text = self.options.textColor or {1, 1, 1},
        hover = self.options.hoverColor or {0.6, 0.6, 0.6}
    }
    self.isHovered = false
    return self
end

function Button:draw()
    love.graphics.setColor(self.isHovered and self.colors.hover or self.colors.background)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, 8, 8)
    love.graphics.setColor(self.colors.text)
    love.graphics.printf(self.text, self.x, self.y + (self.height / 2) - 10, self.width, "center")
end

function Button:mousepressed(x, y)
    if OutrawnUI.pointInRect(x, y, self.x, self.y, self.width, self.height) then
        if self.onClick then
            self.onClick()
        end
        return true
    end
    return false
end

function Button:mousemoved(x, y)
    self.isHovered = OutrawnUI.pointInRect(x, y, self.x, self.y, self.width, self.height)
end

return Button