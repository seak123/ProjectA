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
        [EventConst.ON_SELECT_OP_UNIT] = "OnSelectUnit"
    }
}

function BattleMainPanel:ctor(obj)
    self.super.ctor(self, obj, setting)
    self.opUnit = nil

    self.CardView.getFunc = function(index)
        if self.opUnit ~= nil and index <= #self.opUnit.handCards then
            return self.opUnit.handCards[index].config
        end
        return nil
    end
    self.CardView:Init("UI/Prefabs/Battle/UI_CardItem", 150)

    self:OnSelectUnit(curSession.stateMachine.curOpUnit.uid)
end

function BattleMainPanel:OnAwake()
end

function BattleMainPanel:OnStart()
end

function BattleMainPanel:OnReqPass()
    print("req pass")
end

function BattleMainPanel:OnReqCancel()
    print("req cancel")
end

function BattleMainPanel:OnRoundBegin()
    print("round begin")
    self:RefreshCardView()
end

function BattleMainPanel:OnSelectUnit(uid)
    self.opUnit = curSession.field:GetUnitByUid(uid)
    if self.opUnit ~= nil then
        self.UnitName.text = self.opUnit.vo.Name
        self:RefreshCardView()
    end
end

function BattleMainPanel:RefreshCardView()
    self.CardView:RefreshView()
end

return BattleMainPanel
