local MoveRawAction = {}
local MoveNode = require("GameLogic.Battle.Actions.PerformNode.MoveNode")

function MoveRawAction.Execute(uid, path)
    local target = curSession.field:GetUnitByUid(uid)
    local rootNode, curNode
    for i = 1, #path do
        curSession.map:MoveUnit(target, path[i])
        --perfrom
        local node = MoveNode.new()
        node.caster = uid
        node.direction = target.transform.direction
        if i == 1 then
            rootNode = node
        else
            curNode:AddFollower(node)
        end
        curNode = node
    end
    return rootNode
end

return MoveRawAction
