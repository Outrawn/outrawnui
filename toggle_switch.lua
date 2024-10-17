local OutrawnUI = require("OutrawnUI.core")

local ToggleSwitch = {}
ToggleSwitch.__index = ToggleSwitch

function ToggleSwitch.new(x, y, width, height)
    local self = setmetatable({}, ToggleSwitch)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.checked = false
    return self
end

function ToggleSwitch:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
    if self.checked then
        love.graphics.setColor(0.5, 1, 0.5)
        love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    end
end

function ToggleSwitch:toggle()
    self.checked = not self.checked
end

function ToggleSwitch:mousepressed(x, y)
    if OutrawnUI.pointInRect(x, y, self.x, self.y, self.width, self.height) then
        self:toggle()
        return true
    end
    return false
end

return ToggleSwitch
