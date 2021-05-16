local Base = require("GameLogic.Battle.Actions.PerformNode.BaseNode")
local DeathNode = class("DeathNode", Base)

DeathNode.nodeType = Base.NodeType.Death

function DeathNode:ctor()
    self.super.ctor(self)
    self.caster = 0
end

return DeathNode
