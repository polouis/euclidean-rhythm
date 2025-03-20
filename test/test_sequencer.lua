require "test/test_utils"
require "sound/track"
require "sound/sequencer"

seq = newSequencer()
seq.play()

while true do
  seq:update()
end
