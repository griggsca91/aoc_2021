local strings = {}

function strings.splitchars(s)
	local len = #s
	local result = {}
	for i=1,len do
		result[i] = s:sub(i, i) 
	end

	return result
end

return strings
