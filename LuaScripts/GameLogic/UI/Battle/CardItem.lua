local LuaBehaviour = require("GameCore.Frame.LuaBehaviour")
local CardItem = class("CardItem", LuaBehaviour)

local BattleOpState = {}

local setting = {
    Elements = {
        {
            Name = ".",
            Type = CS.UnityEngine.UI.Button,
            Handler = {
                onClick = "OnClick"
            }
        },
        {
            Name = "CardName",
            Type = CS.UnityEngine.UI.Text
        },
        {
            Name = "Selected"
        }
    },
    Events = 
    {
        [EventConst.ON_SELECT_CARD] = "OnSelect",
    }
}

function CardItem:ctor(obj)
    self.super.ctor(self, obj, setting)
    self.selected = false
    self.Selected:SetActive(false)
end

function CardItem:SetData(cardEntity)
    self.uid = cardEntity.uid
    self.CardName.text = cardEntity.config.name
end

function CardItem:OnClick()
    EventManager:Emit(EventConst.ON_SELECT_CARD, self.selected and 0 or self.uid)
end

function CardItem:OnSelect(uid)
    self.selected = self.uid == uid
    self.Selected:SetActive(self.selected)
end

return CardItem
