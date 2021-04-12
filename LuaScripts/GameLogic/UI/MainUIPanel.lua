local LuaBehaviour = require("GameCore.Frame.LuaBehaviour")
local MainUIPanel = class("MainUIPanel", LuaBehaviour)
local BattleLib = CS.BattleLuaLibrary
local BattleSession = require("GameLogic.Battle.BattleSession")

local setting = {
    Elements = {
        {
            Name = "Battle",
            Type = CS.UnityEngine.UI.Button,
            Handler = {
                onClick = "OnReqBattle"
            }
        }
    }
}

function MainUIPanel:ctor(obj)
    self.super.ctor(self, obj, setting)
end

function MainUIPanel:OnAwake()
end

function MainUIPanel:OnStart()
end

function MainUIPanel:OnReqBattle()
    BattleLib.ReqEnterBattle()
    BattleSession.StartBattle()
end

return MainUIPanel
