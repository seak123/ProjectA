local Map = class("BattleMap")
local Grid = require("GameLogic.Battle.Map.MapGrid")
local PropDef = require("GameLogic.Battle.Unit.Component.Property").PropDef

Map.Direction = {
    North = 0,
    West = 1,
    Sourth = 2,
    East = 3
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
    end
end
-------- game logic -----------
function Map:CreateUnit(unit)
    local curGrid = self.grids[self:Coord2Index(unit.transform.position)]
    curGrid.standingUnit = unit
end
function Map:MoveUnit(unit, point)
    local direction = self.TurnUnitToPoint(unit, point)
    local goal = point
    local index = self:Coord2Index(goal)
    local curGrid = self.grids[self:Coord2Index(unit.transform.position)]
    local grid = self.grids[index]
    if grid ~= nil then
        if grid:IsWalkable() then
            unit.transform.position = goal
            unit.transform.direction = direction
            curGrid.standingUnit = nil
            grid.standingUnit = unit
            unit:PostMove()
        else
            Debug.Error("Grid cannot move on, pos:" .. "[" .. tostring(goal.x) .. "," .. tostring(goal.y) .. "]")
        end
    else
        Debug.Error("Move unit failed")
    end
end
-------------------------------

-------- utils start ----------
function Map:IsCoordValid(vector)
    return vector.x >= 0 and vector.x < self.mapWidth and vector.y >= 0 and vector.y < self.mapLength
end
function Map:Coord2Index(vector)
    if not self:IsCoordValid(vector) then
        return -1
    end
    return vector.y * self.mapWidth + vector.x
end

function Map.TurnUnitToPoint(unit, goal)
    local start = unit.transform.position

    local direction = nil

    local isVague = math.abs(goal.y - start.y) == math.abs(goal.x - start.x)
    if isVague then
        local deltaY = goal.y - start.y
        local deltaX = goal.x - start.x
        local direction_1, direction_2
        if deltaY > 0 and deltaX > 0 then
            direction_1 = Map.Direction.North
            direction_2 = Map.Direction.East
        elseif deltaY > 0 and deltaX < 0 then
            direction_1 = Map.Direction.North
            direction_2 = Map.Direction.West
        elseif deltaY < 0 and deltaX > 0 then
            direction_1 = Map.Direction.Sourth
            direction_2 = Map.Direction.East
        else
            direction_1 = Map.Direction.Sourth
            direction_2 = Map.Direction.West
        end
        local turn_1 = math.abs(unit.transform.direction - direction_1)
        local turn_2 = math.abs(unit.transform.direction - direction_2)
        if turn_1 == turn_2 then
            direction = unit.transform.direction
        elseif turn_1 > turn_2 then
            direction = direction_2
        else
            direction = direction_1
        end
    else
        local delta = goal.x - start.x
        if delta == 0 then
            delta = 0.01
        end
        local k = math.abs((goal.y - start.y) / delta)
        if k >= 1 then
            direction = goal.y > start.y and Map.Direction.North or Map.Direction.Sourth
        else
            direction = goal.x > start.x and Map.Direction.East or Map.Direction.West
        end
    end
    return direction
end
function Map.GetAdjacentPos(pos, direction)
    if direction == Map.Direction.North then
        return {x = pos.x, y = pos.y + 1}
    elseif direction == Map.Direction.East then
        return {x = pos.x + 1, y = pos.y}
    elseif direction == Map.Direction.West then
        return {x = pos.x - 1, y = pos.y}
    else
        return {x = pos.x, y = pos.y - 1}
    end
end
function Map:IsGridMovable(uid, vector)
    local index = self:Coord2Index(vector)
    local grid = self.grids[index]
    if grid ~= nil then
        return grid:IsWalkable()
    end
    return false
end
function Map:GetPathToGoal(uid, vector)
    local unit = curSession.field:GetUnitByUid(uid)
    return self:AStar(uid, unit.transform.position, vector)
end
-- a* find a path of source->target, return the a point list
function Map:AStar(uid, source, target)
    local distCal = function(pos)
        return math.abs(pos.x - target.x) + math.abs(pos.y - target.y)
    end
    local queue = {
        {
            x = source.x,
            y = source.y,
            cost = 0,
            dist = distCal(source),
            weight = distCal(source),
            parent = nil
        }
    }
    local closedMap = {}
    local matrix = {
        {x = 0, y = 1, cost = 1},
        {x = 0, y = -1, cost = 1},
        {x = -1, y = 0, cost = 1},
        {x = 1, y = 0, cost = 1}
    }
    local resultP
    while #queue > 0 do
        local curP = queue[1]
        local sx = curP.x
        local sz = curP.z
        -- if curP is near target-point then return this result
        if curP.x == target.x and curP.y == target.y then
            resultP = curP
            break
        end
        -- mark current point in closedMap
        closedMap[self:Coord2Index(curP)] = true
        for i = 1, #matrix do
            local newP = {
                x = curP.x + matrix[i].x,
                y = curP.y + matrix[i].y
            }
            if self:IsCoordValid(newP) and closedMap[self:Coord2Index(newP)] ~= true and self:IsGridMovable(uid, newP) then
                -- this point is a new point
                local sameP =
                    table.find_if(
                    queue,
                    function(p)
                        return p.x == newP.x and p.y == newP.y
                    end
                )
                if sameP == nil then
                    newP.cost = curP.cost + matrix[i].cost
                    newP.dist = distCal(newP)
                    newP.weight = newP.cost + distCal(newP)
                    newP.parent = curP
                    table.insert(queue, newP)
                else
                    if sameP.weight > curP.cost + matrix[i].cost + distCal(newP) then
                        sameP.cost = curP.cost + matrix[i].cost
                        sameP.dist = distCal(newP)
                        sameP.weight = sameP.cost + sameP.dist
                        sameP.parent = curP
                    end
                end
            end
        end
        table.remove(queue, 1)
        table.sort(
            queue,
            function(a, b)
                return a.weight < b.weight
            end
        )
    end

    if resultP == nil then
        local sourceStr = "[" .. tostring(source.x) .. "," .. tostring(source.y) .. "]"
        local targetStr = "[" .. tostring(target.x) .. "," .. tostring(target.y) .. "]"
        Debug.Warn("cannot find a path from " .. sourceStr .. " to " .. targetStr)
        return {}
    else
        local pathList = {}
        table.insert(pathList, {x = resultP.x, y = resultP.y})
        while resultP.parent ~= nil do
            resultP = resultP.parent
            table.insert(pathList, 1, {x = resultP.x, y = resultP.y})
        end
        return pathList
    end
end

function Map:GetReachableRegion(uid, distance)
    local unit = curSession.field:GetUnitByUid(uid)
    local speed = distance
    local region = {}
    local queryArr = {}
    local closedArr = {}
    local queryPoint = {
        point = unit.transform.position,
        cost = 0
    }
    table.insert(queryArr, queryPoint)
    while #queryArr > 0 do
        local curPoint = queryArr[1]
        local bMovable = self:IsGridMovable(uid, curPoint.point)
        local bStart = unit.transform.position.x == curPoint.point.x and unit.transform.position.y == curPoint.point.y
        if curPoint.cost <= speed and bMovable then
            table.insert(region, {x = curPoint.point.x, y = curPoint.point.y})
        end
        table.insert(closedArr, curPoint)
        if bMovable or bStart then
            for k, v in pairs(self.Direction) do
                local sidePos = self.GetAdjacentPos(curPoint.point, v)
                local res =
                    table.find_if(
                    closedArr,
                    function(ele)
                        return ele.point.x == sidePos.x and ele.point.y == sidePos.y
                    end
                )
                local sideCost = curPoint.cost + 1
                if res == nil and self:IsCoordValid(sidePos) and sideCost <= speed then
                    local newPoint = {
                        point = sidePos,
                        cost = sideCost
                    }
                    table.insert(queryArr, newPoint)
                end
            end
        end
        table.remove(queryArr, 1)
    end
    return region
end
-------- utils end ------------

return Map
