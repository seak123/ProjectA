local Base = require("GameLogic.Battle.StateMachine.States.BaseState")
local GameEnd = class("GameEnd", Base)

GameEnd.key = Base.StateStage.GameEnd

local SettlementPath = "UI/Prefabs/Battle/UI_BattleSettlement"

function GameEnd:ctor()
    self.nextState = Base.StateStage.NoneStage
end

function GameEnd:OnEnter()
    local obj = CS.UILibrary.AddUIFrame(SettlementPath)
    local lb = BehaviourManager:GetBehaviour(obj:GetInstanceID())
    local result = curSession.field:CheckResult()
    lb:SetResult(result == 1)
    self.nextState = Base.StateStage.NoneStage
end

function GameEnd:OnLeave()
end

function GameEnd:InputOrder(orderVO)
end

function GameEnd:NextState()
    return self.nextState
end

return GameEnd
