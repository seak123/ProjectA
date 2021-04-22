local Base = require("GameLogic.Battle.Actions.BaseAction")
local Move = class("Move", Base)
local MoveAct = require("GameLogic.Battle.Actions.RawAction.MoveAction")
local UnitParam = require("GameLogic.Battle.Actions.ActionParam.UnitParam")
local PathParam = require("GameLogic.Battle.Actions.ActionParam.PathParam")

Move.Type = {
    Walk = 1,
    Blink = 2
}

Move.TargetType = {
    Self = 1,
    Enemy = 2
}

Move.type = Move.MoveType.Walk
Move.target = Move.TargetType.Self
Move.distance = 1

function Move:ctor(vo)
    self.paramTable = self:OrganizeParam()
end

function Move:Play(inputTable)
    if self.vo.type == Move.Type.Walk then
        local path = self.paramTable[1]:FetchParam(inputTable)
    end
end

function Move:OrganizeParam()
    local paramTable = {}
    if self.vo.type == Move.Type.Walk then
        local param_1 = PathParam.new()
        param_1.count = self.vo.distance
        local param_2 = UnitParam.new()
        UnitParam.type = UnitParam.Type.Self
        table.insert(paramTable, param_1)
        table.insert(paramTable, param_2)
    end
    return paramTable
end

return Move
