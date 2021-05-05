local Property = class("Property")

Property.PropDef = {
    Hp = "MaxHp",
    Energy = "MaxEnergy",
    Speed = "Speed"
}

function Property:ctor(unit)
    self.master = unit
end

function Property:Init()
    for k, v in pairs(Property.PropDef) do
        self[v] = self.master.vo[v]
        self[v .. "_add"] = 0
    end
    self["Hp"] = self["MaxHp"]
    self["Energy"] = self["MaxEnergy"]
end

function Property:GetValue(name)
    local base = self[name] == nil and 0 or self[name]
    local add = self[name .. "_add"] == nil and 0 or self[name .. "_add"]
    return base + add
end

return Property
