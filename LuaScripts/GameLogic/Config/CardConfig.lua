local this = {}
local ActionType = require("GameLogic.Battle.Actions.BaseAction").ActionType

this.Cards = {
    [1] = {
        Name = "移动",
        Actions = {
            {
                ActionType = ActionType.Move,
            },
            {}
        }
    }
}

return this
