local receivedLetters = ...
print(receivedLetters)
local allWords = require "models.PortugueseWords"

local function testWord(word)
    if allWords[word] then love.thread.getChannel('findWords'):push(word); print(word) end
end

--[[ Here will find words --]]
local letters = {}
for letter in receivedLetters:gmatch(".") do table.insert(letters, letter) end
for firstCount = 1, #letters do
    for secondCount = 1, #letters do
        for thirdCount = 1, #letters do
            for fourthCount = 1, #letters do
                testWord(string.format("%s%s%s%s", letters[firstCount], letters[secondCount], letters[thirdCount], letters[fourthCount]))
                for fifthCount = 1, #letters do
                    testWord(string.format("%s%s%s%s%s", letters[firstCount], letters[secondCount], letters[thirdCount], letters[fourthCount], letters[fifthCount]))
                    for sixCount = 1, #letters do
                        testWord(string.format("%s%s%s%s%s%s", letters[firstCount], letters[secondCount], letters[thirdCount], letters[fourthCount], letters[fifthCount], letters[sixCount]))                        
                    end
                end
            end
        end
    end
end
print("FINISHED")
love.thread.getChannel('findWords'):push(true)
