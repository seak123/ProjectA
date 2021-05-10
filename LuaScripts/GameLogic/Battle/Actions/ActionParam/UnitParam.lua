local Base = require("GameLogic.Battle.Actions.ActionParam.BaseParam")
local UnitParam = class("UnitParam", Base)

-- Define
UnitParam.Type = {
    Self = 1,
    Friend = 2,
    Enemy = 3
}

UnitParam.Self = function()
    return {
        targetType = UnitParam.Type.Self,
        count = 1,
        range = 0
    }
end

UnitParam.Enemy = function(num, dis)
    return {
        targetType = UnitParam.Type.Enemy,
        count = num,
        range = dis
    }
end

UnitParam.Friend = function(num, dis)
    return {
        targetType = UnitParam.Type.Enemy,
        count = num,
        range = dis
    }
end

function UnitParam:ctor()
    -- Param
    self.taskType = Base.TaskType.Target
    self.type = UnitParam.Type.Self
    self.count = 1
    self.range = 0
end

-- Interface
function UnitParam:FetchParam(InputTable)
    if #InputTable.units > 0 then
        local result = {}
        for i = 1, self.count do
            local unit = InputTable.units[1]
            table.insert(result, unit)
            table.remove(InputTable.units, 1)
        end

        return result, true
    end
    return nil, false
end

return UnitParam
