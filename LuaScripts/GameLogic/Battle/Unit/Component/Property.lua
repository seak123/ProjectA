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
    return math.max(0, base + add)
end

function Property:AddValue(name, value)
    if name == Property.PropDef.Hp then
        local res = self["Hp"] + value
        self["Hp"] = Math.clamp(res, 0, self:GetValue("MaxHp"))
    elseif name == Property.PropDef.Energy then
        local res = self["Energy"] + value
        self["Energy"] = Math.clamp(res, 0, self:GetValue("MaxEnergy"))
    else
        self[name] = self[name] + value
    end
end

return Property
