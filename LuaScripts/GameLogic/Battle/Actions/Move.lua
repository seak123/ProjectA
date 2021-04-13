local Base = require("GameLogic.Battle.Actions.BaseAction")
local Move = class("Move", Base)

Move.MoveType = {
    Walk = 1,
    Blink = 2
}

function Move:ctor()
end

function Move:Execute(caster,path)
end

return Move
