local this = {}
local ActionType = require("GameLogic.Battle.Actions.BaseAction").ActionType
local Move = require("GameLogic.Battle.Actions.Move")

this.Cards = {
    [1] = {
        Name = "移动",
        Actions = {
            {
                ActionType = ActionType.Move,
                Params = {
                    Friends = 1,
                    FreeGrid = 1,
                }
            },
            {}
        }
    }
}

return this
