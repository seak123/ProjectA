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
    local target, path = nil
    if self.type == Move.MoveType.Walk then
        MoveAct.Execute(target, path)
    elseif self.type == Move.MoveType.Blink then
    end
end

return Move
