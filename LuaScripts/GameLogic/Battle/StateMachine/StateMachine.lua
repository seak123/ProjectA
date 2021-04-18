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

    EventManager:On(EventConst.ON_SELECT_OP_UNIT, self.OnSelectOpUnit, self)
end

function Machine:InputPlayerOrder(orderVO)
    self.curState:InputOrder(orderVO)
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

function Machine:OnSelectOpUnit(uid)
    self.curOpUnit = curSession.field:GetUnitByUid(uid)
end

return Machine
