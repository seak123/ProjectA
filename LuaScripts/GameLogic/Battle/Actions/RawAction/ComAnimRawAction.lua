local ComAnimRawAction = {}
local AnimNode = require("GameLogic.Battle.Actions.PerformNode.AnimNode")

function ComAnimRawAction.Execute(casterUid, name, bCompanion, trigger)
    --perfrom
    local node = AnimNode.new()
    node.caster = casterUid
    node.target = 0
    node.animName = name
    node.event = trigger and trigger.event
    node.delay = trigger and trigger.delay
    curSession.performer:PushNode(node, bCompanion)
    return node
end

return ComAnimRawAction
