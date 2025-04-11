function newTrack(initialChannel)
  local self = {
    -- private
    stepIndex = 0,
    channel = initialChannel,

    -- public
    sfx = nil,
    mute = false,
    pattern = nil,
  }

  local update = function()
    if self.mute then
      return
    end
    if self.sfx == nil then
      return
    end
    if self.pattern == nil then
      return
    end
    self.stepIndex = self.stepIndex + 1
    if self.stepIndex > #self.pattern.data then
      self.stepIndex = 1
    end
    if self.pattern.data[self.stepIndex] == 1 then
      printh("    playing step " .. self.stepIndex, "euclid")

      sfx(self.sfx, self.channel)
    else
    end
  end

  local setPattern = function(pattern)
    self.pattern = pattern
  end

  local getPattern = function()
    return self.pattern
  end

  local setSfx = function(sfx)
    self.sfx = sfx
  end

  local getSfx = function()
    return self.sfx
  end

  local setMute = function(mute)
    self.mute = mute
  end
  
  local getMute = function()
    return self.mute
  end

  local getPlayIndex = function()
    return self.stepIndex
  end

  return {
    update = update,
    setPattern = setPattern,
    getPattern = getPattern,
    setSfx = setSfx,
    getSfx = getSfx,
    getMute = getMute,
    setMute = setMute,
    getPlayIndex = getPlayIndex,
  }
end
