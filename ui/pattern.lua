function newUiPattern(x, y)
  local self = {
    pattern = nil,
    x = x,
    y = y,
    playIndex = 1,
  }

  local setPattern = function(pattern)
    self.pattern = pattern
  end

  local draw = function()
    if self.pattern == nil then
      print("no pattern", self.x, self.y, uiColor.text)
      return
    end

    local stepWidth = flr(128 / #self.pattern.data)
    local xOffset = 128 - #self.pattern.data * stepWidth
    for i = 1, #self.pattern.data do
      local x = self.x + (i - 1) * stepWidth + xOffset / 2
      local y = self.y
      if self.pattern.data[i] == 1 then
        rect(x, y, x + stepWidth - 1, y + 5, uiColor.filledStep)
      else
        rect(x, y, x + stepWidth - 1, y + 5, uiColor.emptyStep)
      end
      if i == self.playIndex then
        rectfill(x+1, y+1, x + stepWidth - 2, y + 4, uiColor.playStep)
      end
    end
  end

  self.setPattern = setPattern
  self.draw = draw

  return self
end
