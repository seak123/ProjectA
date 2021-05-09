local LuaBehaviour = require("GameCore.Frame.LuaBehaviour")
local StandardCard = class("StandardCard", LuaBehaviour)
local CardConfig = require("GameLogic.Config.CardConfig")
local Property = require("GameLogic.Battle.Unit.Component.Property")

local setting = {
    Elements = {
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
            Name = "CardDesc",
            Type = CS.UnityEngine.UI.Text
        }
    }
}

function StandardCard:ctor(obj)
    self.super.ctor(self, obj, setting)
end

function StandardCard:InitCard(id)
    local config = CardConfig.Cards[id]
    self.CardName.text = config.name
    self.EnergyCost.text = config.cost

    self.EnergyCost.gameObject:SetActive(config.cost ~= 0 and true or false)
    -- "Attributes"
    local attr = config.attributes
    for i = 1, #self.Attributes do
        if attr[i] ~= nil then
            self.Attributes[i].text = attr[i].desc
            self.Attributes[i].color = CS.UnityEngine.Color(attr[i].color.r, attr[i].color.g, attr[i].color.b)
            self.Attributes[i].gameObject:SetActive(true)
        else
            self.Attributes[i].gameObject:SetActive(false)
        end
    end
    self.CardDesc.text = self:ParseDescrition(config.descrition)
end

function StandardCard:ParseDescrition(rawDesc)
    local unit = curSession.stateMachine.curOpUnit
    local list = string.split(rawDesc, " ")
    local desc = ""
    for i = 1, #list do
        if string.sub(list[i], 1, 1) == "$" then
            -- get property
            local propName = string.sub(list[i], 2, string.len(list[i]))
            --
            local value = unit.property:GetValue(propName)
            list[i] = Property.PropDesc[propName] .. "(" .. tostring(value) .. ")"
        end
        desc = desc .. list[i] .. " "
    end
    return desc
end

return StandardCard
