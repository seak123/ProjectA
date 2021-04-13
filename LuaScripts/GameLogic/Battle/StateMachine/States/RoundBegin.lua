local Base = require("GameLogic.Battle.StateMachine.States.BaseState")
local RoundBegin = class("RoundBegin", Base)

function RoundBegin:ctor(machine)
    self.machine = machine
    self.nextState = Base.StateStage.NoneStage
end

function RoundBegin:OnEnter()
    curSession.field:ForeachUnit(
        function(unit)
            unit:OnRoundBegin()
        end
    )
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
