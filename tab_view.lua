local OutrawnUI = require("OutrawnUI.core")

local TabView = {}
TabView.__index = TabView

function TabView.new(x, y, width, height, tabs)
    local self = setmetatable({}, TabView)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.tabs = tabs or {}
    self.selectedIndex = 1
    return self
end

function TabView:draw()
    love.graphics.setColor(1, 1, 1)

    for i, tab in ipairs(self.tabs) do
        if i == self.selectedIndex then
            love.graphics.setColor(0.5, 0.5, 1)
        else
            love.graphics.setColor(0.7, 0.7, 0.7)
        end
        love.graphics.rectangle("fill", self.x + (i - 1) * (self.width / #self.tabs), self.y, self.width / #self.tabs, 30)
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf(tab.text, self.x + (i - 1) * (self.width / #self.tabs), self.y + 5, self.width / #self.tabs, "center")
    end

    -- Content Area
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", self.x, self.y + 30, self.width, self.height - 30)
    love.graphics.print(self.tabs[self.selectedIndex].content, self.x + 10, self.y + 40)
end

function TabView:mousepressed(x, y)
    for i, tab in ipairs(self.tabs) do
        if OutrawnUI.pointInRect(x, y, self.x + (i - 1) * (self.width / #self.tabs), self.y, self.width / #self.tabs, 30) then
            self.selectedIndex = i
            return true
        end
    end
    return false
end

return TabView
