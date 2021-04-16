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
    for i = 0, mapVO.Grids.Count - 1 do
        local gridVO = mapVO.Grids[i]
        local grid = Grid.new(gridVO)
        self.grids[self:Coord2Index(gridVO.Coord)] = grid
    end
end
-------- game logic -----------
function Map:MoveUnit(unit, direction)
    local goal = self.GetAdjacentPos(unit.transform.position, direction)
    local index = self:Coord2Index(goal)
    if self.grids[index] ~= nil then
        if self.grids[index]:IsWalkable() then
            unit.transform.position = goal
            unit.transform.direction = direction
            unit:PostMove()
        else
            Debug.Error("Grid cannot move on")
        end
    else
        Debug.Error("Move unit failed")
    end
end
-------------------------------

-------- utils start ----------
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
