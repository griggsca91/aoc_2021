local dbg = require("std.debug")
local strings = require("./lib/strings")

local say = dbg.say
say(strings.splitchars)


function loadInput(fileName)
  file = {}
  for line in io.lines(fileName) do
    table.insert(file, line)
  end

  drawNumbers = split
  bingoBoards = {}

  
end


function main()
  loadInput("day_4/part_1.input")
end


main()
