local BaseAction = class("BaseAction")

BaseAction.ActionType = {
    Move = "GameLogic.Battle.Actions.MoveAction",
}
BaseAction.TargetType = {
    Self = 1,
    Enemy = 2
}

function BaseAction:ctor()
end

return BaseAction
