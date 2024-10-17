local OutrawnUI = require("OutrawnUI.core")

local Dropdown = {}
Dropdown.__index = Dropdown

function Dropdown.new(x, y, width, options)
    local self = setmetatable({}, Dropdown)
    self.x = x
    self.y = y
    self.width = width
    self.options = options
    self.selectedIndex = 1
    self.open = false
    return self
end

function Dropdown:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", self.x, self.y, self.width, 30)
    love.graphics.printf(self.options[self.selectedIndex], self.x, self.y + 5, self.width, "center")

    if self.open then
        for i, option in ipairs(self.options) do
            love.graphics.rectangle("line", self.x, self.y + 30 + (i - 1) * 30, self.width, 30)
            love.graphics.printf(option, self.x, self.y + 30 + (i - 1) * 30 + 5, self.width, "center")
        end
    end
end

function Dropdown:mousepressed(x, y)
    if OutrawnUI.pointInRect(x, y, self.x, self.y, self.width, 30) then
        self.open = not self.open
        return true
    end

    if self.open then
        for i, option in ipairs(self.options) do
            if OutrawnUI.pointInRect(x, y, self.x, self.y + 30 + (i - 1) * 30, self.width, 30) then
                self.selectedIndex = i
                self.open = false
                return true
            end
        end
    end

    self.open = false
    return false
end

return Dropdown
