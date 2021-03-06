local Field = class("BattleField")
local BattleUnit = require("GameLogic.Battle.Unit.BattleUnit")

function Field:ctor()
    self.units = {}
    self.graveyard = {}
    self.unitCounter = 0
end

function Field:CreateUnit(unitVO)
    local unit = BattleUnit.new(unitVO)
    self.unitCounter = self.unitCounter + 1
    unit.uid = self.unitCounter
    self.units[unit.uid] = unit

    curSession.map:CreateUnit(unit)
    EventManager:Emit(EventConst.ON_CREATE_UNIT, unit.uid, unitVO)
end

function Field:RemoveUnit(uid)
    if self.units[uid] ~= nil then
        local unit = self.units[uid]
        curSession.map:RemoveUnit(unit)
        self.units[uid] = nil
        self.graveyard[uid] = unit
    end
end

---------- Utils start ---------------
function Field:ForeachUnit(func)
    for k, v in pairs(self.units) do
        func(v)
    end
end

function Field:GetUnit(condition)
    for k, v in pairs(self.units) do
        if condition(v) then
            return v
        end
    end
end

function Field:GetUnitByUid(uid)
    for k, v in pairs(self.units) do
        if v.uid == uid then
            return v
        end
    end
    for k, v in pairs(self.graveyard) do
        if v.uid == uid then
            return v
        end
    end
end

function Field:CheckResult()
    local friendNum = 0
    local enemyNum = 0
    self:ForeachUnit(
        function(unit)
            if unit.camp == 1 then
                friendNum = friendNum + 1
            else
                enemyNum = enemyNum + 1
            end
        end
    )
    if friendNum == 0 and enemyNum > 0 then
        return 2
    elseif enemyNum == 0 and friendNum > 0 then
        return 1
    elseif enemyNum == 0 and friendNum == 0 then
        return 0
    else
        return -1
    end
end
---------- Utils end -----------------

return Field
