local PathParam = {}

-- Define
PathParam.Type = {
    Self = 1,
    Friend = 2,
    Enemy = 3
}

-- Param
PathParam.type = PathParam.Type.Self
PathParam.count = 1

-- Interface
function PathParam.FetchParam(paramTable)
    if #paramTable.Paths > 0 then
        local path = paramTable.Paths[1]
        table.remove(paramTable.Paths, 1)
        return true, path
    end
    return false, nil
end

return PathParam
