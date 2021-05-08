local BaseNode = class("BaseNode")

BaseNode.NodeType = {
    Move = 1
}

function BaseNode:ctor()
    self.followers = {}
    self.companions = {}
end

-- follow node
function BaseNode:AddFollower(node)
    table.insert(self.followers, node)
end
-- company node
function BaseNode:AddCompanion(node)
    table.insert(self.companions, node)
end

return BaseNode
