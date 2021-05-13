local Base = require("GameLogic.Battle.Actions.BaseAction")
local Melee = class("MeleeAction", Base)
local FaceAnimRawAct = require("GameLogic.Battle.Actions.RawAction.FaceAnimRawAction")
local UnitParam = require("GameLogic.Battle.Actions.ActionParam.UnitParam")
local PathParam = require("GameLogic.Battle.Actions.ActionParam.PathParam")

function Melee:ctor(vo, subActions)
    self.vo = vo
    self.subActions = subActions
    self.paramTable = self:OrganizeParam()
end

function Melee:InputOrder(inputTable)
    local params = {}

    local targets = self.paramTable[1]:FetchParam(inputTable)

    params = {
        targets = targets
    }

    return self:Play(params)
end

function Melee:Play(params, bCompanion, trigger)
    FaceAnimRawAct.Execute(curSession.stateMachine.curOpUnit.uid, params.targets[1], "Melee", bCompanion, trigger)
    self:PlaySubAction(params)
    curSession.performer:Fallback()
end

function Melee:OrganizeParam()
    self.target = self.GetParam(self.vo, "target")

    local paramTable = {}

    local param_1 = UnitParam.new()
    param_1.type = self.target.targetType
    param_1.count = self.target.count
    param_1.range = self.target.range

    table.insert(paramTable, param_1)

    return paramTable
end

return Melee
