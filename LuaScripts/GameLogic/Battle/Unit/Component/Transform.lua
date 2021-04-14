local Transform = class("Transform")

function Transform:ctor(unit)
    self.master = unit
    self.pos = {x = 0, y = 0}
end


return Transform
