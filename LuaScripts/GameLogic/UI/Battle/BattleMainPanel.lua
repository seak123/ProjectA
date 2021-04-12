local LuaBehaviour = require("GameCore.Frame.LuaBehaviour")
local BattleMainPanel = class("BattleMainPanel", LuaBehaviour)


local setting = {
    Elements = {
        {
            Name = "Button",
            Type = CS.UnityEngine.UI.Button,
            Handler = {
                onClick = "OnConfirm"
            }
        },
    }
}

function BattleMainPanel:ctor(obj)
    self.super.ctor(self, obj, setting)
end

function BattleMainPanel:OnAwake()
end

function BattleMainPanel:OnStart()
  
end


function BattleMainPanel:OnConfirm()
    print("hello world")
end

return BattleMainPanel
