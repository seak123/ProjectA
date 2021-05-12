local ComAnimRawAction = {}
local AnimNode = require("GameLogic.Battle.Actions.PerformNode.AnimNode")

function ComAnimRawAction.Execute(casterUid, name)
    --perfrom
    local node = AnimNode.new()
    node.caster = casterUid
    node.target = targetUid
    node.animName = name
    return node
end

return ComAnimRawAction
