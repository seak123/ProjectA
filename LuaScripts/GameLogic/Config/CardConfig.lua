local this = {}
local ActionType = require("GameLogic.Battle.Actions.BaseAction").ActionType
local BaseAct = require("GameLogic.Battle.Actions.BaseAction")
local MoveAct = require("GameLogic.Battle.Actions.MoveAction")
local UnitParam = require("GameLogic.Battle.Actions.ActionParam.UnitParam")

this.CardType = {
    Common = 1,
    Strategy = 2,
    Violence = 3,
    Trick = 4,
    Harmony = 5
}

this.CardTypeColors = {
    [this.CardType.Common] = {
        r = 0.7,
        g = 0.7,
        b = 0.7
    },
    [this.CardType.Strategy] = {
        r = 0.21,
        g = 0.38,
        b = 0.75
    },
    [this.CardType.Violence] = {
        r = 0.7,
        g = 0.28,
        b = 0.27
    },
    [this.CardType.Trick] = {
        r = 0.3,
        g = 0.3,
        b = 0.3
    },
    [this.CardType.Harmony] = {
        r = 0.42,
        g = 0.66,
        b = 0.42
    }
}

this.AttrType = {
    Move = {
        desc = "位移",
        color = {
            r = 0.49,
            g = 0.97,
            b = 0.55
        }
    },
    Boost = {
        desc = "增强",
        color = {
            r = 1,
            g = 0.82,
            b = 0.41
        }
    },
    Attack = {
        desc = "攻击",
        color = {
            r = 1,
            g = 0.41,
            b = 0.44
        }
    },
    Utility = {
        desc = "功能",
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
        type = this.CardType.Common,
        name = "基础移动",
        cost = 0,
        attributes = {this.AttrType.Move},
        descrition = "移动 $Speed 距离",
        actions = {
            {
                actionType = ActionType.Move,
                actionParams = {
                    type = MoveAct.Type.Walk,
                    target = UnitParam.Self(),
                    distance = "$Speed"
                }
            }
        }
    },
    [2] = {
        id = 2,
        type = this.CardType.Common,
        name = "肘击",
        cost = 0,
        attributes = {this.AttrType.Attack},
        descrition = "对敌人造成 3 近战伤害",
        range = 1,
        actions = {
            {
                actionType = ActionType.Melee,
                actionParams = {
                    target = UnitParam.Enemy(1, 1)
                },
                subActions = {
                    {
                        Trigger = 0.4,
                        actionType = ActionType.Damage,
                        actionParams = {
                            target = UnitParam.Enemy(1, 1),
                            damage = 30,
                            delay = 0.1
                        }
                    }
                }
            }
        }
    }
}

return this
