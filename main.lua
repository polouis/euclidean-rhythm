init = false

function _init()
  seq = newSequencer()
  seq.trackGet(1).setEuclideanRhythm(4, 7)
  seq.trackGet(1).setSfx(0)
  seq.trackGet(2).setEuclideanRhythm(3, 8)
  seq.trackGet(2).setSfx(1)

  uiBpm = newUiNumber(seq.getBpm(), 1, 19, 60, 240, "bpm")
  uiBpm.setState(uiState.Focused)

  seq.play()
  init = true
end

function drawTrack(i, y)
  local track = seq.trackGet(i)
  print("track " .. i, 1, y, 7)
  print("mute: " .. tostring(track.getMute()), 1, y + 6, 7)
  print("euclideanRhythm: " .. track.getEuclideanRhythm().steps .. ", " .. track.getEuclideanRhythm().beats, 1, y + 12, 7)
end

function _draw()
  cls(3)
  print("----------------", 32, 1, 7)
  print("euclidean rhythm", 32, 7, 7)
  print("----------------", 32, 13, 7)
  if not init then
    print("initializing...", 32, 19, 7)
    return
  end
  uiBpm.draw()
  drawTrack(1, 25)
end

function _update()
  seq.update()
  uiBpm.update()
  if uiBpm.getValue() ~= seq.getBpm() then
    seq.setBpm(uiBpm.getValue())
  end
end
