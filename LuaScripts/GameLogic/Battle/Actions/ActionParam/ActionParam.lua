local ActionParam = {}

ActionParam.ParamType = {
    Path = 0
}

ActionParam[ActionParam.ParamType.Path] = {
    FetchParam = function(paramTable)
        if #paramTable.Path > 0 then
            local path = paramTable.Path[1]
            table.remove(paramTable.Path, 1)
            return true, path
        end
        return false, nil
    end
}

return ActionParam
