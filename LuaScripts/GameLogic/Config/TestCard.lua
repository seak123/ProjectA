local this = {}
local ActionType = require("GameLogic.Battle.Actions.BaseAction").ActionType

this.Cards = {
    [1] = {
        Name = "测试",
        Actions = {
            {
                ActionType = ActionType.Move,
            },
            {}
        }
    }
}

return this
