require "test/test_utils"
require "sound/euclid"

function printGroups(groups)
  result = ""
  for i = 1, #groups do
    for j = 1, #groups[i] do
      result = result .. groups[i][j] .. " "
    end
    result = result .. "|"
  end
  print(result)
end

function tableEquals(t1, t2)
  if #t1 ~= #t2 then
    return false
  end
  for i = 1, #t1 do
    if t1[i] ~= t2[i] then
      return false
    end
  end
  return true
end

e3_8 = newEuclid(3, 8)
print(e3_8)
if not tableEquals(e3_8.data, {1, 0, 0, 1, 0, 0, 1, 0}) then
  error("E(3,8) failed")
end

e5_8 = newEuclid(5, 8)
print(e5_8)
if not tableEquals(e5_8.data, {1, 0, 1, 1, 0, 1, 1, 0}) then
  error("E(5,8) failed")
end

e5_16 = newEuclid(5, 16)
print(e5_8)
if not tableEquals(e5_16.data, {1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0}) then
  error("E(5,16) failed")
end

e4_9 = newEuclid(4, 9)
print(e4_9)
if not tableEquals(e4_9.data, {1, 0, 1, 0, 1, 0, 1, 0, 0}) then
  error("E(4,9) failed")
end

e2_7 = newEuclid(2, 7)
print(e2_7)
if not tableEquals(e2_7.data, {1, 0, 0, 1, 0, 0, 0}) then
  error("E(2,7) failed")
end
