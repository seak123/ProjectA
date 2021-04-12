local Machine = class("StateMachine")
local BaseState = require("LuaScripts.GameLogic.Battle.StateMachine.States.BaseState")

function Machine:ctor()
    self.curState = nil
    self.states = {}
end

function Machine:InputPlayerOperation()
    self.curState:InputOperation()
    while self.curState:NextState() ~= BaseState.StateStage.NoneStage do
        self.curState:OnLeave()
        self.curState = self.states[self.curState:NextState()]
        self.curState:OnEnter()
    end
end

return Machine
