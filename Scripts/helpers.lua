local UEHelpers = require("UEHelpers")

---@param Parameters table
---@return nil
function DumpParams(Parameters)
    for _, value in pairs(Parameters) do
        Printf("Value: %s", value)
    end
end

---@param s string|number
---@param ... any
---@return string
---@nodiscard
function Sprintf(s, ...)
    return string.format(s, ...)
end

---@param s string|number
---@param ... any
---@return nil
function Printf(s, ...)
    return print(Sprintf(s, ...))
end

function Console(input)
    local KSL = UEHelpers.GetKismetSystemLibrary(true)
    KSL:ExecuteConsoleCommand(UEHelpers.GetWorldContextObject(), input, UEHelpers.GetPlayerController())
end

function MaterialHandler(input)
    return Sprintf("Material_%s_C", input)
end
