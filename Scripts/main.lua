-- Credits for CSV to some awesome russian guys
-- Source: https://docs.google.com/spreadsheets/d/1WhcTTooWZ97vdtiUo03HIOWsuctgQRIlIoqs6_Q5YWE/edit?gid=528614399#gid=528614399
require("helpers")
local parser = require("csvparser")
local types = { "Ammo", "Long Gun", "Bow", "Handgun", "Melee", "Body", "Gloves", "Head", "Legs", "Relic",
    "Amulet", "Ring", "Mutator", "Engram Material", "Currency", "Upgrade Material", "Trait Point", "Consumable",
    "Grenade", "Curative", "Concoction", "Crafting Material", "Special", "Quest Item", "Prism Fragment",
    "Archetype Trait", "Core Trait", "Trait", "Mod", "Skill Trait" }

local csvPath = "Mods/SummonHelper/ItemID.csv"


local table = parser.Csv_to_lua_table_from_path(csvPath)

Printd("SummonHelper active")

RegisterConsoleCommandHandler("SummonHelper", function(_, Parameters, Ar)
    if #Parameters ~= 1 then
        Ar:Log(("Help:"):delim())
        Ar:Log("Choose a type in the params to see available options.")
        Ar:Log("Or use it to search for weapon names.")
        Ar:Log("Once you find the name you want to use, use it as the first parameter (case insensitive)")
        Ar:Log("Following types are available:")
        Ar:Log((""):delim())
        for _, typeValues in pairs(types) do
            Ar:Log(typeValues)
        end
    end

    if #Parameters == 1 then
        for _, value in ipairs(Parameters) do
            for _, v in pairs(table) do
                if v.FName:lower() == value:lower() then
                    Ar:Log(Sprintf("Match found for: %s", value))
                    Ar:Log(Sprintf("Type: %s", v.Type))
                    Ar:Log(Sprintf("FName: %s", v.FName))
                    Ar:Log(Sprintf("summonCommand: %s", v.summonCommand))
                    Ar:Log(Sprintd("Summoning!"))
                    Console(v.summonCommand)
                    return true
                end

                if v.Type:lower():find(value:lower()) then
                    Ar:Log(Sprintf("%s", v.FName))
                elseif v.FName:lower():find(value:lower()) then
                    Ar:Log(Sprintf("%s", v.FName))
                end
            end
        end
    end
    return true
end)
