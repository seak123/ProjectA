local Base = require("GameLogic.Battle.StateMachine.States.BaseState")
local PlayCard = class("PlayCard", Base)
local Order = require("GameLogic.Battle.Trace.InputOrder")
local BattleLib = CS.BattleLuaLibrary

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
    self.nextState = Base.StateStage.NoneStage

    EventManager:Emit(EventConst.ON_SELECT_OP_UNIT, opUnit.uid)
    EventManager:On(EventConst.ON_SELECT_CARD, self.OnSelectCard, self)
end

function PlayCard:OnLeave()
    EventManager:Off(EventConst.ON_SELECT_CARD, self.OnSelectCard, self)
end

function PlayCard:InputOrder(order)
    if order.type == Order.Type.Play then
        local actions = self.selectCard.config.actions
        -- TODO: check whether input is valid here
        for i = 1, #actions do
            local action = require(actions[i].actionType).new(actions[i].actionParams)
            local performNode = action:InputOrder(order.paramTable)
            curSession.performer:PushNode(performNode)
        end
        curSession.stateMachine.curOpUnit:PlayACard(self.selectCard.uid)
        curSession.stateMachine.passCounter = 0
    elseif order.type == Order.Type.Pass then
        curSession.stateMachine.passCounter = curSession.stateMachine.passCounter + 1
    end
    curSession.performer:Perform()
    if curSession.stateMachine:SwitchActCamp() then
        self.nextState = Base.StateStage.RoundEnd
    else
        self.nextState = Base.StateStage.PlayCard
    end
end

function PlayCard:NextState()
    return self.nextState
end

function PlayCard:OnSelectCard(uid)
    local card = curSession.stateMachine.curOpUnit:GetHandCard(uid)
    if card then
        self.selectCard = card
        local inputTable = {}
        local actions = card.config.actions
        for i = 1, #actions do
            local action = require(actions[i].actionType).new(actions[i].actionParams)
            for j = 1, #action.paramTable do
                table.insert(inputTable, action.paramTable[j])
            end
        end
        EventManager:Emit(EventConst.REQ_PLAYCARD_PARAMS, inputTable)
    end
end

return PlayCard
