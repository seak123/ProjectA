local FaceAnimRawAction = {}
local AnimNode = require("GameLogic.Battle.Actions.PerformNode.AnimNode")

function FaceAnimRawAction.Execute(casterUid, targetUid, name)
    local caster = curSession.field:GetUnitByUid(casterUid)
    local target = curSession.field:GetUnitByUid(targetUid)
    local direction = curSession.map.TurnUnitToPoint(caster, target.transform.position)
    caster.transform.direction = direction
    --perfrom
    local node = AnimNode.new()
    node.caster = casterUid
    node.target = targetUid
    node.animName = name

    return node
end

return FaceAnimRawAction
