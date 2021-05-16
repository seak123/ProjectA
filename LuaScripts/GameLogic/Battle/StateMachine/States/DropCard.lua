local Base = require("GameLogic.Battle.StateMachine.States.BaseState")
local DropCard = class("DropCard", Base)
local Order = require("GameLogic.Battle.Trace.InputOrder")

DropCard.key = Base.StateStage.DropCard

function DropCard:ctor(machine)
    self.machine = machine
    self.nextState = Base.StateStage.NoneStage
end

function DropCard:OnEnter()
    self:CheckDropState()
end

function DropCard:OnLeave()
end

function DropCard:InputOrder(order)
    if order.type == Order.Type.Drop then
        local unit = curSession.field:GetUnitByUid(order.unitUid)
        for i = 1, #order.cards do
            unit:DropACard(order.cards[i])
        end
    end
    self:CheckDropState()
end

function DropCard:NextState()
    return self.nextState
end

function DropCard:CheckDropState()
    local bDropCompleted = true
    curSession.field:ForeachUnit(
        function(unit)
            bDropCompleted = bDropCompleted and unit:NeedDropNum() == 0
        end
    )
    if bDropCompleted then
        self.nextState = Base.StateStage.RoundBegin
        curSession.stateMachine:RunMachine()
    end
    EventManager:Emit(EventConst.ON_REFRESH_BATTLE_UI)
end

return DropCard
