require "test_utils"
require "track"
require "sequencer"

seq = newSequencer()
seq.play()

while true do
  seq:update()
end
