local MoveRawAction = {}
local MoveNode = require("GameLogic.Battle.Actions.PerformNode.MoveNode")

function MoveRawAction.Execute(uid, path)
    local target = curSession.field:GetUnitByUid(uid)
    for i = 1, #path do
        curSession.map:MoveUnit(target, path[i])
        --perfrom
        local node = MoveNode.new()
        node.caster = uid
        node.direction = target.transform.direction
        curSession.performer:PushNode(node)
    end
end

return MoveRawAction
