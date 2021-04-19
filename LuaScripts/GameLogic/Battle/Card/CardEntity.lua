local CardEntity = class("CardEntity")
local CardConfig = require("GameLogic.Config.CardConfig")

function CardEntity:ctor(id)
    self.uid = 0
    self.config = CardConfig.Cards[id]
end

return CardEntity
