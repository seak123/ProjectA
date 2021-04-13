local Map = class("BattleMap")
local Grid = require("GameLogic.Battle.Map.MapGrid")

function Map:ctor()
    self.grids = {}
    self.mapLength = 0 -- Z axis
    self.mapWidth = 0 -- X axis
end

function Map:InitMap(mapVO)
    self.mapLength = mapVO.Length
    self.mapWidth = mapVO.Width
    for i = 0, mapVO.Grids.Length - 1 do
        local gridVO = mapVO.Grids[i]
        local grid = Grid.new(gridVO)
        self.grids[self:Coord2Index(gridVO.Coord)] = grid
    end
end
-------- game logic -----------
function Map:MoveUnit(unit, direction)
    unit:OnMove(unit, unit)
end
-------------------------------

-------- utils start ----------
function Map:IsCoordValid(vector)
    return vector.x >= 0 and vector.x < self.mapWidth and vector.y >= 0 and vector.y < self.mapLength
end
function Map:Coord2Index(vector)
    return vector.y * self.mapWidth + vector.x
end
-------- utils end ------------

return Map
