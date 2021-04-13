local Base = require("GameLogic.Battle.StateMachine.States.BaseState")
local RoundBegin = class("RoundBegin", Base)

function RoundBegin:ctor()
    self.nextState = Base.StateStage.NoneStage
end

function RoundBegin:OnEnter()
end

function RoundBegin:OnLeave()
end

function RoundBegin:InputOrder()
end

function RoundBegin:NextState()
    return self.nextState
end

return RoundBegin
