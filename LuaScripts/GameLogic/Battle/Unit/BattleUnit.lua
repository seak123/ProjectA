local Unit = class("BattleUnit")

function Unit:ctor(unitVO)
    self.vo = unitVO
    self.HandCards = {}
    self.CardPile = {}
    self.DiscardPile = {}
end

function Unit:DrawACard()
end

function Unit:OnRoundBegin()
    for i = 1, self.vo.RoundDrawNum do
        self:DrawACard()
    end
end

return Unit
