local Base = require("GameLogic.Battle.Actions.BaseAction")
local Damage = class("DamageAction", Base)
local DamageRawAct = require("GameLogic.Battle.Actions.RawAction.DamageRawAction")
local UnitParam = require("GameLogic.Battle.Actions.ActionParam.UnitParam")
local PathParam = require("GameLogic.Battle.Actions.ActionParam.PathParam")

function Damage:ctor(vo)
    self.vo = vo
    self.paramTable = self:OrganizeParam()
end

function Damage:InputOrder(inputTable)
    local params = {}

    local targets = self.paramTable[1]:FetchParam(inputTable)

    params = {
        targets = targets
    }

    return self:Play(params)
end

function Damage:Play(params, bcompanion)
    local node = DamageRawAct.Execute(curSession.stateMachine.curOpUnit.uid, params.targets[1], "Melee")
    curSession.performer:PushNode(node, bcompanion)
    self:PlaySubAction(params)
    curSession.performer:Fallback()

    return node
end

function Damage:OrganizeParam()
    self.target = self.GetParam(self.vo, "target")

    local paramTable = {}

    local param_1 = UnitParam.new()
    UnitParam.type = self.target.targetType
    UnitParam.count = self.target.count
    UnitParam.range = self.target.range

    table.insert(paramTable, param_1)

    return paramTable
end

return Damage
