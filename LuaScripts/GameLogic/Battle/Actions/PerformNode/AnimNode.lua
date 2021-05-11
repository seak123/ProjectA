local Base = require("GameLogic.Battle.Actions.PerformNode.BaseNode")
local AnimNode = class("AnimNode", Base)
local Direction = require("GameLogic.Battle.Map.BattleMap").Direction

AnimNode.nodeType = Base.NodeType.Anim

function AnimNode:ctor()
    self.super.ctor(self)
    self.caster = 0
    self.target = 0
    self.animName = ""
end

return AnimNode
