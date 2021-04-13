local BattleSession = class("BattleSession")
local StateMachine = require("GameLogic.Battle.StateMachine.StateMachine")
local BaseState = require("GameLogic.Battle.StateMachine.States.BaseState")
local BattleField = require("GameLogic.Battle.BattleField")
local BattleMap = require("GameLogic.Battle.Map.BattleMap")
local BattleLib = CS.BattleLuaLibrary

function BattleSession:ctor(sessVO)
    self.vo = sessVO
    self.stateMachine = StateMachine.new()
    self.map = BattleMap.new()
    self.field = BattleField.new()
end

function BattleSession:InputOrder(order)
    self.stateMachine:InputPlayerOrder(order)
end

function BattleSession.StartBattle(sessVO)
    _G.curSession = BattleSession.new(sessVO)
    _G.curSession.stateMachine:SwitchState(BaseState.StateStage.PreGame)
end

return BattleSession
