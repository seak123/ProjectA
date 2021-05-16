local BaseNode = class("BaseNode")

BaseNode.NodeType = {
    Move = 1,
    Anim = 2,
    Damage = 3,
    Death = 4,
}

BaseNode.event = ""
BaseNode.delay = 0

function BaseNode:ctor()
    self.parant = nil
    self.followers = {}
    self.companions = {}
end

-- follow node
function BaseNode:AddFollower(node)
    table.insert(self.followers, node)
    node.parent = self
end
-- company node
function BaseNode:AddCompanion(node)
    table.insert(self.companions, node)
    node.parent = self
end

return BaseNode
