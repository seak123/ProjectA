local Base = require("GameLogic.Battle.StateMachine.States.BaseState")
local GameEnd = class("GameEnd", Base)

function GameEnd:ctor(machine)
    self.machine = machine
    self.nextState = Base.StateStage.NoneStage
end

function GameEnd:OnEnter()
end

function GameEnd:OnLeave()
end

function GameEnd:InputOrder()
end

function GameEnd:NextState()
    return self.nextState
end

return GameEnd
