local Base = require("GameLogic.Battle.StateMachine.States.BaseState")
local GameEnd = class("GameEnd", Base)

GameEnd.key = Base.StateStage.GameEnd

function GameEnd:ctor()
    self.nextState = Base.StateStage.NoneStage
end

function GameEnd:OnEnter()
end

function GameEnd:OnLeave()
end

function GameEnd:InputOrder(orderVO)
end

function GameEnd:NextState()
    return self.nextState
end

return GameEnd
