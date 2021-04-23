local MoveRawAction = {}

function MoveRawAction.Execute(target, path)
    for i = 1, #path do
        curSession.map:MoveUnit(target, path[i])
    end
end

return MoveRawAction
