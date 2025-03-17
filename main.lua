function _init()
  print("init")
  seq = newSequencer()
  seq.trackGet(1).setEuclideanRhythm(4, 7)
  seq.trackGet(1).setSfx(0)
  seq.trackGet(2).setEuclideanRhythm(3, 8)
  seq.trackGet(2).setSfx(1)
  seq.play()
end

function _update()
  seq.update()
end
