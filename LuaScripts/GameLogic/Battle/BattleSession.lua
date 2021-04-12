local BattleSession = class("BattleSession")
local StateMachine = require("LuaScripts.GameLogic.Battle.StateMachine.StateMachine")
local BattleField = require("LuaScripts.GameLogic.Battle.BattleField")
local BattleLib = CS.BattleLuaLibrary

function BattleSession:ctor()
    self.stateMachine = StateMachine.new()
    self.field = BattleField.new()
end

function BattleSession:InputOrder()
    self.stateMachine:InputPlayerOperation()
end

function BattleSession.StartBattle()
    _G.curSession = BattleSession.new()
end

return BattleSession
