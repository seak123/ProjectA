local Property = class("Property")

function Property:ctor(unit)
    self.master = unit
end

return Property
