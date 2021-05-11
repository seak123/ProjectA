local Performer = class("BattlePerformer")

function Performer:ctor()
    self.rootNode = nil
    self.lastNode = nil
end

function Performer:PushNode(node)
    if self.rootNode == nil then
        self.rootNode = node
    else
        self.curNode:AddFollower(node)
    end
    self.lastNode
end

function Performer:Perform()
    if self.rootNode ~= nil then
        EventManager:Emit(EventConst.ON_PERFORM_START, self.rootNode)
    end
    self.rootNode = nil
end

return Performer
