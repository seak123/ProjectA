local BattleSession = class("BattleSession")
local StateMachine = require("GameLogic.Battle.StateMachine.StateMachine")
local BaseState = require("GameLogic.Battle.StateMachine.States.BaseState")
local BattleField = require("GameLogic.Battle.BattleField")
local BattleMap = require("GameLogic.Battle.Map.BattleMap")
local Performer = require("GameLogic.Battle.BattlePerformer")

function BattleSession:ctor(sessVO)
    self.vo = sessVO
    self.stateMachine = StateMachine.new()
    self.map = BattleMap.new()
    self.field = BattleField.new()
    self.performer = Performer.new()
end

function BattleSession.StartBattle(sessVO)
    _G.curSession = BattleSession.new(sessVO)
    _G.curSession.stateMachine:SwitchState(BaseState.StateStage.PreGame)
end

-------------- csharp util function -------------------

function BattleSession.GetUnitProperty(uid, name)
    local unit = _G.curSession.field:GetUnitByUid(uid)
    if unit ~= nil then
        return unit.property:GetValue(name)
    end
end

function BattleSession.GetUnitCoord(uid)
    local unit = _G.curSession.field:GetUnitByUid(uid)
    if unit ~= nil then
        return unit.transform.position
    end
end

function BattleSession.GetUnitDirection(uid)
    local unit = _G.curSession.field:GetUnitByUid(uid)
    if unit ~= nil then
        return unit.transform.direction
    end
end

function BattleSession.IsGridMovable(uid, vector)
    return _G.curSession.map:IsGridMovable(uid, vector)
end

function BattleSession.GetReachableRegion(uid, distance)
    return _G.curSession.map:GetReachableRegion(uid, distance)
end

function BattleSession.GetPathToGoal(uid, vector)
    return _G.curSession.map:GetPathToGoal(uid, vector)
end

function BattleSession.UpdateReadyOrder(isReady, order)
    EventManager:Emit(EventConst.ON_PLAYCARD_READY_CHANGE, isReady, order)
end

return BattleSession
