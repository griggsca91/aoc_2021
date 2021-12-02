
previous = nil
increases = 0

a = {}
i = 0

for line in io.lines("part_2.input") do
  a[i] = tonumber(line)
  i = i + 1
end


local size = #a

local previous = 0
for index = 0, 2 do 
  previous = previous + a[index]
end

for index = 2, size do 
  current = a[index]
  current = current + a[index-1]
  current = current + a[index-2]
  if current > previous then
    increases = increases + 1
  end
  previous = current
end
--[[
for line in io.lines("part_2.input") do
  current = tonumber(line)
  if previous ~= nil and previous < current then
    increases = increases + 1
  end
  previous = current
  io.write(line, "\n")
end

]]--
io.write("Number of increases ", increases, "\n")
