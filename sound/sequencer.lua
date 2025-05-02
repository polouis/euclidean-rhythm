function newSequencer()
  local self = {
    bpm = 120,
    nextStepTime = nil,
    tracks = {
      newTrack(0),
      newTrack(1),
      newTrack(2),
      newTrack(3),
    },
  }

  local stepDuration = function()
    return 60 / self.bpm
  end

  local play = function()
    self.nextStepTime = 0
  end

  local update = function()
    if self.nextStepTime == nil then
      return
    end
    if t() >= self.nextStepTime then
      for i, track in ipairs(self.tracks) do
        track:update()
      end
      self.nextStepTime = t() + stepDuration()
    end
  end

  self.play = play
  self.update = update
  return self

end
