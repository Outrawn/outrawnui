local OutrawnUI = require("OutrawnUI.core")

local List = {}
List.__index = List

function List.new(x, y, width, height, items)
    local self = setmetatable({}, List)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.items = items or {}
    self.selectedIndex = nil
    return self
end

function List:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)

    for i, item in ipairs(self.items) do
        local itemY = self.y + (i - 1) * 30
        love.graphics.rectangle("line", self.x, itemY, self.width, 30)
        love.graphics.printf(item, self.x, itemY + 5, self.width, "center")
    end
end

function List:mousepressed(x, y)
    for i, item in ipairs(self.items) do
        local itemY = self.y + (i - 1) * 30
        if OutrawnUI.pointInRect(x, y, self.x, itemY, self.width, 30) then
            self.selectedIndex = i
            return true
        end
    end
    return false
end

function List:getSelected()
    return self.items[self.selectedIndex]
end

return List
