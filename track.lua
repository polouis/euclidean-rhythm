function newTrack(initialChannel)
  local self = {
    -- private
    stepIndex = 1,
    channel = initialChannel,

    -- public
    sfx = nil,
    mute = false,
    euclideanRhythm = nil,
  }

  local update = function()
    if self.mute then
      return
    end
    if self.sfx == nil then
      return
    end
    if self.euclideanRhythm == nil then
      return
    end
    if self.euclideanRhythm.pattern[self.stepIndex] == 1 then
      sfx(self.sfx, self.channel)
    else
    end
    self.stepIndex = self.stepIndex + 1
    if self.stepIndex > #self.euclideanRhythm.pattern then
      self.stepIndex = 1
    end
  end

  local setEuclideanRhythm = function(steps, beats)
    self.euclideanRhythm = newEuclid(steps, beats)
  end

  local setSfx = function(sfx)
    self.sfx = sfx
  end

  return {
    update = update,
    setEuclideanRhythm = setEuclideanRhythm,
    setSfx = setSfx,
  }
end
