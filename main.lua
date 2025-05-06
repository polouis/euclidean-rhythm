local init = false
local uiTracks = {}
local focusManager = nil

function _init()
  seq = newSequencer()
  focusManager = newUiFocusManager()
  local grid = {}

  local headerHeight = 19
  uiBpm = newUiNumber(200, 0, headerHeight, 60, 240, "bpm")
  uiBpm.state = uiState.Focused
  add(grid, {uiBpm})

  for i = 1, 4 do
    seq.tracks[i].pattern = newEuclid(0, 0)
    seq.tracks[i].sfx = 0

    local uiTrack = {}    
    uiTrack["sfx"] = newUiNumber(seq.tracks[i].sfx, 0, headerHeight + i * uiParameters.charHeightSpaced, 0, 3, "sfx")
    uiTrack["beats"] = newUiNumber(seq.tracks[i].sfx, 6*uiParameters.charWidthSpaced, headerHeight + i * uiParameters.charHeightSpaced, 0, 0, "beats")
    uiTrack["steps"] = newUiNumber(seq.tracks[i].sfx, 15*uiParameters.charWidthSpaced, headerHeight + i * uiParameters.charHeightSpaced, 0, 32, "steps")
    uiTrack["pattern"] = newUiPattern(0, headerHeight + 5*uiParameters.charHeightSpaced + i * uiParameters.trackHeightSpaced)
    add(uiTracks, uiTrack)

    add(grid, {uiTrack["sfx"], uiTrack["beats"], uiTrack["steps"]})
  end

  uiTracks[1].sfx.value = 0
  uiTracks[1].beats.value = 6
  uiTracks[1].beats.max = 16
  uiTracks[1].steps.value = 16
  uiTracks[2].sfx.value = 1
  uiTracks[2].beats.value = 2
  uiTracks[2].beats.max = 8
  uiTracks[2].steps.value = 8
  uiTracks[3].sfx.value = 2
  uiTracks[3].beats.value = 1
  uiTracks[3].beats.max = 3
  uiTracks[3].steps.value = 3

  focusManager.setGrid(grid)
  seq.play()
  init = true
end

function _draw()
  cls(uiColor.background)
  print("----------------", 32, 1, uiColor.text)
  print("euclidean rhythm", 32, 7, uiColor.text)
  print("----------------", 32, 13, uiColor.text)
  if not init then
    return
  end
  uiBpm.draw()
  for i = 1, 4 do
    uiTracks[i].sfx.draw()
    uiTracks[i].beats.draw()
    uiTracks[i].steps.draw()
    uiTracks[i].pattern.draw()
  end
end

function _update()
  focusManager.update()
  
  uiBpm.update()
  if uiBpm.value ~= seq.bpm then
    seq.bpm  = uiBpm.value
  end
  
  for i = 1, 4 do
    if uiTracks[i].pattern.playIndex ~= seq.tracks[i].playIndex then
      uiTracks[i].pattern.playIndex = seq.tracks[i].playIndex
    end
    
    uiTracks[i].sfx.update()
    uiTracks[i].beats.update()
    uiTracks[i].steps.update()

    if uiTracks[i].sfx.value ~= seq.tracks[i].sfx then
      seq.tracks[i].sfx = uiTracks[i].sfx.value
    end

    if uiTracks[i].beats.value ~= seq.tracks[i].pattern.beats then
      seq.tracks[i].pattern = newEuclid(uiTracks[i].beats.value, uiTracks[i].steps.value)
      uiTracks[i].pattern.setPattern(seq.tracks[i].pattern)
    end

    local actualSteps = seq.tracks[i].pattern.steps
    local desiredSteps = uiTracks[i].steps.value
    if actualSteps ~= desiredSteps then
      -- Beat count cannot be greater than step count
      if uiTracks[i].beats.value > desiredSteps then
        uiTracks[i].beats.value = desiredSteps
      end
      -- If step count changes, max beat count must be changed too
      uiTracks[i].beats.max = desiredSteps
      seq.tracks[i].pattern = newEuclid(uiTracks[i].beats.value, desiredSteps)
      uiTracks[i].pattern.setPattern(seq.tracks[i].pattern)
    end

  end

  seq.update()

end
