local this = {}
local ActionType = require("GameLogic.Battle.Actions.BaseAction").ActionType
local BaseAct = require("GameLogic.Battle.Actions.BaseAction")
local MoveAct = require("GameLogic.Battle.Actions.MoveAction")

this.Cards = {
    [1] = {
        name = "移动",
        actions = {
            {
                actionType = ActionType.Move,
                actionParams = {
                    type = MoveAct.Type.Walk,
                    target = BaseAct.TargetType.Self,
                    distance = 3
                }
            },
        }
    }
}

return this
