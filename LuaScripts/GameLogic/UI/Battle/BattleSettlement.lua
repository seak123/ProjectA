local LuaBehaviour = require("GameCore.Frame.LuaBehaviour")
local BattleSettlement = class("BattleSettlement", LuaBehaviour)

local setting = {
    Elements = {
        {
            Name = "Title",
            Type = CS.UnityEngine.UI.Text
        },
        {
            Name = "Confirm",
            Type = CS.UnityEngine.UI.Button,
            Handler = {
                onClick = "OnConfirm"
            }
        }
    }
}

function BattleSettlement:ctor(obj)
    self.super.ctor(self, obj, setting)
end

function BattleSettlement:SetResult(win)
    if win then
        self.Title.text = "Victory"
    else
        self.Title.text = "Lose"
    end
end

function BattleSettlement:OnConfirm()
    CS.UILibrary.RemoveUIFrame(self._target)
end

return BattleSettlement
