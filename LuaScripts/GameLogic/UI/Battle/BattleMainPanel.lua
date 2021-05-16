local LuaBehaviour = require("GameCore.Frame.LuaBehaviour")
local BattleMainPanel = class("BattleMainPanel", LuaBehaviour)
local InputOrder = require("GameLogic.Battle.Trace.InputOrder")
local StateStage = require("GameLogic.Battle.StateMachine.States.BaseState").StateStage

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
        },
        {
            Name = "AnchorBottom/DiscardBtn",
            Alias = "DiscardBtn",
            Type = CS.UnityEngine.UI.Button,
            Handler = {
                onClick = "OnReqDiscard"
            }
        }
    },
    Events = {
        [EventConst.ON_BATTLE_ROUND_BEGIN] = "OnRoundBegin",
        [EventConst.ON_SELECT_OP_UNIT] = "OnSelectUnit",
        [EventConst.ON_REFRESH_BATTLE_UI] = "RefreshCardView",
        [EventConst.ON_PLAYCARD_READY_CHANGE] = "OnReadyChange",
        [EventConst.ON_CARD_DROPED] = "OnDropCard"
    }
}

function BattleMainPanel:ctor(obj)
    self.super.ctor(self, obj, setting)
    self.opUnit = nil
    self.bReady = false

    self.CardView.getFunc = function(index)
        if self.opUnit ~= nil and index <= #self.opUnit.handCards then
            return self.opUnit.handCards[index]
        end
        return nil
    end
    self.CardView:Init("UI/Prefabs/Battle/UI_CardItem", 150)

    if curSession.stateMachine.curOpUnit ~= nil then
        self:OnSelectUnit(curSession.stateMachine.curOpUnit.uid)
    else
        self:RefreshCardView()
    end
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
        EventManager:Emit(EventConst.ON_CONFIRM_PLAYCARD)
        EventManager:Emit(EventConst.ON_INPUT_ORDER, self.readyOrder)
    else
        Debug.Error("Temp to confirm play card, but input-param is nil")
    end
end

function BattleMainPanel:OnReqCancel()
    EventManager:Emit(EventConst.ON_CANCEL_SELECT)
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

function BattleMainPanel:OnDropCard()
    self.CardView:RefreshView()
end

function BattleMainPanel:RefreshCardView()
    local isInPlayState = curSession.stateMachine.curState.key == StateStage.PlayCard
    local isInDropState = curSession.stateMachine.curState.key == StateStage.DropCard
    local hasSelectCard = #curSession.stateMachine.curSelectCards > 0

    self.UnitName.text = self.opUnit and self.opUnit.vo.Name or ""
    self.PassBtn.gameObject:SetActive(isInPlayState and not hasSelectCard)
    self.CancelBtn.gameObject:SetActive(hasSelectCard)
    self.ConfirmBtn.gameObject:SetActive(isInPlayState and self.bReady)
    self.DiscardBtn.gameObject:SetActive(isInDropState and hasSelectCard)
end

function BattleMainPanel:OnReadyChange(bReady, csOrder)
    if bReady then
        local order = InputOrder.new()
        order:ParseFromCS(csOrder)
        self.readyOrder = order
    end
    self.bReady = bReady

    self:RefreshCardView()
end

function BattleMainPanel:OnReqDiscard()
    local order = InputOrder.new()
    order.type = InputOrder.Type.Drop
    order.unitUid = curSession.stateMachine.curOpUnit.uid
    order.cards = curSession.stateMachine.curSelectCards
    curSession.stateMachine:InputOrder(order)
end

return BattleMainPanel
