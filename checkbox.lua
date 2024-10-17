local core = require("OutrawnUI.core")
local Checkbox = {}
Checkbox.__index = Checkbox

function Checkbox.new(x, y, width, height, label)
    local self = setmetatable({}, Checkbox)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.label = label
    self.checked = false
    return self
end

function Checkbox:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
    if self.checked then
        love.graphics.rectangle("fill", self.x + 2, self.y + 2, self.width - 4, self.height - 4)
    end
    love.graphics.print(self.label, self.x + self.width + 5, self.y)
end

function Checkbox:toggle()
    self.checked = not self.checked
end

function Checkbox:mousepressed(x, y)
    if core.pointInRect(x, y, self.x, self.y, self.width, self.height) then
        self:toggle()
        return true
    end
    return false
end

return Checkbox