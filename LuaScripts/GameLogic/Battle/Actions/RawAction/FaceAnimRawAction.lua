local FaceAnimRawAction = {}
local AnimNode = require("GameLogic.Battle.Actions.PerformNode.AnimNode")

function FaceAnimRawAction.Execute(casterUid, targetUid, name, bCompanion, trigger)
    local caster = curSession.field:GetUnitByUid(casterUid)
    local target = curSession.field:GetUnitByUid(targetUid)
    local direction = curSession.map.TurnUnitToPoint(caster, target.transform.position)
    caster.transform.direction = direction
    --perfrom
    local node = AnimNode.new()
    node.caster = casterUid
    node.target = targetUid
    node.animName = name
    node.event = trigger and trigger.event
    node.delay = trigger and trigger.delay
    curSession.performer:PushNode(node, bCompanion)
    return node
end

return FaceAnimRawAction
