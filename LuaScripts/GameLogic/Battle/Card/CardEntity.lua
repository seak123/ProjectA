local CardEntity = class("CardEntity")
local CardConfig = require("GameLogic.Config.CardConfig")

function CardEntity:ctor(id,master)
    self.uid = 0
    self.master = master
    self.config = CardConfig.Cards[id]
end

function CardEntity:OnHand()
    -- body
end

function CardEntity:OnDiscard()
    -- body
end

return CardEntity
