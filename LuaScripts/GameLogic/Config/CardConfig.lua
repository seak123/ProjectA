local this = {}
local ActionType = require("GameLogic.Battle.Actions.BaseAction").ActionType
local BaseAct = require("GameLogic.Battle.Actions.BaseAction")
local MoveAct = require("GameLogic.Battle.Actions.Move")

this.Cards = {
    [1] = {
        name = "移动",
        actions = {
            {
                actionType = ActionType.Move,
                actionParams = {
                    type = MoveAct.MoveType.Walk,
                    target = BaseAct.TargetType.Self,
                    distance = 3
                }
            },
            {}
        }
    }
}

return this
