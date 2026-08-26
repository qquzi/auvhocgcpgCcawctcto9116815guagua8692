local insert = table.insert
local remove = table.remove

local Instructions = {}

function Instructions:addInstruction(opName, a, b, c)
    local instructions = self.currentProto.instructions
    local instruction = {opName, a, b, c}

    insert(instructions, instruction)

    return #instructions
end

function Instructions:addInstructions(instructionTable)
    local instructions = self.currentProto.instructions

    for _, instruction in ipairs(instructionTable) do
        insert(instructions, instruction)
    end

    return #instructions
end

function Instructions:changeInstruction(instructionIndex, opName, a, b, c)
    local oldInstruction = self.currentProto.instructions[instructionIndex]

    if not oldInstruction then
        error("Invalid instruction index: " .. tostring(instructionIndex))
    end

    local newInstruction = {
        opName or oldInstruction[1],
        a ~= nil and a or oldInstruction[2],
        b ~= nil and b or oldInstruction[3],
        c ~= nil and c or oldInstruction[4]
    }

    self.currentProto.instructions[instructionIndex] = newInstruction

    return newInstruction
end

function Instructions:changeInstructionOPName(instructionIndex, OPName)
    local instruction = self.currentProto.instructions[instructionIndex]

    if not instruction then
        error("Invalid instruction index: " .. tostring(instructionIndex))
    end

    instruction[1] = OPName
end

function Instructions:changeInstructionA(instructionIndex, A)
    local instruction = self.currentProto.instructions[instructionIndex]

    if not instruction then
        error("Invalid instruction index: " .. tostring(instructionIndex))
    end

    instruction[2] = A
end

function Instructions:changeInstructionB(instructionIndex, B)
    local instruction = self.currentProto.instructions[instructionIndex]

    if not instruction then
        error("Invalid instruction index: " .. tostring(instructionIndex))
    end

    instruction[3] = B
end

function Instructions:changeInstructionC(instructionIndex, C)
    local instruction = self.currentProto.instructions[instructionIndex]

    if not instruction then
        error("Invalid instruction index: " .. tostring(instructionIndex))
    end

    instruction[4] = C
end

function Instructions:getInstruction(instructionIndex)
    return self.currentProto.instructions[instructionIndex]
end

function Instructions:getInstructionCount()
    return #self.currentProto.instructions
end

function Instructions:getInstructionsFromRange(startIndex, endIndex)
    local instructions = self.currentProto.instructions
    local instructionTable = {}

    startIndex = math.max(1, startIndex)
    endIndex = math.min(#instructions, endIndex)

    for index = startIndex, endIndex do
        insert(instructionTable, instructions[index])
    end

    return instructionTable
end

function Instructions:removeInstruction(instructionIndex)
    local instructions = self.currentProto.instructions

    if not instructions[instructionIndex] then
        error("Invalid instruction index: " .. tostring(instructionIndex))
    end

    return remove(instructions, instructionIndex)
end

function Instructions:removeInstructionsFromRange(startIndex, endIndex)
    local instructions = self.currentProto.instructions
    local instructionTable = {}

    startIndex = math.max(1, startIndex)
    endIndex = math.min(#instructions, endIndex)

    if startIndex > endIndex then
        return instructionTable
    end

    for index = startIndex, endIndex do
        insert(instructionTable, instructions[index])
    end

    for index = endIndex, startIndex, -1 do
        remove(instructions, index)
    end

    return instructionTable
end

function Instructions:insertInstruction(instructionIndex, opName, a, b, c)
    local instructions = self.currentProto.instructions

    local instruction = {
        opName,
        a,
        b,
        c
    }

    insert(instructions, instructionIndex, instruction)

    return instructionIndex
end

function Instructions:insertInstructions(instructionIndex, instructionTable)
    local instructions = self.currentProto.instructions

    for index, instruction in ipairs(instructionTable) do
        insert(instructions, instructionIndex + index - 1, instruction)
    end

    return instructionIndex
end

function Instructions:replaceInstructions(startIndex, endIndex, instructionTable)
    self:removeInstructionsFromRange(startIndex, endIndex)
    self:insertInstructions(startIndex, instructionTable)
end

function Instructions:cloneInstruction(instructionIndex)
    local instruction = self.currentProto.instructions[instructionIndex]

    if not instruction then
        error("Invalid instruction index: " .. tostring(instructionIndex))
    end

    return {
        instruction[1],
        instruction[2],
        instruction[3],
        instruction[4]
    }
end

function Instructions:cloneInstructions(startIndex, endIndex)
    local source = self:getInstructionsFromRange(startIndex, endIndex)
    local result = {}

    for _, instruction in ipairs(source) do
        insert(result, {
            instruction[1],
            instruction[2],
            instruction[3],
            instruction[4]
        })
    end

    return result
end

function Instructions:findOpcode(opName, startIndex, endIndex)
    local instructions = self.currentProto.instructions
    local results = {}

    startIndex = startIndex or 1
    endIndex = endIndex or #instructions

    for index = startIndex, endIndex do
        local instruction = instructions[index]

        if instruction and instruction[1] == opName then
            insert(results, index)
        end
    end

    return results
end

function Instructions:findFirstOpcode(opName, startIndex, endIndex)
    local instructions = self.currentProto.instructions

    startIndex = startIndex or 1
    endIndex = endIndex or #instructions

    for index = startIndex, endIndex do
        local instruction = instructions[index]

        if instruction and instruction[1] == opName then
            return index
        end
    end

    return nil
end

function Instructions:forEach(callback)
    local instructions = self.currentProto.instructions

    for index, instruction in ipairs(instructions) do
        callback(instruction, index)
    end
end

return Instructions
