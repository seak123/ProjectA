local Transform = class("Transform")

function Transform:ctor(unit)
    self.master = unit
    self.position = unit.vo.Coord
    self.direction = unit.vo.Direction
end


return Transform
