local Base = require("GameLogic.Battle.Actions.PerformNode.BaseNode")
local DamageNode = class("DamageNode", Base)

DamageNode.nodeType = Base.NodeType.Damage

function DamageNode:ctor()
    self.super.ctor(self)
    self.caster = 0
    self.target = 0
    self.value = 0
end

return DamageNode
