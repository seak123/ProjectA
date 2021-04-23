local Base = require("GameLogic.Battle.Unit.BaseUnit")
local Unit = class("BattleUnit", Base)
local Property = require("GameLogic.Battle.Unit.Component.Property")
local Transform = require("GameLogic.Battle.Unit.Component.Transform")
local CardEntity = require("GameLogic.Battle.Card.CardEntity")

function Unit:ctor(unitVO)
    self.vo = unitVO
    self.uid = 0
    self.handCards = {}
    self.cardPile = {}
    self.discardPile = {}
    self:InitComponents()
end

function Unit:InitComponents()
    self.property = Property.new(self)
    self.transform = Transform.new(self)

    for i = 0, self.vo.Cards.Count - 1 do
        local card = CardEntity.new(self.vo.Cards[i])
        card.uid = i + 1
        table.insert(self.cardPile, card)
    end
end

function Unit:DrawACard()
    if #self.cardPile > 0 then
        table.insert(self.handCards, self.cardPile[1])
        table.remove(self.cardPile, 1)
    end
end

function Unit:GetHandCard(uid)
    for i = 1, #self.handCards do
        if self.handCards[i].uid == uid then
            return self.handCards[i]
        end
    end
    return nil
end

function Unit:OnRoundBegin()
    for i = 1, self.vo.RoundDrawNum do
        self:DrawACard()
    end
end

-------------- trigger start -----------------
local RegTrigger = function(TrigName)
    Unit[TrigName] = function(self)
        self:TriggerEvent(TrigName)
    end
end

RegTrigger("PostMove")
-------------- trigger end -------------------

return Unit
