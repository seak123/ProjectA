local Base = require("GameLogic.Battle.Actions.BaseAction")
local Attack = class("AttackAction", Base)
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
        local target = self.paramTable[1]:FetchParam(inputTable)[1]
        local path = self.paramTable[2]:FetchParam(inputTable)
        MoveRawAct.Execute(target, path)
    end
end

function Move:OrganizeParam()
    self.type = self.GetParam(self.vo, "type")
    self.target = self.GetParam(self.vo, "target")
    self.distance = self.GetParam(self.vo, "distance")

    local paramTable = {}
    if self.type == Move.Type.Walk then
        local param_1 = UnitParam.new()
        UnitParam.type = UnitParam.Type.Self
        local param_2 = PathParam.new()
        param_2.count = self.distance
        table.insert(paramTable, param_1)
        table.insert(paramTable, param_2)
    end
    return paramTable
end

return Move