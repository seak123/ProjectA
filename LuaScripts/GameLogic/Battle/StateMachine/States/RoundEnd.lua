local Base = require("GameLogic.Battle.StateMachine.States.BaseState")
local RoundEnd = class("RoundEnd", Base)

function RoundEnd:ctor(machine)
    self.machine = machine
    self.nextState = Base.StateStage.NoneStage
end

function RoundEnd:OnEnter()
    self.nextState = Base.StateStage.RoundBegin
end

function RoundEnd:OnLeave()
end

function RoundEnd:InputOrder(order)
end

function RoundEnd:NextState()
    return self.nextState
end

return RoundEnd
