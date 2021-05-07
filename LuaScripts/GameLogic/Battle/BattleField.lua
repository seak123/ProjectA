local Field = class("BattleField")
local BattleUnit = require("GameLogic.Battle.Unit.BattleUnit")

function Field:ctor()
    self.units = {}
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
end
---------- Utils end -----------------

return Field
