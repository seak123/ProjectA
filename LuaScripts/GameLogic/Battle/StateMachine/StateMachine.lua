local Machine = class("StateMachine")
local BaseState = require("GameLogic.Battle.StateMachine.States.BaseState")
local PreGame = require("GameLogic.Battle.StateMachine.States.PreGame")
local RoundBegin = require("GameLogic.Battle.StateMachine.States.RoundBegin")
local PlayCard = require("GameLogic.Battle.StateMachine.States.PlayCard")
local RoundEnd = require("GameLogic.Battle.StateMachine.States.RoundEnd")
local GameEnd = require("GameLogic.Battle.StateMachine.States.GameEnd")

function Machine:ctor()
    self.states = {}
    self.states[BaseState.StateStage.PreGame] = PreGame.new(self)
    self.states[BaseState.StateStage.RoundBegin] = RoundBegin.new(self)
    self.states[BaseState.StateStage.PlayCard] = PlayCard.new(self)
    self.states[BaseState.StateStage.RoundEnd] = RoundEnd.new(self)
    self.states[BaseState.StateStage.GameEnd] = GameEnd.new(self)

    self.curState = nil
    self.curActCamp = 1 -- 行动方
    self.curOpUnit = nil -- 操作单位
    self.passCounter = 0 -- 空过数
    self.skipActSwitch = false

    EventManager:On(EventConst.ON_SELECT_OP_UNIT, self.OnSelectOpUnit, self)
    EventManager:On(EventConst.ON_INPUT_ORDER, self.InputOrder, self)
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
end

return Machine
