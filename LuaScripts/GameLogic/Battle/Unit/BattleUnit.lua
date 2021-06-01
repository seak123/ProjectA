local Base = require("GameLogic.Battle.Unit.BaseUnit")
local Unit = class("BattleUnit", Base)
local Property = require("GameLogic.Battle.Unit.Component.Property")
local Transform = require("GameLogic.Battle.Unit.Component.Transform")
local BuffContainer = require("GameLogic.Battle.Unit.Component.BuffContainer")
local CardEntity = require("GameLogic.Battle.Card.CardEntity")
local ComAnimRawAct = require("GameLogic.Battle.Actions.RawAction.ComAnimRawAction")
local DeathNode = require("GameLogic.Battle.Actions.PerformNode.DeathNode")

function Unit:ctor(unitVO)
    self.vo = unitVO
    self.camp = unitVO.Camp
    self.uid = 0
    self.handCards = {}
    self.cardPile = {}
    self.discardPile = {}
    self:InitComponents()
end

function Unit:InitComponents()
    self.property = Property.new(self)
    self.transform = Transform.new(self)
    self.container = BuffContainer.new(self)

    for i = 0, self.vo.Cards.Count - 1 do
        local card = CardEntity.new(self.vo.Cards[i], self)
        card.uid = i + 1
        table.insert(self.cardPile, card)
    end
end
----------- card logic -----------------------
function Unit:DrawACard()
    if #self.cardPile > 0 then
        local card = self.cardPile[1]
        table.insert(self.handCards, card)
        table.remove(self.cardPile, 1)
        card:OnHand()
    end
end

function Unit:DropACard(uid)
    local card = nil
    for i = 1, #self.handCards do
        if self.handCards[i].uid == uid then
            card = self.handCards[i]
            table.remove(self.handCards, i)
            break
        end
    end
    if card then
        table.insert(self.discardPile, card)
        card:OnDiscard()
        EventManager:Emit(EventConst.ON_CARD_DROPED, card.uid)
    end
end

function Unit:PlayACard(uid)
    local card = nil
    for i = 1, #self.handCards do
        if self.handCards[i].uid == uid then
            card = self.handCards[i]
            table.remove(self.handCards, i)
            break
        end
    end
    if card then
        table.insert(self.discardPile, card)
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

function Unit:NeedDropNum()
    return math.max(0, #self.handCards - self.vo.RoundEndKeepNum)
end

----------- card logic -----------------------

function Unit:OnRoundBegin()
    for i = 1, self.vo.RoundDrawNum do
        self:DrawACard()
    end
end

function Unit:OnRoundEnd()
    --self.vo.RoundEndKeepNum
end

function Unit:OnDamage(source, value)
    self.property:AddValue(self.property.PropDef.Hp, -value)
    local hp = self.property:GetValue(self.property.PropDef.Hp)
    if hp > 0 then
        ComAnimRawAct.Execute(self.uid, "Hurt")
        curSession.performer:Fallback()
    else
        curSession.field:RemoveUnit(self.uid)
        ComAnimRawAct.Execute(self.uid, "Dead")
        local deathNode = DeathNode.new()
        deathNode.caster = self.uid
        curSession.performer:PushNode(deathNode)
        curSession.performer:Fallback()
        curSession.performer:Fallback()
    end
end

-------------- trigger start -----------------
local RegTrigger = function(TrigName)
    Unit[TrigName] = function(self)
        self:TriggerEvent(TrigName)
    end
end

-- simple trigger register
RegTrigger("PostMove")
-------------- trigger end -------------------

return Unit
