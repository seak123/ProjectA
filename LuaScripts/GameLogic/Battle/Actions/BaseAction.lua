local BaseAction = class("BaseAction")

BaseAction.ActionType = {
    Move = "GameLogic.Battle.Actions.MoveAction"
}
BaseAction.TargetType = {
    Self = 1,
    Enemy = 2
}

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

return BaseAction
