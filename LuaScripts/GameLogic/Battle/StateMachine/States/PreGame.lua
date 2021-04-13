local Base = require("GameLogic.Battle.StateMachine.States.BaseState")
local PreGame = class("PreGame", Base)
local BattleConst = require("GameLogic.Battle.BattleConst")

function PreGame:ctor()
    self.nextState = Base.StateStage.NoneStage
end

function PreGame:OnEnter()
    print("Game init here")
end

function PreGame:OnLeave()
end

function PreGame:InputOrder(order)
    if order.orderType == BattleConst.OrderType.Confirm then
        self.nextState = Base.StateStage.RoundBegin
    end
end

function PreGame:NextState()
    return self.nextState
end

return PreGame
