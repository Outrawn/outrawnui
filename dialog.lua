local OutrawnUI = require("OutrawnUI.core")

local Dialog = {}
Dialog.__index = Dialog

function Dialog.new(title, message, buttons)
    local self = setmetatable({}, Dialog)
    self.title = title
    self.message = message
    self.buttons = buttons or {{text = "OK"}}
    self.visible = false
    return self
end

function Dialog:draw()
    if not self.visible then return end

    local width, height = love.graphics.getDimensions()
    local dialogWidth, dialogHeight = 300, 150
    local x, y = (width - dialogWidth) / 2, (height - dialogHeight) / 2

    love.graphics.setColor(0.2, 0.2, 0.2, 0.8)
    love.graphics.rectangle("fill", x, y, dialogWidth, dialogHeight)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", x, y, dialogWidth, dialogHeight)

    love.graphics.printf(self.title, x, y + 10, dialogWidth, "center")
    love.graphics.printf(self.message, x + 10, y + 40, dialogWidth - 20, "center")

    local buttonWidth = 80
    local totalButtonWidth = #self.buttons * buttonWidth + (#self.buttons - 1) * 10
    local startX = x + (dialogWidth - totalButtonWidth) / 2

    for i, button in ipairs(self.buttons) do
        love.graphics.rectangle("line", startX + (i-1) * (buttonWidth + 10), y + dialogHeight - 40, buttonWidth, 30)
        love.graphics.printf(button.text, startX + (i-1) * (buttonWidth + 10), y + dialogHeight - 35, buttonWidth, "center")
    end
end

function Dialog:mousepressed(x, y)
    if not self.visible then return false end

    local width, height = love.graphics.getDimensions()
    local dialogWidth, dialogHeight = 300, 150
    local dialogX, dialogY = (width - dialogWidth) / 2, (height - dialogHeight) / 2

    local buttonWidth = 80
    local totalButtonWidth = #self.buttons * buttonWidth + (#self.buttons - 1) * 10
    local startX = dialogX + (dialogWidth - totalButtonWidth) / 2

    for i, button in ipairs(self.buttons) do
        local buttonX = startX + (i-1) * (buttonWidth + 10)
        local buttonY = dialogY + dialogHeight - 40
        if x > buttonX and x < buttonX + buttonWidth and y > buttonY and y < buttonY + 30 then
            if button.onClick then
                button.onClick()
            end
            self.visible = false
            return true
        end
    end

    return false
end

function Dialog:show()
    self.visible = true
end

return Dialog