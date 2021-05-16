local Machine = class("StateMachine")
local BaseState = require("GameLogic.Battle.StateMachine.States.BaseState")
local PreGame = require("GameLogic.Battle.StateMachine.States.PreGame")
local RoundBegin = require("GameLogic.Battle.StateMachine.States.RoundBegin")
local PlayCard = require("GameLogic.Battle.StateMachine.States.PlayCard")
local RoundEnd = require("GameLogic.Battle.StateMachine.States.RoundEnd")
local GameEnd = require("GameLogic.Battle.StateMachine.States.GameEnd")
local DropCard = require("GameLogic.Battle.StateMachine.States.DropCard")
local InputOrder = require("GameLogic.Battle.Trace.InputOrder")

function Machine:ctor()
    self.states = {}
    self.states[BaseState.StateStage.PreGame] = PreGame.new(self)
    self.states[BaseState.StateStage.RoundBegin] = RoundBegin.new(self)
    self.states[BaseState.StateStage.PlayCard] = PlayCard.new(self)
    self.states[BaseState.StateStage.RoundEnd] = RoundEnd.new(self)
    self.states[BaseState.StateStage.GameEnd] = GameEnd.new(self)
    self.states[BaseState.StateStage.DropCard] = DropCard.new(self)

    self.curState = nil
    self.curActCamp = 1 -- 行动方
    self.curOpUnit = nil -- 操作单位
    self.curSelectCards = {} -- 当前选中的卡片
    self.passCounter = 0 -- 空过数
    self.skipActSwitch = false

    EventManager:On(EventConst.ON_SELECT_OP_UNIT, self.OnSelectOpUnit, self)
    EventManager:On(EventConst.ON_INPUT_ORDER, self.InputOrder, self)
    EventManager:On(EventConst.ON_REQ_SELECT_CARD, self.OnSelectCard, self)
    EventManager:On(EventConst.ON_CARD_DROPED, self.OnDropCard, self)
    EventManager:On(EventConst.ON_REQ_UNSELECT_CARD, self.OnUnSelectCard, self)
    EventManager:On(EventConst.ON_CANCEL_SELECT, self.OnCanelAll, self)
end

function Machine:InputOrder(order)
    self.curState:InputOrder(order)
    self:RunMachine()
end

function Machine:SwitchState(nextState)
    if self.curState ~= nil then
        self.curState:OnLeave()
    end
    self.curState = self.states[nextState]
    self.curState:OnEnter()
    self:RunMachine()
end

function Machine:RunMachine()
    while self.curState:NextState() ~= BaseState.StateStage.NoneStage do
        self:SwitchState(self.curState:NextState())
    end
end

function Machine:SwitchActCamp()
    if self.skipActSwitch then
        self.skipActSwitch = false
    else
        self.curActCamp = 3 - self.curActCamp
    end
    if self.passCounter == 2 then
        self.passCounter = 0
        return true
    else
        return false
    end
end

function Machine:OnSelectOpUnit(uid)
    self.curOpUnit = curSession.field:GetUnitByUid(uid)
    self.curSelectCards = {}
end

function Machine:OnSelectCard(uid)
    local isInPlayState = curSession.stateMachine.curState.key == BaseState.StateStage.PlayCard
    local isInDropState = curSession.stateMachine.curState.key == BaseState.StateStage.DropCard

    if isInPlayState then
        if not table.contains(self.curSelectCards, uid) then
            table.insert(self.curSelectCards, uid)
            EventManager:Emit(EventConst.ON_CARD_SELECTED, uid)
        end
        EventManager:Emit(EventConst.ON_REFRESH_BATTLE_UI)
    end
    if isInDropState and #self.curSelectCards < self.curOpUnit:NeedDropNum() then
        if not table.contains(self.curSelectCards, uid) then
            table.insert(self.curSelectCards, uid)
            EventManager:Emit(EventConst.ON_CARD_SELECTED, uid)
        end
        EventManager:Emit(EventConst.ON_REFRESH_BATTLE_UI)
    end
end

function Machine:OnUnSelectCard(uid)
    table.remove_if(
        self.curSelectCards,
        function(ele)
            return ele == uid
        end
    )
    EventManager:Emit(EventConst.ON_CARD_UNSELECTED, uid)
    EventManager:Emit(EventConst.ON_REFRESH_BATTLE_UI)
    self:NotifyPerformLayer()
end

function Machine:OnCanelAll()
    for i = 1, #self.curSelectCards do
        EventManager:Emit(EventConst.ON_REQ_UNSELECT_CARD, self.curSelectCards[i])
    end
    self.curSelectCards = {}
    self:NotifyPerformLayer()
end

function Machine:OnDropCard(uid)
    table.remove_if(
        self.curSelectCards,
        function(ele)
            return ele == uid
        end
    )
end

function Machine:NotifyPerformLayer()
    if self.curState.key == BaseState.StateStage.PlayCard and #self.curSelectCards == 0 then
        EventManager:Emit(EventConst.ON_QUIT_PALYCARD)
    end
end

return Machine
