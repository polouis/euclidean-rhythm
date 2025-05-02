function newEuclid(initialBeats, initialSteps)

  if initialBeats > initialSteps then
    error("initialBeats must be less than or equal to initialSteps")
  end

  local self = {
    steps = initialSteps,
    beats = initialBeats,
    data = {},
  }

  if initialBeats == 0 then
    for i = 1, initialSteps do
      self.data[i] = 0
    end
    return self
  end

  local tostring = function()
    result = "E("..self.beats..","..self.steps..") = "
    for i, v in ipairs(self.data) do
      result = result .. v .. " "
    end
    return result
  end
  
  local tableMerge = function(t1, t2)
    for i = 1, #t2 do
      t1[#t1+1] = t2[i]
    end
    return t1
  end

  local buildT = function()
    remainders = {}

    a = self.beats
    b = self.steps - self.beats
    k = min(a, b)
    n = max(a, b)
  
    while k > 1 do
      add(remainders, k)
      a = k
      b = n - k

      k = min(a, b)
      n = max(a, b)
    end
  
    return remainders
  end

  remainders = buildT()
  -- for i, v in ipairs(remainders) do
  --   print("r"..i .. " " .. v)
  -- end

  groups = {}
  for i = 1, self.steps do
    if i <= self.beats then
      groups[i] = {1}
    else
      groups[i] = {0}
    end
  end
  -- printGroups(groups)

  for iRemainder, remainder in ipairs(remainders) do
    for iterIndexGroups = 1, remainder do
      tableMerge(groups[remainder + 1 - iterIndexGroups], groups[#groups])
      deli(groups, #groups)
    end
    -- printGroups(groups)
  end

  for i = 1, #groups do
    for j = 1, #groups[i] do
      self.data[#self.data + 1] = groups[i][j]
    end
  end

  setmetatable(self, {
    __tostring = tostring
  })

  return self
end
