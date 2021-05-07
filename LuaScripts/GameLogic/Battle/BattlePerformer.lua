local Performer = class("BattlePerformer")

function Performer:ctor()
    self.rootNode = nil
    self.curNode = nil
end

function Performer:PushNode(node)
    if self.rootNode == nil then
        self.rootNode = node
        self.curNode = self.rootNode
    else
        self.curNode:AddFoNode(node)
        self.curNode = node
    end
end

function Performer:Perform()
    if self.rootNode ~= nil then
        EventManager:Emit(EventConst.ON_PERFORM_START, self.rootNode)
    end
    self.rootNode = nil
end

return Performer
