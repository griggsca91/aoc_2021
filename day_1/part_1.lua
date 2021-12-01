previous = nil
increases = 0
for line in io.lines("input.txt") do
  current = tonumber(line)
  if previous ~= nil and previous < current then
    increases = increases + 1
  end
  previous = current
  io.write(line, "\n")
end

io.write("Number of increases ", increases, "\n")
