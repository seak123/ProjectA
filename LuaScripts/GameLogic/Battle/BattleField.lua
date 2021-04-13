local Field = class("BattleField")

function Field:ctor()
    -- 1 is friend 2 is enemy
    self.units = {{}, {}}
end

function Field:CreateUnit()
end

return Field
