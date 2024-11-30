local UEHelpers = require("UEHelpers")

---@param Parameters table
---@return nil
function DumpParams(Parameters)
    for key, value in pairs(Parameters) do
        Printf("Key: %s Value: %s", key, value)
    end
end

-- Plain replacement (all characters are non-magic)
function string:replace(substring, replacement, n)
    return (self:gsub(substring:gsub("%p", "%%%0"), replacement:gsub("%%", "%%%%"), n))
end

function string:delim()
    local newSelf = "[SummonHelper] ".. self .. "\n%s"
    self = newSelf
    return (self:format("============"))
end

function KVIter(as, bs)
    local aIter, bIter = as:gmatch('([^,]*)'), bs:gmatch('([^,]*)')
    return function() return aIter(), bIter() end
end

function DumpTable(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. DumpTable(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

---@param s string|number
---@param ... any
---@return string
---@nodiscard
function Sprintf(s, ...)
    return string.format(s, ...)
end


--- Returns a string with a new line and a delimiter
---@param s any
function Sprintd(s, ...)
    return string.format(s, ...):delim()
end

---@param s string|number
---@param ... any
---@return nil
function Printf(s, ...)
    return print(Sprintf(s, ...))
end

---@param s string|number
---@param ... any
---@return nil
function Printd(s, ...)
    return print(Sprintf(s, ...):delim())
end


function Console(input)
    local KSL = UEHelpers.GetKismetSystemLibrary(true)
    KSL:ExecuteConsoleCommand(UEHelpers.GetWorldContextObject(), input, UEHelpers.GetPlayerController())
end

function MaterialHandler(input)
    return Sprintf("Material_%s_C", input)
end
