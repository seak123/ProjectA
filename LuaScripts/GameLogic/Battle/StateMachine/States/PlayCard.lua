local Base = require("GameLogic.Battle.StateMachine.States.BaseState")
local PlayCard = class("PlayCard", Base)

function PlayCard:ctor(machine)
    self.machine = machine
    self.nextState = Base.StateStage.NoneStage
end

function PlayCard:OnEnter()
end

function PlayCard:OnLeave()
end

function PlayCard:InputOrder(orderVO)
end

function PlayCard:NextState()
    return self.nextState
end

return PlayCard
