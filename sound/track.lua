function newTrack(initialChannel)
  local self = {
    -- private
    playIndex = 0,
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
    self.playIndex = self.playIndex + 1
    if self.playIndex > #self.pattern.data then
      self.playIndex = 1
    end
    if self.pattern.data[self.playIndex] == 1 then
      sfx(self.sfx, self.channel)
    else
    end
  end

  self.update = update

  return self

end
