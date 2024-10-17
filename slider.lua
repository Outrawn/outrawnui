local OutrawnUI = require("OutrawnUI.core")

local Slider = {}
Slider.__index = Slider

function Slider.new(x, y, width, minValue, maxValue)
    local self = setmetatable({}, Slider)
    self.x = x
    self.y = y
    self.width = width
    self.minValue = minValue
    self.maxValue = maxValue
    self.value = minValue
    self.dragging = false
    return self
end

function Slider:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", self.x, self.y, self.width, 10)

    local handleX = self.x + (self.value - self.minValue) / (self.maxValue - self.minValue) * self.width
    love.graphics.setColor(0.5, 0.5, 0.5)
    love.graphics.rectangle("fill", handleX - 5, self.y - 5, 10, 20)
end

function Slider:mousepressed(x, y)
    if OutrawnUI.pointInRect(x, y, self.x, self.y, self.width, 10) then
        self.dragging = true
        self:updateValue(x)
        return true
    end
    return false
end

function Slider:mousereleased(x, y)
    self.dragging = false
end

function Slider:updateValue(x)
    if self.dragging then
        local newValue = ((x - self.x) / self.width) * (self.maxValue - self.minValue) + self.minValue
        self.value = math.min(math.max(newValue, self.minValue), self.maxValue)
    end
end

return Slider
