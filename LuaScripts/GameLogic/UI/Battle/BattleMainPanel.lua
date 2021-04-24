local LuaBehaviour = require("GameCore.Frame.LuaBehaviour")
local BattleMainPanel = class("BattleMainPanel", LuaBehaviour)

local BattleOpState = {}

local setting = {
    Elements = {
        {
            Name = "AnchorBottom/CardView",
            Alias = "CardView",
            Script = "GameLogic.UI.Common.CommonListView"
        },
        {
            Name = "AnchorBottom/UnitName",
            Alias = "UnitName",
            Type = CS.UnityEngine.UI.Text
        },
        {
            Name = "AnchorBottom/PassBtn",
            Alias = "PassBtn",
            Type = CS.UnityEngine.UI.Button,
            Handler = {
                onClick = "OnReqPass"
            }
        },
        {
            Name = "AnchorBottom/CancelBtn",
            Alias = "CancelBtn",
            Type = CS.UnityEngine.UI.Button,
            Handler = {
                onClick = "OnReqCancel"
            }
        }
    },
    Events = {
        [EventConst.ON_BATTLE_ROUND_BEGIN] = "OnRoundBegin",
        [EventConst.ON_SELECT_OP_UNIT] = "OnSelectUnit",
        [EventConst.ON_SELECT_CARD] = "OnSelectCard"
    }
}

function BattleMainPanel:ctor(obj)
    self.super.ctor(self, obj, setting)
    self.opUnit = nil
    self.opCard = nil

    self.CardView.getFunc = function(index)
        if self.opUnit ~= nil and index <= #self.opUnit.handCards then
            return self.opUnit.handCards[index]
        end
        return nil
    end
    self.CardView:Init("UI/Prefabs/Battle/UI_CardItem", 150)

    self:OnSelectUnit(curSession.stateMachine.curOpUnit.uid)
    self:RefreshCardView()
end

function BattleMainPanel:OnAwake()
end

function BattleMainPanel:OnStart()
end

function BattleMainPanel:OnReqPass()
    print("req pass")
end

function BattleMainPanel:OnReqCancel()
    EventManager:Emit(EventConst.ON_SELECT_CARD, 0)
end

function BattleMainPanel:OnRoundBegin()
    print("round begin")
    self:RefreshCardView()
end

function BattleMainPanel:OnSelectUnit(uid)
    self.opUnit = curSession.field:GetUnitByUid(uid)
    self:RefreshCardView()
    self.CardView:RefreshView()
end

function BattleMainPanel:OnSelectCard(uid)
    self.opCard = curSession.stateMachine.curOpUnit:GetHandCard(uid)
    self:RefreshCardView()
end

function BattleMainPanel:RefreshCardView()
    self.UnitName.text = self.opUnit and self.opUnit.vo.Name or ""
    self.PassBtn.gameObject:SetActive(self.opCard == nil)
    self.CancelBtn.gameObject:SetActive(self.opCard ~= nil)
end

return BattleMainPanel
