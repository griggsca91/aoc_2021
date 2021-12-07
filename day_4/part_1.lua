local dbg = require("std.debug")
local strings = require("./lib/strings")
local stringx = require("pl.stringx")
local pretty = require("pl.pretty")
local tablex = require("pl.tablex")

local say = dbg.say
say(strings.splitchars)


function isBingoBoardComplete(bingoBoard, row, column) 
	row = row or 1
	column = column or 1
	local columnSize = #bingoBoard
	local rowSize = #bingoBoard[1]
	say("checking if board is complete", row, column, rowSize, columnSize)
	-- we attempted to check out side of bounds, that means that we should have a completed column or row
	if row > rowSize or column > columnSize then 
		return true
	end

	local newRow = row
	while newRow < rowSize do
		if bingoBoard[newRow][column].found == true then
			-- move down one row to see if column is completed
			if isBingoBoardComplete(bingoBoard, newRow+1, column) then
				return true
				-- move over one column to see if row is completed
			elseif isBingoBoardComplete(bingoBoard, newRow, column+1) then
				return true
			end
		end
		newRow = newRow + 1
	end

	local newColumn = column
	while newColumn < columnSize do
		if bingoBoard[row][newColumn].found == true then
			-- move down one row to see if column is completed
			if isBingoBoardComplete(bingoBoard, row+1, newColumn) then
				return true
				-- move over one column to see if row is completed
			elseif isBingoBoardComplete(bingoBoard, row, newColumn+1) then
				return true
			end
		end
		newColumn = newColumn + 1

	end

	
	return false 
end


function loadInput(fileName)
  local file = {}
  for line in io.lines(fileName) do
    table.insert(file, line)
  end

  local drawNumbers = stringx.split(file[1], ",")
  say(drawNumbers)
  local bingoBoards = {}

  
  local currentBingoBoard = {}
 
  for i=3, #file do
	  local line = file[i]
	  if line == "" then 
		  table.insert(bingoBoards, currentBingoBoard)
		  currentBingoBoard = {}
		  goto continue 
	  end 

	  local bingoBoardLine = tablex.imap(function(v)
		  local ret = {
			  value = v,
			  found = false
		  }

		  return ret
	  end, stringx.split(line))

	  table.insert(currentBingoBoard, bingoBoardLine)

	  ::continue::
  end

  table.insert(bingoBoards, currentBingoBoards)

  return bingoBoards, drawNumbers
end

function markNumber(bingoBoard, number)
	for rIndex, row in ipairs(bingoBoard) do
		for cIndex, cell in ipairs(row) do
			if cell.value == number then
				cell.found = true
			end
		end
	end
end

function scoreBoard(bingoBoard) 
	local sum = 0
	for _, row in ipairs(bingoBoard) do
		for _, cell in ipairs(row) do
			say("cell", cell)
			if cell.found == false then
				sum = sum + tonumber(cell.value)
			end
		end
	end
	return sum
end

function printBingoBoard(bingoBoard)
	for _, row in ipairs(bingoBoard) do
		for _, cell in ipairs(row) do
			if cell.found == true then 
				local space = "  "
				if tonumber(cell.value) < 10 then
					space = space .. " "
				end
				io.write(space, cell.value)
			else
				io.write("    ")
			end
		end
		io.write("\n")
	end
end


function main()
  local bingoBoards, drawNumbers = loadInput("day_4/part_1.input")
  for _, value in ipairs(drawNumbers) do
	  for index, bingoBoard in ipairs(bingoBoards) do
		  markNumber(bingoBoard, value)
		  say("==============")
		  say("board index", index)
		  printBingoBoard(bingoBoard)
		  say("==============")
		  if isBingoBoardComplete(bingoBoard) then
			  local score = scoreBoard(bingoBoard)
			--  say(pretty.write(bingoBoard))
			say("board index", index)
				printBingoBoard(bingoBoard)
			  say("score", score, "last number", value, "input", score * value)
			  return
		  end
	  end
  end
end


main()
