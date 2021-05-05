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
    Events = {
        [EventConst.ON_SELECT_CARD] = "OnSelect",
        [EventConst.ON_CANCEL_PLAYCARD] = "OnCancel"
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
    if self.selected then
        EventManager:Emit(EventConst.ON_CANCEL_PLAYCARD)
    else
        EventManager:Emit(EventConst.ON_SELECT_CARD, self.uid)
    end
end

function CardItem:OnSelect(uid)
    self.selected = self.uid == uid
    self.Selected:SetActive(self.selected)
end

function CardItem:OnCancel()
    self.selected = false
    self.Selected:SetActive(false)
end

return CardItem
