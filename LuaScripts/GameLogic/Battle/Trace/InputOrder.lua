local Order = class("InputOrder")

Order.Type = {
    Play = 0,
    Pass = 1
}

function Order:ctor()
end

function Order:ParseFromCS(csOrder)
    -- order type
    if csOrder.type == CS.OrderType.Play then
        self.type = Order.Type.Play
    elseif csOrder.type == CS.OrderType.Pass then
        self.type = Order.Type.Pass
    end
    self.paramTable = {}
    -- unit params
    self.paramTable.units = {}
    for i = 0, csOrder.units.Count - 1 do
        table.insert(self.units, csOrder.units[i])
    end
    -- path params
    self.paramTable.paths = {}
    for i = 0, csOrder.paths.Count - 1 do
        local pointList = csOrder.paths[i]
        local path = {}
        table.insert(self.paramTable.paths, path)
        for p = 1, pointList.Count - 1 do
            local point = {x = pointList[i].x, y = pointList[i].y}
            table.insert(path, point)
        end
    end
end

return Order
