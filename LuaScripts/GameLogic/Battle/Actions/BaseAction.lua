local BaseAction = class("BaseAction")

BaseAction.ActionType = {
    Move = "GameLogic.Battle.Actions.MoveAction"
}

-- SubAction Trigger: "string": eventName; "number": delayTime; "nil": sequence

function BaseAction:ctor()
end

function BaseAction.GetParam(vo, name)
    local value = vo[name]
    if type(value) == "string" then
        local list = string.split(value, " ")
        local chunk = ""
        for i = 1, #list do
            if string.sub(list[i], 1, 1) == "$" then
                -- get property
                local propName = string.sub(list[i], 2, string.len(list[i]))
                --
                list[i] = 'unit.property:GetValue("' .. propName .. '")'
            end
            chunk = chunk .. list[i]
        end
        chunk = "local unit = curSession.stateMachine.curOpUnit return " .. chunk
        return load(chunk)()
    else
        return value
    end
end

function BaseAction:GetParamTable()
    return self:OrganizeParam()
end

function BaseAction:OrganizeParam()
end

function BaseAction:PlaySubAction(rootNode, params)
    local subActions = self.vo.subActions
    if subActions ~= nil and #subActions > 0 then
        for i = 1, #subActions do
            local action = require(subActions[i].actionType).new(subActions[i])
            local node = action:Play(params)
            local trigger = subActions[i].Trigger
            if trigger ~= nil then
                if type(trigger) == "string" then
                    node.event = trigger
                    rootNode:AddCompanion(node)
                elseif type(trigger) == "number" then
                    node.delay = trigger
                    rootNode:AddCompanion(node)
                else
                    Debug.Error("SubAction trigger-value is invalid type")
                end
            else
                rootNode:AddFollower(node)
            end
        end
    end
end

return BaseAction
