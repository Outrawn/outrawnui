local function pointInRect(x, y, rx, ry, rw, rh)
    return x > rx and x < rx + rw and y > ry and y < ry + rh
end

return {
    pointInRect = pointInRect
}