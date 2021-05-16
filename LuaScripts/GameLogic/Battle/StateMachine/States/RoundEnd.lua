local Base = require("GameLogic.Battle.StateMachine.States.BaseState")
local RoundEnd = class("RoundEnd", Base)

RoundEnd.key = Base.StateStage.RoundEnd

function RoundEnd:ctor(machine)
    self.machine = machine
    self.nextState = Base.StateStage.NoneStage
end

function RoundEnd:OnEnter()
    self.nextState = Base.StateStage.DropCard
end

function RoundEnd:OnLeave()
end

function RoundEnd:InputOrder(order)
end

function RoundEnd:NextState()
    return self.nextState
end

return RoundEnd
