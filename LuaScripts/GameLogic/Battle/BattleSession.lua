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
    return _G.curSession
end

-------------- csharp util function -------------------
function BattleSession:EnterGame()
    self.stateMachine:SwitchState(BaseState.StateStage.PreGame)
end

function BattleSession:GetUnitProperty(uid, name)
    local unit = self.field:GetUnitByUid(uid)
    if unit ~= nil then
        return unit.property:GetValue(name)
    end
end

function BattleSession:GetUnitCoord(uid)
    local unit = self.field:GetUnitByUid(uid)
    if unit ~= nil then
        return CS.UnityEngine.Vector2Int(unit.transform.position.x, unit.transform.position.y)
    end
end

function BattleSession:GetUnitDirection(uid)
    local unit = self.field:GetUnitByUid(uid)
    if unit ~= nil then
        return unit.transform.direction
    end
end

function BattleSession:IsGridMovable(uid, vector)
    return self.map:IsGridMovable(uid, vector)
end

function BattleSession:GetReachableRegion(uid, distance)
    return self.map:GetReachableRegion(uid, distance)
end

function BattleSession:GetPathToGoal(uid, vector)
    return self.map:GetPathToGoal(uid, vector)
end

function BattleSession:UpdateReadyOrder(isReady, order)
    EventManager:Emit(EventConst.ON_PLAYCARD_READY_CHANGE, isReady, order)
end

function BattleSession:SelectUnit(uid)
    if self.stateMachine.curState.key == BaseState.StateStage.PlayCard then
        if self.field:GetUnitByUid(uid).camp == self.stateMachine.curActCamp then
            EventManager:Emit(EventConst.ON_SELECT_OP_UNIT, uid)
        end
    end
end

return BattleSession
