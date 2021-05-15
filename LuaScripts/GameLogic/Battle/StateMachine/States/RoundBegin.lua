local Base = require("GameLogic.Battle.StateMachine.States.BaseState")
local RoundBegin = class("RoundBegin", Base)

RoundBegin.key = Base.StateStage.RoundBegin

function RoundBegin:ctor(machine)
    self.machine = machine
    self.nextState = Base.StateStage.NoneStage
end

function RoundBegin:OnEnter()
    Debug.Log("Enter RoundBegin State")
    curSession.field:ForeachUnit(
        function(unit)
            unit:OnRoundBegin()
        end
    )
    EventManager:Emit(EventConst.ON_BATTLE_ROUND_BEGIN)
    self.nextState = Base.StateStage.PlayCard
end

function RoundBegin:OnLeave()
end

function RoundBegin:InputOrder()
end

function RoundBegin:NextState()
    return self.nextState
end

return RoundBegin
