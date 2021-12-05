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

local ones = {}
local zeros = {}

for line in io.lines("part_1.input") do
	local chars = splitchars(line)
	for key, value in ipairs(chars) do
		if value == "1" then 
			ones[key] = (ones[key] or 0) + 1
		else
			zeros[key] = (zeros[key] or 0) + 1
		end
	end
end

local bitSize = #ones
local gamma = 0
local epsilon = 0

for i=1,bitSize do 

	say("gamma before", gamma)
	if ones[i] > zeros[i] then
		print("1")
		gamma = gamma + 1
		say("gamma after addition", gamma)
	else
		print("0")
	end

	if i ~= bitSize then
		gamma = gamma << 1
	end
end

function getEpsilon(gamma, bitSize)
	return ~gamma << _86or64() - bitSize >> _86or64() - bitSize
end

epsilon = getEpsilon(gamma, bitSize)

say("ones", ones)
say("zeros", zeros)
say("gamma", gamma)
say("epsilon", epsilon)
say("result", gamma * epsilon)
