-- summon_unloaded_assets.lua
-- all credits to NarknonTruman

-- We will be using the function summonHandler as a helper to map items easier
-- Instead of using summon Material_HardenedIron_C 1 1000
-- We will use Hardened as a sane default and let the UE4SS handle the summon for us by providing the name

local shouldRun = true


require("helpers")

ItemTable = {
    ["IRON"]       = MaterialHandler("Iron"),
    ["FORGED"]     = MaterialHandler("ForgedIron"),
    ["GALVANIZED"] = MaterialHandler("GalvanizedIron"),
    ["HARDENED"]   = MaterialHandler("HardenedIron"),
    ["SCRAP"]      = MaterialHandler("Scraps"),
    ["LUMENITE"]   = MaterialHandler("LumeniteCrystal"),
    ["CORRUPTED"]  = MaterialHandler("LumeniteCorrupted"),
    ["DUST"]       = MaterialHandler("RelicDust"),
    ["TOME"]       = MaterialHandler("TomeOfKnowledge"),
    -- to get the weapon list, open console UI and regex live view with \.Weapon_((?!\_).)+_C$
    ["GUN"]        = function(input) return Sprintf("Weapon_%s_C", input) end
}



-- Grabs the forwarded material value and sends it to the summon handler
---@param material string
---@param Parameters table
---@return boolean
local function summonHandler(material, Parameters)
    local amt = Parameters[1]
    if amt == nil then amt = 100 end
    if shouldRun == false then return false end

    Console(Sprintf("summon %s 1 %s", material, amt))
    return true
end


-- Register handlers
for key, value in pairs(ItemTable) do
    Printf("[SummonHelper] Registering Console Command Handler to %s", key:lower())
    RegisterConsoleCommandHandler(key:lower(), function(FullCommand, Parameters)
        local material = ""

        if type(value) == "string" then
            material = value
        end
        if type(value) == "function" then
            material = value(Parameters[1])
            if #Parameters > 1 then
                Parameters[1] = Parameters[2]
            else
                Parameters[1] = "1"
            end
        end
        return summonHandler(material, Parameters)
    end)
end
