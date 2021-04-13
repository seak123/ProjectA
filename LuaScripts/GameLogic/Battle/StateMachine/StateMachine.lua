local Machine = class("StateMachine")
local BaseState = require("GameLogic.Battle.StateMachine.States.BaseState")
local PreGame = require("GameLogic.Battle.StateMachine.States.PreGame")
local RoundBegin = require("GameLogic.Battle.StateMachine.States.RoundBegin")
local PlayCard = require("GameLogic.Battle.StateMachine.States.PlayCard")
local RoundEnd = require("GameLogic.Battle.StateMachine.States.RoundEnd")
local GameEnd = require("GameLogic.Battle.StateMachine.States.GameEnd")

function Machine:ctor()
    self.curState = nil
    self.states = {}
    self.states[BaseState.StateStage.PreGame] = PreGame.new()
    self.states[BaseState.StateStage.RoundBegin] = RoundBegin.new()
    self.states[BaseState.StateStage.PlayCard] = PlayCard.new()
    self.states[BaseState.StateStage.RoundEnd] = RoundEnd.new()
    self.states[BaseState.StateStage.GameEnd] = GameEnd.new()
end

function Machine:InputPlayerOrder()
    self.curState:InputOrder()
    while self.curState:NextState() ~= BaseState.StateStage.NoneStage do
        self:SwitchState(self.curState:NextState())
    end
end

function Machine:SwitchState(nextState)
    if self.curState ~= nil then
        self.curState:OnLeave()
    end
    self.curState = self.states[nextState]
    self.curState:OnEnter()
end

return Machine
