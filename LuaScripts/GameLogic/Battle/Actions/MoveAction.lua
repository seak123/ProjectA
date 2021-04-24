local Base = require("GameLogic.Battle.Actions.BaseAction")
local Move = class("MoveAction", Base)
local MoveRawAct = require("GameLogic.Battle.Actions.RawAction.MoveRawAction")
local UnitParam = require("GameLogic.Battle.Actions.ActionParam.UnitParam")
local PathParam = require("GameLogic.Battle.Actions.ActionParam.PathParam")

Move.Type = {
    Walk = 1,
    Blink = 2
}

-- default value
Move.type = Move.Type.Walk
Move.target = Base.TargetType.Self
Move.distance = 1

function Move:ctor(vo)
    self.vo = vo
    self.paramTable = self:OrganizeParam()
end

function Move:Play(inputTable)
    if self.vo.type == Move.Type.Walk then
        local path = self.paramTable[1]:FetchParam(inputTable)
        local target = self.paramTable[2]:FetchParam(inputTable)
        MoveRawAct.Execute(target, path)
    end
end

function Move:OrganizeParam()
    local paramTable = {}
    if self.vo.type == Move.Type.Walk then
        local param_1 = UnitParam.new()
        UnitParam.type = UnitParam.Type.Self
        local param_2 = PathParam.new()
        param_1.count = self.vo.distance
        table.insert(paramTable, param_1)
        table.insert(paramTable, param_2)
    end
    return paramTable
end

return Move
