local MapGrid = class("MapGrid")

MapGrid.GridAttr = {
    Walkable = 1,
    Obstructive = 2
}

function MapGrid:ctor(gridVO)
    self.attr = gridVO.GridAttr
end

function MapGrid:IsWalkable()
    return Math.bitAND(MapGrid.GridAttr.Walkable, self.attr)
end

return MapGrid
