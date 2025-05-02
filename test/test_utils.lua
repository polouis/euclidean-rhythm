function add(t, v)
  t[#t + 1] = v
end

function deli(t, i)
  table.remove(t, i)
end

function t()
  return os.clock()
end

function min(x, y)
  return math.min(x, y)
end

function max(x, y)
  return math.max(x, y)
end

function abs(x)
  return math.abs(x)
end
