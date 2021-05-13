local DamageRawAction = {}
local DamageNode = require("GameLogic.Battle.Actions.PerformNode.DamageNode")

function DamageRawAction.Execute(casterUid, targetUid, value, bCompanion,trigger)
    --perfrom
    local node = DamageNode.new()
    node.caster = casterUid
    node.target = targetUid
    node.value = value
    node.event = trigger and trigger.event
    node.delay = trigger and trigger.delay
    curSession.performer:PushNode(node, bCompanion)
    local caster = curSession.field:GetUnitByUid(casterUid)
    local target = curSession.field:GetUnitByUid(targetUid)
    target:OnDamage(caster, value)
    return node
end

return DamageRawAction
