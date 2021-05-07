local LuaBehaviour = require("GameCore.Frame.LuaBehaviour")
local BattleMainPanel = class("BattleMainPanel", LuaBehaviour)
local InputOrder = require("GameLogic.Battle.Trace.InputOrder")

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
            Name = "AnchorBottom/ConfirmBtn",
            Alias = "ConfirmBtn",
            Type = CS.UnityEngine.UI.Button,
            Handler = {
                onClick = "OnConfirm"
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
        [EventConst.ON_SELECT_CARD] = "OnSelectCard",
        [EventConst.ON_CANCEL_PLAYCARD] = "OnCancelCard",
        [EventConst.ON_PLAYCARD_READY_CHANGE] = "OnReadyChange"
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

    self:RefreshCardView()
end

function BattleMainPanel:OnAwake()
end

function BattleMainPanel:OnStart()
end

function BattleMainPanel:OnReqPass()
    local order = InputOrder.new()
    order.type = InputOrder.Type.Pass
    curSession.stateMachine:InputOrder(order)
end

function BattleMainPanel:OnConfirm()
    if self.readyOrder ~= nil then
        EventManager:Emit(EventConst.ON_INPUT_ORDER, self.readyOrder)
        EventManager:Emit(EventConst.ON_CONFIRM_PLAYCARD)
    else
        Debug.Error("Temp to confirm play card, but input-param is nil")
    end
end

function BattleMainPanel:OnReqCancel()
    EventManager:Emit(EventConst.ON_CANCEL_PLAYCARD)
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

function BattleMainPanel:OnCancelCard()
    self.opCard = nil
    self:RefreshCardView()
end

function BattleMainPanel:RefreshCardView()
    self.UnitName.text = self.opUnit and self.opUnit.vo.Name or ""
    self.PassBtn.gameObject:SetActive(self.opCard == nil)
    self.CancelBtn.gameObject:SetActive(self.opCard ~= nil)
    self.ConfirmBtn.gameObject:SetActive(self.readyOrder ~= nil)
end

function BattleMainPanel:OnReadyChange(bReady, csOrder)
    local order = nil
    if bReady then
        order = InputOrder.new()
        order:ParseFromCS(csOrder)
    end

    self.readyOrder = order
    self:RefreshCardView()
end

return BattleMainPanel
