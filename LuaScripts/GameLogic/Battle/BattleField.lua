local Field = class("BattleField")
local BattleUnit = require("GameLogic.Battle.Unit.BattleUnit")

function Field:ctor()
    -- 1 is friend 2 is enemy
    self.units = {{}, {}}
end

function Field:CreateUnit(unitVO)
    local unit = BattleUnit.new(unitVO)
    self.units[unitVO.Camp][unitVO.Rid] = unit
end

---------- Utils start ---------------
function Field:ForeachUnit(func)
    for k, v in pairs(self.units[1]) do
        func(v)
    end
    for k, v in pairs(self.units[2]) do
        func(v)
    end
end
---------- Utils end -----------------

return Field
