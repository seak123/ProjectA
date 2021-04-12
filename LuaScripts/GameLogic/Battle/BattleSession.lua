local BattleSession = class("BattleSession")
local BattleLib = CS.BattleLuaLibrary

function BattleSession:ctor()
end

function BattleSession.StartBattle()
    _G.curSession = BattleSession.new()
end

return BattleSession
