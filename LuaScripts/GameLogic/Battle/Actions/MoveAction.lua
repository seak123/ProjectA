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

function Move:ctor(vo)
    self.vo = vo
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

function Move:Play(params)
    local node
    if self.vo.type == Move.Type.Walk then
        node = MoveRawAct.Execute(params.targets[1], params.path)
    end
    self:PlaySubAction(node, params)
    return node
end

function Move:OrganizeParam()
    self.type = self.GetParam(self.vo, "type")
    self.target = self.GetParam(self.vo, "target")
    self.distance = self.GetParam(self.vo, "distance")

    local paramTable = {}
    if self.type == Move.Type.Walk then
        local param_1 = UnitParam.new()
        UnitParam.type = self.target.targetType
        UnitParam.count = self.target.count
        UnitParam.range = self.target.range
        local param_2 = PathParam.new()
        param_2.count = self.distance
        table.insert(paramTable, param_1)
        table.insert(paramTable, param_2)
    end
    return paramTable
end

return Move
