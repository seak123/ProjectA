local Base = require("GameLogic.Battle.Actions.BaseAction")
local Move = class("Move", Base)
local MoveAct = require("GameLogic.Battle.Actions.RawAction.MoveAction")

Move.MoveType = {
    Walk = 1,
    Blink = 2
}

Move.TargetType = {
    Self = 1,
    Enemy = 2
}

Move.Type = Move.MoveType.Walk
Move.Target = Move.TargetType.Self
Move.Distance = 1

function Move:ctor()
end

function Move:Play()
end

return Move
