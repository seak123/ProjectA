local MoveAction = {}

function MoveAction.Execute(target, path)
    for i = 1, #path do
        curSession.map:MoveUnit(target, path[i])
    end
end

return MoveAction
