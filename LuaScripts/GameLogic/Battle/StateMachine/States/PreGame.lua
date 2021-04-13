local Base = require("GameLogic.Battle.StateMachine.States.BaseState")
local PreGame = class("PreGame", Base)
local BattleConst = require("GameLogic.Battle.BattleConst")

function PreGame:ctor(machine)
    self.machine = machine
    self.nextState = Base.StateStage.NoneStage
end

function PreGame:OnEnter()
    print("Game init here")
    local sessVO = curSession.vo
    -- Init map
    curSession.map:InitMap(sessVO.MapVO)
    -- Create all units
    for i = 0, sessVO.Units.Count - 1 do
        curSession.field:CreateUnit(sessVO.Units[i])
    end
end

function PreGame:OnLeave()
end

function PreGame:InputOrder(orderVO)
    if orderVO.orderType == BattleConst.OrderType.Confirm then
        self.nextState = Base.StateStage.RoundBegin
    end
end

function PreGame:NextState()
    return self.nextState
end

return PreGame
