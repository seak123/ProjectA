local this = {}
local ActionType = require("GameLogic.Battle.Actions.BaseAction").ActionType
local BaseAct = require("GameLogic.Battle.Actions.BaseAction")
local MoveAct = require("GameLogic.Battle.Actions.MoveAction")

this.AttrType = {
    Move = {
        desc = "移动",
        color = {
            r = 0.49,
            g = 0.97,
            b = 0.55
        }
    },
    Blink = {
        desc = "瞬移",
        color = {
            r = 0.49,
            g = 0.97,
            b = 0.55
        }
    },
    Instant = {
        desc = "瞬发",
        color = {
            r = 1,
            g = 0.82,
            b = 0.41
        }
    },
    PhysicDam = {
        desc = "物理",
        color = {
            r = 1,
            g = 0.41,
            b = 0.44
        }
    },
    psionicDam = {
        desc = "灵能",
        color = {
            r = 1,
            g = 0.41,
            b = 0.86
        }
    }
}

this.Cards = {
    [1] = {
        id = 1,
        name = "基础移动",
        cost = 0,
        actions = {
            {
                actionType = ActionType.Move,
                actionParams = {
                    type = MoveAct.Type.Walk,
                    target = BaseAct.TargetType.Self,
                    distance = "$Speed"
                }
            }
        },
        attributes = {this.AttrType.Move},
        descrition = "移动 $Speed 距离"
    }
}

return this
