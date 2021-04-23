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

function CardItem:SetData(cardEntity)
    self.uid = cardEntity.uid
    self.CardName.text = cardEntity.config.name
end

return CardItem
