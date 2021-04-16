local Base = require("GameLogic.Battle.Unit.BaseUnit")
local Unit = class("BattleUnit", Base)
local Property = require("GameLogic.Battle.Unit.Component.Property")
local Transform = require("GameLogic.Battle.Unit.Component.Transform")

function Unit:ctor(unitVO)
    self.vo = unitVO
    self.handCards = {}
    self.cardPile = {}
    self.discardPile = {}
    self:InitComponents()
end

function Unit:InitComponents()
    self.property = Property.new(self)
    self.transform = Transform.new(self)
end

function Unit:DrawACard()
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
