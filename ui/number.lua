function newUiNumber(value, x, y, min, max, label)
  local self = {
    label = label or "",
    value = value,
    x = x,
    y = y,
    min = min,
    max = max,
    state = uiState.Normal,
  }

  local setValue = function(value)
    if value < self.min then
      self.value = self.min
    elseif value > self.max then
      self.value = self.max
    else
      self.value = value
    end
  end

  local update = function()

    if self.state == uiState.Focused then
      if btnp(4, 0) then
        setValue(self.value - 1)
      elseif btnp(5, 0) then
        setValue(self.value + 1)
      end
    end
  end

  local draw = function()
    local text = self.label
    if text ~= "" then
      text = text .. ":"
    end
    text = text .. self.value
    print(text, self.x + 1, self.y + 1, uiColor.text)
    if self.state == uiState.Focused then
      rect(self.x, self.y, self.x + #text * uiParameters.charWidthSpaced, self.y + uiParameters.charHeightSpaced, uiColor.focused)
    end
  end

  self.draw = draw
  self.update = update
  return self

end
