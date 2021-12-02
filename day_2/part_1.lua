
function string:split(delimiter)
    result = {};
    for match in (self..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

depth = 0
horizontal = 0

local cases = 
{
  ["forward"] = function(distance)
    horizontal = horizontal + tonumber(distance)
  end,
  ["down"] = function(distance)
    print("down distance", distance, "current depth", depth)
    depth = depth + tonumber(distance)
  end,
  ["up"] = function(distance)
    print("up distance", distance, "current depth", depth, "tonumber(distance)", tonumber(distance), tonumber(distance) - depth)
    depth = depth - tonumber(distance)
  end
}

for line in io.lines("part_1.input") do
  local args = line:split(" ")
  local command = args[1]
  local distance = args[2]

  local func = cases[command]
  if (func) then 
    func(distance)
  end
  print("command ", command, "distance", distance, "horizontal", horizontal, "depth", depth)
end


print("Total depth ", depth, " horizontal ", horizontal, " multiplied ", horizontal * depth)

