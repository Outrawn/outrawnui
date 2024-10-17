local OutrawnUI = require("OutrawnUI.core")

local InputText = {}
InputText.__index = InputText

function InputText.new(x, y, width, height, placeholder, inputType)
    local self = setmetatable({}, InputText)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.placeholder = placeholder
    self.text = ""
    self.active = false
    self.inputType = inputType or "text"
    return self
end

function InputText:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)

    local displayText = self.text
    if self.inputType == "password" then
        displayText = string.rep("*", #self.text)
    elseif self.inputType == "date" and #self.text > 0 then
        displayText = self.text:gsub("(%d%d%d%d)%-?(%d?%d?)%-?(%d?%d?)", "%1-%2-%3")
    end

    if #displayText > 0 then
        love.graphics.print(displayText, self.x + 5, self.y + 5)
    elseif not self.active then
        love.graphics.setColor(0.5, 0.5, 0.5)
        love.graphics.print(self.placeholder, self.x + 5, self.y + 5)
    end

    if self.active then
        love.graphics.line(self.x + 5 + love.graphics.getFont():getWidth(displayText), self.y + 5,
                           self.x + 5 + love.graphics.getFont():getWidth(displayText), self.y + self.height - 5)
    end
end

function InputText:mousepressed(x, y)
    if OutrawnUI.pointInRect(x, y, self.x, self.y, self.width, self.height) then
        self.active = true
        return true
    else
        self.active = false
    end
    return false
end

function InputText:textinput(text)
    if self.active then
        if self.inputType == "date" then
            if text:match("[0-9-]") then
                self.text = self.text .. text
            end
        else
            self.text = self.text .. text
        end
    end
end

function InputText:keypressed(key)
    if self.active then
        if key == "backspace" then
            self.text = self.text:sub(1, -2)
        end
    end
end

return InputText