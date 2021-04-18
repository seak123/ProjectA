local Base = require("GameLogic.Battle.StateMachine.States.BaseState")
local PlayCard = class("PlayCard", Base)

function PlayCard:ctor(machine)
    self.machine = machine
    self.nextState = Base.StateStage.NoneStage
end

function PlayCard:OnEnter()
    local conditionFunc = function(unit)
        if unit.vo.Camp == curSession.stateMachine.curActCamp then
            return true
        end
        return false
    end
    local opUnit = curSession.field:GetUnit(conditionFunc)
    EventManager:Emit(EventConst.ON_SELECT_OP_UNIT, opUnit.uid)
end

function PlayCard:OnLeave()
end

function PlayCard:InputOrder(orderVO)
end

function PlayCard:NextState()
    return self.nextState
end

return PlayCard
