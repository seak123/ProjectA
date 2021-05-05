local Base = require("GameLogic.Battle.Actions.ActionParam.BaseParam")
local PathParam = class("PathParam",Base)

PathParam.Type = {
    WalkPath = 1,
}

function PathParam:ctor()
    -- Param
    self.taskType = Base.TaskType.Path
    self.type = PathParam.Type.WalkPath
    self.count = 1
end

-- Interface
function PathParam:FetchParam(paramTable)
    if #paramTable.Paths > 0 then
        local path = paramTable.Paths[1]
        table.remove(paramTable.Paths, 1)
        return true, path
    end
    return false, nil
end

return PathParam
