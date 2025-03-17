Euclid = {

  steps = nil,
  beats = nil,
  pattern = nil,
  test = nil,

  tostring = function(self)
    result = "E("..self.beats..","..self.steps..") = "
    for i, v in ipairs(self.pattern) do
      result = result .. v .. " "
    end
    return result
  end,
  
  tableMerge = function(self, t1, t2)
    for i = 1, #t2 do
      t1[#t1+1] = t2[i]
    end
    return t1
  end,
  
  new = function(self, tbl)
    tbl = tbl or {}
    setmetatable(tbl, {
      __index = self,
      __tostring = self.tostring
    })

    return tbl
  end,

  compute = function(self, beats, steps)
    self.beats = beats
    self.steps = steps
    self.pattern = {}

    local buildT = function()
      remainders = {}
  
      zeros = self.steps - self.beats
      if self.beats <= zeros then
        while zeros >= self.beats do
          table.insert(remainders, self.beats)
          zeros = zeros - self.beats
        end
      end
      rPrev2 = self.steps
      rPrev1 = self.beats
  
      while true do
        r = rPrev2 % rPrev1
        if r <= 1 then
          return remainders
        end
        add(remainders, r)
        rPrev2 = rPrev1
        rPrev1 = r
      end
    end

    remainders = buildT()
    -- for i, v in ipairs(remainders) do
    --   print("r"..i, v)
    -- end

    groups = {}
    for i = 1, steps do
      if i <= beats then
        groups[i] = {1}
      else
        groups[i] = {0}
      end
    end
    -- printGroups(groups)

    for iRemainder, remainder in ipairs(remainders) do
      for iterIndexGroups = 1, remainder do
        self:tableMerge(groups[remainder + 1 - iterIndexGroups], groups[#groups])
        deli(groups, #groups)
      end
      -- printGroups(groups)
    end

    for i = 1, #groups do
      for j = 1, #groups[i] do
        self.pattern[#self.pattern + 1] = groups[i][j]
      end
    end
  end
}
