local OutrawnUI = require("OutrawnUI.core")

local ProgressBar = {}
ProgressBar.__index = ProgressBar

function ProgressBar.new(x, y, width, maxValue)
    local self = setmetatable({}, ProgressBar)
    self.x = x
    self.y = y
    self.width = width
    self.maxValue = maxValue
    self.value = 0
    return self
end

function ProgressBar:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", self.x, self.y, self.width, 20)
    local fillWidth = (self.value / self.maxValue) * self.width
    love.graphics.setColor(0.5, 0.8, 0.5)
    love.graphics.rectangle("fill", self.x, self.y, fillWidth, 20)
end

function ProgressBar:setValue(value)
    self.value = math.min(value, self.maxValue)
end

return ProgressBar
