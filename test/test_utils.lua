function add(t, v)
  t[#t + 1] = v
end

function deli(t, i)
  table.remove(t, i)
end

function t()
  return os.clock()
end
