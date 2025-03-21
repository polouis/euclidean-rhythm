function newUiNumber(value, x, y, min, max, label)
  local self = {
    label = label or "",
    value = value,
    x = x,
    y = y,
    min = min,
    max = max,
    color = 7,
    state = uiState.Unfocused,
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
    if self.state == uiState.Focused and btnp(5, 0) then
      self.state = uiState.Edited
    elseif self.state == uiState.Edited and btnp(4, 0) then
      self.state = uiState.Focused
    end

    if self.state == uiState.Edited then
      if btnp(0, 0) then
        setValue(self.value - 1)
      elseif btnp(1, 0) then
        setValue(self.value + 1)
      end
    end
  end

  local draw = function()
    local text = self.label
    if text ~= "" then
      text = text .. " : "
    end
    text = text .. self.value
    print(text, self.x, self.y, self.color)
    if self.state == uiState.Focused then
      rect(self.x - 1, self.y - 1, self.x -1 + #text * 4, self.y -1 + 6, 6)
    elseif self.state == uiState.Edited then
      rect(self.x - 1, self.y - 1, self.x -1 + #text * 4, self.y -1 + 6, 8)
    end
  end

  local getValue = function()
    return self.value
  end

  local setState = function(state)
    self.state = state
  end

  return {
    setValue = setValue,
    getValue = getValue,
    draw = draw,
    update = update,
    setState = setState,
  }
end
