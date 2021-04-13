local BattleSession = class("BattleSession")
local StateMachine = require("GameLogic.Battle.StateMachine.StateMachine")
local BaseState = require("GameLogic.Battle.StateMachine.States.BaseState")
local BattleField = require("GameLogic.Battle.BattleField")
local BattleLib = CS.BattleLuaLibrary

function BattleSession:ctor()
    self.stateMachine = StateMachine.new()
    self.field = BattleField.new()
end

function BattleSession:InputOrder(order)
    self.stateMachine:InputPlayerOrder(order)
end

function BattleSession.StartBattle()
    _G.curSession = BattleSession.new()
    _G.curSession.stateMachine:SwitchState(BaseState.StateStage.PreGame)
end

return BattleSession
