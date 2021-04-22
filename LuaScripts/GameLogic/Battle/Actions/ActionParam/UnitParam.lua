local UnitParam = {}

-- Define
UnitParam.Type = {
    Self = 1,
    Friend = 2,
    Enemy = 3
}

-- Param
UnitParam.type = UnitParam.Type.Self
UnitParam.count = 1

-- Interface
function UnitParam.FetchParam(paramTable)
    if #paramTable.Units > 0 then
        local path = paramTable.Units[1]
        table.remove(paramTable.Units, 1)
        return true, path
    end
    return false, nil
end

return UnitParam
