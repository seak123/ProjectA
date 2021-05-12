local Performer = class("BattlePerformer")

function Performer:ctor()
    self.rootNode = nil
    self.curNode = nil
end

function Performer:PushNode(node, bCompanion)
    if self.rootNode == nil then
        self.rootNode = node
    else
        if bCompanion == nil or bCompanion == false then
            self.curNode:AddFollower(node)
        else
            self.curNode:AddCompanion(node)
        end
    end
    self.curNode = node
end

function Performer:Fallback()
    if self.curNode.parent ~= nil then
        self.curNode = self.curNode.parent
    end
end

function Performer:Perform()
    if self.rootNode ~= nil then
        EventManager:Emit(EventConst.ON_PERFORM_START, self.rootNode)
    end
    self.rootNode = nil
end

return Performer
