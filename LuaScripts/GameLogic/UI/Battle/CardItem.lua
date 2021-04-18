local LuaBehaviour = require("GameCore.Frame.LuaBehaviour")
local CardItem = class("CardItem", LuaBehaviour)

local BattleOpState = {}

local setting = {
    Elements = {
        {
            Name = "CardName",
            Type = CS.UnityEngine.UI.Text
        }
    }
}

function CardItem:ctor(obj)
    self.super.ctor(self, obj, setting)
end

function CardItem:SetData(data)
    self.CardName.text = data.Name
end

return CardItem
