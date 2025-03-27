function newFocusManager()
  local self = {
    grid = nil,
    x = nil,
    y = nil,
  }

  local setGrid = function(grid)
    if self.grid ~= nil then
      self.grid[self.y][self.x].setState(uiState.Normal)
    end
    self.grid = grid
    self.x = 1
    self.y = 1
    self.grid[self.y][self.x].setState(uiState.Focused)
  end
  
  local update = function()
    if self.grid == nil then
      return
    end

    if self.grid[self.y][self.x].getState() == uiState.Focused then
      self.grid[self.y][self.x].setState(uiState.Normal)
      if btnp(2, 0) then
        self.y = self.y - 1
      elseif btnp(3, 0) then
        self.y = self.y + 1
      elseif btnp(0, 0) then
        self.x = self.x - 1
      elseif btnp(1, 0) then
        self.x = self.x + 1
      end
      if self.y < 1 then
        self.y = #self.grid
      elseif self.y > #self.grid then
        self.y = 1
      end
      if self.x < 1 then
        self.x = #self.grid[self.y]
      elseif self.x > #self.grid[self.y] then
        self.x = 1
      end
      self.grid[self.y][self.x].setState(uiState.Focused)
    end
  end

  return {
    setGrid = setGrid,
    update = update,
  }
end
