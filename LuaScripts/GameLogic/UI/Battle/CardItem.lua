local LuaBehaviour = require("GameCore.Frame.LuaBehaviour")
local CardItem = class("CardItem", LuaBehaviour)
local CardConfig = require("GameLogic.Config.CardConfig")

local setting = {
    Elements = {
        {
            Name = ".",
            Type = CS.UnityEngine.UI.Button,
            Handler = {
                onClick = "OnClick",
                onLongPress = "OnLongPress",
                onLongPressEnd = "OnLongPressEnd"
            }
        },
        {
            Name = ".",
            Type = CS.UnityEngine.UI.Image,
            Alias = "BackImage"
        },
        {
            Name = "CardName",
            Type = CS.UnityEngine.UI.Text
        },
        {
            Name = "EnergyCost",
            Type = CS.UnityEngine.UI.Text
        },
        {
            Name = "Attributes/Attr_",
            Alias = "Attributes",
            Count = 5,
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
    self.id = cardEntity.config.id
    self.CardName.text = cardEntity.config.name
    self.EnergyCost.text = cardEntity.config.cost
    local backColor = CardConfig.CardTypeColors[cardEntity.config.type]
    self.BackImage.color = CS.UnityEngine.Color(backColor.r, backColor.g, backColor.b)

    self.EnergyCost.gameObject:SetActive(cardEntity.config.cost ~= 0 and true or false)

    -- "Attributes"
    local attr = cardEntity.config.attributes
    for i = 1, #self.Attributes do
        if attr[i] ~= nil then
            self.Attributes[i].text = attr[i].desc
            self.Attributes[i].color = CS.UnityEngine.Color(attr[i].color.r, attr[i].color.g, attr[i].color.b)
            self.Attributes[i].gameObject:SetActive(true)
        else
            self.Attributes[i].gameObject:SetActive(false)
        end
    end
end

function CardItem:OnClick()
    if self.selected then
        EventManager:Emit(EventConst.ON_CANCEL_PLAYCARD)
    else
        EventManager:Emit(EventConst.ON_SELECT_CARD, self.uid)
    end
end

function CardItem:OnLongPress()
    EventManager:Emit(EventConst.ON_SHOW_CARD_DETAIL, true, self.id)
end

function CardItem:OnLongPressEnd()
    EventManager:Emit(EventConst.ON_SHOW_CARD_DETAIL, false, 0)
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
