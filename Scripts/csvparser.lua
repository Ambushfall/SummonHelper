CSVPARSER = {}

--- func desc
---@param path string
function CSVPARSER.Csv_to_lua_table_from_path(path)
    local output_table = {}
    local i = 1
    local csv = require("csv")

    local f = csv.open(path, {
        ["header"] = true
    })

    if f ~= nil then
        for fields in f:lines() do
            output_table[i] = {}
            -- print("test", DumpTable(fields))
            for k, v in pairs(fields) do
                if v ~= "" then
                    if k == "BP Name" then
                        k = "FName"
                    end

                    if k == "Force Spawn Command (Full Patch)" then
                        k = "summonCommand"
                    end

                    -- print(v)
                    output_table[i][k] = v
                end
            end
            i = i + 1
        end
    end

    return output_table
end

return CSVPARSER
