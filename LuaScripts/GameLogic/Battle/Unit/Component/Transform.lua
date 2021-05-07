local Transform = class("Transform")

function Transform:ctor(unit)
    self.master = unit
    self.position = {x = unit.vo.Coord.x, y = unit.vo.Coord.y}
    self.direction = unit.vo.Direction
end

return Transform
