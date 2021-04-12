local BaseState = class("BaseState")

BaseState.StateStage = {
    NoneStage = 1,
    PreGame = 2,
    RoundBegin = 3,
    PlayCard = 4,
    RoundEnd = 5,
    GameEnd = 6
}

function BaseState:ctor()
end

return BaseState
