local this = {}
local ActionType = require("GameLogic.Battle.Actions.BaseAction").ActionType
local Move = require("GameLogic.Battle.Actions.Move")

this.Cards = {
    [1] = {
        Name = "移动",
        Actions = {
            {
                ActionType = ActionType.Move,
                ActionParams = {
                    Type = Move.MoveType.Walk,
                    Target = Move.TargetType.Self,
                    Distance = 3
                }
            },
            {}
        }
    }
}

return this
