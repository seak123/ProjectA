local Map = class("BattleMap")
local Grid = require("GameLogic.Battle.Map.MapGrid")

Map.GridAttr = {
    Walkable = 1,
    Obstructive = 2
}

function Map:ctor()
    self.grids = {}
    self.mapLength = 0 -- Z axis
    self.mapWidth = 0 -- X axis
end

function Map:InitMap(mapVO)
    self.mapLength = mapVO.Length
    self.mapWidth = mapVO.Width
    for i = 0, mapVO.Grids.Count - 1 do
        local gridVO = mapVO.Grids[i]
        local grid = Grid.new(gridVO)
        self.grids[self:Coord2Index(gridVO.Coord)] = grid
        local test = CS.BattleMapAttr
        print("grid can walk: " .. tostring(Math.bitAND(gridVO.GridAttr, Map.GridAttr.Walkable)))
    end
end
-------- game logic -----------
function Map:MoveUnit(unit, direction)
    unit:PostMove()
end
-------------------------------

-------- utils start ----------
function Map:IsCoordValid(vector)
    return vector.x >= 0 and vector.x < self.mapWidth and vector.y >= 0 and vector.y < self.mapLength
end
function Map:Coord2Index(vector)
    return vector.y * self.mapWidth + vector.x
end
function Map.GetAdjacentPos(pos, direction)
    if direction == CS.BattleDirection.North then
        return {x = pos.x, y = pos.y + 1}
    elseif direction == CS.BattleDirection.East then
        return {x = pos.x + 1, y = pos.y}
    elseif direction == CS.BattleDirection.West then
        return {x = pos.x - 1, y = pos.y}
    else
        return {x = pos.x, y = pos.y - 1}
    end
end
-------- utils end ------------

return Map
