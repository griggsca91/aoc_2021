local dbg = require("std.debug")

local say = dbg.say

function _86or64()
    if(0xfffffffff==0xffffffff) then return 32 else return 64 end
end
	
function splitchars(s)
	local len = #s
	local result = {}
	for i=1,len do
		result[i] = s:sub(i, i) 
	end

	return result
end

local parsedLines = {}

for line in io.lines("part_2.input") do
	local chars = splitchars(line)
	table.insert(parsedLines, chars)
end
say("parsedLines", parsedLines)

local bitSize = #parsedLines[1]

function filter(t, bitPosition, bit)
	filtered = {}
	for key, value in ipairs(t) do
		if value[bitPosition] == bit then
			table.insert(filtered, value)	
		end
	end
	return filtered
end

function table.clone(org)
  return {table.unpack(org)}
end

local oxygenData = table.clone(parsedLines)
local c02Data = table.clone(parsedLines)

for i=1, bitSize do

	local ones = 0
	local zeros = 0
	say("#oxygenData", #oxygenData)
	for _, line in ipairs(oxygenData) do
		say("oxygen line", line)
		if line[i] == "1" then 
			ones = ones + 1
		else
			zeros = zeros + 1
		end
	end
	bit = ones >= zeros and "1" or "0"
	oxygenData = filter(oxygenData, i, bit)
	say("------------------")
end

for i=1, bitSize do

	local ones = 0
	local zeros = 0
	say("#c02Data", #c02Data)
	if #c02Data == 1 then 
		break
	end
	for _, line in ipairs(c02Data) do
		say("c02 line", line)
		if line[i] == "1" then 
			ones = ones + 1
		else
			zeros = zeros + 1
		end
	end
	bit = math.min(ones, zeros) == zeros and "0" or "1"
	c02Data = filter(c02Data, i, bit)
	say("------------------")
end

say("after filter oxygenData", oxygenData)
say("after filter c02Data", c02Data)

function stringToBinary(t)
	result = 0x0 
	size = #t
	for index, bit in ipairs(t) do
		if bit == "1" then 
			result = result + 1
		end
		if index ~= size then
			result = result << 1
		end
	end
	return result
end

oxygenGenerator = stringToBinary(oxygenData[1])
c02ScrubberRating = stringToBinary(c02Data[1])

say("Oxygen Generator", oxygenGenerator)
say("C02", c02ScrubberRating)
say("result", oxygenGenerator * c02ScrubberRating)
