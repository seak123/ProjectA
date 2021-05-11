local DamageRawAction = {}
local DamageNode = require("GameLogic.Battle.Actions.PerformNode.DamageNode")

function DamageRawAction.Execute(casterUid, targetUid, value)
    local caster = curSession.field:GetUnitByUid(casterUid)
    local target = curSession.field:GetUnitByUid(targetUid)
    target:OnDamage(caster, value)

    --perfrom
    local node = DamageNode.new()
    node.caster = casterUid
    node.target = targetUid
    node.value = value
    return node
end

return DamageRawAction
