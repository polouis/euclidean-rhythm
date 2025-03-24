init = false
local uiTracks = {}

function _init()
  seq = newSequencer()

  for i = 1, 4 do
    seq.trackGet(i).setPattern(newEuclid(0, 0))
    seq.trackGet(i).setSfx(0)

    local uiTrack = {}    
    uiTrack["sfx"] = newUiNumber(seq.trackGet(i).getSfx(), 1, 19 + i * 6, 0, 63, "sfx")
    uiTrack["beats"] = newUiNumber(seq.trackGet(i).getSfx(), 1 + 4*6, 19 + i * 6, 0, 32, "beats")
    uiTrack["steps"] = newUiNumber(seq.trackGet(i).getSfx(), 1 + 4*6 + 4 + 4*6 + 4, 19 + i * 6, 0, 32, "steps")
    add(uiTracks, uiTrack)
  end

  seq.trackGet(1).setPattern(newEuclid(4, 7))
  seq.trackGet(2).setPattern(newEuclid(3, 8))
  uiTracks[1].sfx.setValue(1)
  uiTracks[1].beats.setValue(4)
  uiTracks[1].steps.setValue(7)
  uiTracks[2].beats.setValue(3)
  uiTracks[2].steps.setValue(8)

  uiBpm = newUiNumber(seq.getBpm(), 1, 19, 60, 240, "bpm")
  uiBpm.setState(uiState.Focused)

  seq.play()
  init = true
end

function _draw()
  cls(uiColor.background)
  print("----------------", 32, 1, uiColor.text)
  print("euclidean rhythm", 32, 7, uiColor.text)
  print("----------------", 32, 13, uiColor.text)
  if not init then
    print("initializing...", 32, 19, uiColor.text)
    return
  end
  uiBpm.draw()
  for i = 1, 4 do
    uiTracks[i].sfx.draw()
    uiTracks[i].beats.draw()
    uiTracks[i].steps.draw()
  end
end

function _update()
  seq.update()
  uiBpm.update()
  if uiBpm.getValue() ~= seq.getBpm() then
    seq.setBpm(uiBpm.getValue())
  end

  for i = 1, 4 do
    if uiTracks[i].sfx.getValue() ~= seq.trackGet(i).getSfx() then
      seq.trackGet(i).setSfx(uiTracks[i].sfx.getValue())
    end

    if uiTracks[i].beats.getValue() ~= seq.trackGet(i).getPattern().beats then
      seq.trackGet(i).setPattern(newEuclid(uiTracks[i].beats.getValue(), uiTracks[i].steps.getValue()))
    end

    local actualSteps = seq.trackGet(i).getPattern().steps
    local desiredSteps = uiTracks[i].steps.getValue()
    if actualSteps ~= desiredSteps then
      -- Beat count cannot be greater than step count
      if uiTracks[i].beats.getValue() > desiredSteps then
        uiTracks[i].beats.setValue(desiredSteps)
      end
      -- If step count changes, max beat count must be changed too
      uiTracks[i].beats.setMax(desiredSteps)
      seq.trackGet(i).setPattern(newEuclid(uiTracks[i].beats.getValue(), desiredSteps))
    end

  end

end
