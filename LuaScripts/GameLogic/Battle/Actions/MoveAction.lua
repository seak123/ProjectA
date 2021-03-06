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
Move.target = UnitParam.Self()
Move.distance = 1

function Move:ctor(vo, subActions)
    self.vo = vo
    self.subActions = subActions
    self.paramTable = self:OrganizeParam()
end

function Move:InputOrder(inputTable)
    local params = {}
    if self.vo.type == Move.Type.Walk then
        local targets = self.paramTable[1]:FetchParam(inputTable)
        local path = self.paramTable[2]:FetchParam(inputTable)
        params = {
            targets = targets,
            path = path
        }
    end
    return self:Play(params)
end

function Move:Play(params, bCompanion, trigger)
    if self.vo.type == Move.Type.Walk then
        MoveRawAct.Execute(params.targets[1], params.path, bCompanion, trigger)
    end
    self:PlaySubAction(params)
    curSession.performer:Fallback()
end

function Move:OrganizeParam()
    self.type = self.GetParam(self.vo, "type")
    self.target = self.GetParam(self.vo, "target")
    self.distance = self.GetParam(self.vo, "distance")

    local paramTable = {}
    if self.type == Move.Type.Walk then
        local param_1 = UnitParam.new()
        param_1.type = self.target.targetType
        param_1.count = self.target.count
        param_1.range = self.target.range
        local param_2 = PathParam.new()
        param_2.count = self.distance
        table.insert(paramTable, param_1)
        table.insert(paramTable, param_2)
    end
    return paramTable
end

return Move
