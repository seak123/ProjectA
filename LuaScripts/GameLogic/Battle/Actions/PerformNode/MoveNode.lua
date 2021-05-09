local Base = require("GameLogic.Battle.Actions.PerformNode.BaseNode")
local MoveNode = class("MoveNode", Base)
local Direction = require("GameLogic.Battle.Map.BattleMap").Direction

MoveNode.nodeType = Base.NodeType.Move

function MoveNode:ctor()
    self.super.ctor(self)
    self.caster = 0
    self.direction = Direction.North
end

return MoveNode
