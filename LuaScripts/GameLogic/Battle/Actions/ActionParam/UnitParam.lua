local Base = require("GameLogic.Battle.Actions.ActionParam.BaseParam")
local UnitParam = class("UnitParam",Base)

-- Define
UnitParam.Type = {
    Self = 1,
    Friend = 2,
    Enemy = 3
}

function UnitParam:ctor()
    -- Param
    self.taskType = Base.TaskType.Target
    self.type = UnitParam.Type.Self
    self.count = 1
end

-- Interface
function UnitParam:FetchParam(InputTable)
    if #InputTable.Units > 0 then
        local result = {}
        for i = 1, self.count do
            local unit = InputTable.Units[1]
            table.insert(result, unit)
            table.remove(InputTable.Units, 1)
        end

        return true, result
    end
    return false, nil
end

return UnitParam
