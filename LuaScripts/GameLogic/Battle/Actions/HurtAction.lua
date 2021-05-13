local Base = require("GameLogic.Battle.Actions.BaseAction")
local Hurt = class("HurtAction", Base)
local ComAnimRawAct = require("GameLogic.Battle.Actions.RawAction.ComAnimRawAction")
local UnitParam = require("GameLogic.Battle.Actions.ActionParam.UnitParam")
local PathParam = require("GameLogic.Battle.Actions.ActionParam.PathParam")

Hurt.SourceType = {
    Unit = 1,
    Ground = 2
}

-- default value
Hurt.sourceType = Hurt.SourceType.Unit
Hurt.source = 0

function Hurt:ctor(vo, subActions)
    self.vo = vo
    self.subActions = subActions
    self.paramTable = self:OrganizeParam()
end

function Hurt:InputOrder(inputTable)
    local params = {}

    local targets = self.paramTable[1]:FetchParam(inputTable)

    params = {
        targets = targets
    }

    return self:Play(params)
end

function Hurt:Play(params, bCompanion, trigger)
    ComAnimRawAct.Execute(curSession.stateMachine.curOpUnit.uid, "Hurt", bCompanion, trigger)
    self:PlaySubAction(params)
    curSession.performer:Fallback()
end

function Hurt:OrganizeParam()
    local paramTable = {}

    return paramTable
end

return Hurt
