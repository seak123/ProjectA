local MoveRawAction = {}

function MoveRawAction.Execute(uid, path)
    local target = curSession.field:GetUnitByUid(uid)
    for i = 1, #path do
        curSession.map:MoveUnit(target, path[i])
    end
end

return MoveRawAction
