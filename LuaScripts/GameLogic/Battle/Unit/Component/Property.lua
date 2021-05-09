local Property = class("Property")

Property.PropDef = {
    Hp = "Hp",
    Energy = "Energy",
    MaxHp = "MaxHp",
    MaxEnergy = "MaxEnergy",
    Speed = "Speed"
}

Property.PropDesc = {
    [Property.PropDef.Hp] = "当前血量",
    [Property.PropDef.Energy] = "能量",
    [Property.PropDef.MaxHp] = "最大血量",
    [Property.PropDef.MaxEnergy] = "最大能量",
    [Property.PropDef.Speed] = "速度"
}

function Property:ctor(unit)
    self.master = unit
    self:Init()
end

function Property:Init()
    for k, v in pairs(Property.PropDef) do
        self[v] = self.master.vo[v]
        self[v .. "_add"] = 0
    end
    self["Hp"] = self["MaxHp"]
    self["Energy"] = 0
end

function Property:GetValue(name)
    local base = self[name] == nil and 0 or self[name]
    local add = self[name .. "_add"] == nil and 0 or self[name .. "_add"]
    return base + add
end

return Property
