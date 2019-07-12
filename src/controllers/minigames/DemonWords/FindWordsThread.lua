local receivedLetters, currentPath = ...
local fourLettersCombinations = require(string.format("%smodels.value.FourLettersCombinations", currentPath))
local fiveLettersCombinations = require(string.format("%smodels.value.FiveLettersCombinations", currentPath))
local sixLettersCombinations = require(string.format("%smodels.value.SixLettersCombinations", currentPath))
local allWords = require "models.PortugueseWords"

local function testWord(word)
    if allWords[word] then love.thread.getChannel('findWords'):push(word) end
end

--[[ Here will find words --]]
local letters = {}
for letter in receivedLetters:gmatch(".") do table.insert(letters, letter) end
for _, combination in pairs(fourLettersCombinations) do
    testWord(string.format("%s%s%s%s", letters[combination[1]], letters[combination[2]], letters[combination[3]], letters[combination[4]]))
end
for _, combination in pairs(fiveLettersCombinations) do
    testWord(string.format("%s%s%s%s%s", letters[combination[1]], letters[combination[2]], letters[combination[3]], letters[combination[4]], letters[combination[5]]))
end
for _, combination in pairs(sixLettersCombinations) do
    testWord(string.format("%s%s%s%s%s%s", letters[combination[1]], letters[combination[2]], letters[combination[3]], letters[combination[4]], letters[combination[5]], letters[combination[6]]))                        
end

--love.thread.getChannel('findWords'):push(true)
