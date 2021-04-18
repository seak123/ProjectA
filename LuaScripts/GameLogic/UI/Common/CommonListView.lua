local LuaBehaviour = require("GameCore.Frame.LuaBehaviour")
local CommonListView = class("CommonListView", LuaBehaviour)
local UILibrary = CS.UILibrary

local setting = {
    Elements = {
        {
            Name = ".",
            Alias = "ScrollView",
            Type = CS.UnityEngine.UI.ScrollRect
        },
        {
            Name = ".",
            Alias = "Root"
        },
        {
            Name = "Viewport/Content",
            Alias = "Content"
        }
    }
}

function CommonListView:ctor(obj)
    self.super.ctor(self, obj, setting)
    self.vertical = false
    self.getFunc = nil
    self.items = {}

    self.itemPrefabPath = ""

    self.contentHeight = 1
    self.contentWidth = 1
    self.viewHeight = 1
    self.viewWidth = 1

    self.itemCount = 0
    self.itemSize = 0
end

function CommonListView:Init(itemPath, itemSize)
    if self.getFunc == nil then
        return Debug.Warn("[CommonListView] getFunc is nil")
    end

    self.itemSize = itemSize
    self.itemPrefabPath = itemPath

    self.contentHeight = self.Content:GetComponent(typeof(CS.UnityEngine.RectTransform)).sizeDelta.y
    self.contentWidth = self.Content:GetComponent(typeof(CS.UnityEngine.RectTransform)).sizeDelta.x

    self:RefreshView()
end

function CommonListView:OnAwake()
end

function CommonListView:OnStart()
end

function CommonListView:RefreshView()
    self:ClearItems()
    if self.vertical then
        --TODO
    else
        local index = 1
        while self.getFunc(index) ~= nil do
            -- TODO improve
            local obj = CS.UILibrary.AddUIFrame(self.itemPrefabPath)
            obj.transform:SetParent(self.Content.transform)

            obj.transform.anchoredPosition = CS.UnityEngine.Vector2((0.5 + index - 1) * self.itemSize, 0)

            table.insert(self.items, obj)
            local lb = BehaviourManager:GetBehaviour(obj:GetInstanceID())
            lb:SetData(self.getFunc(index))

            index = index + 1
        end
        -- init content
        local y = self.ScrollView.content.sizeDelta.y
        self.ScrollView.content.sizeDelta = CS.UnityEngine.Vector2(self.itemSize * (index - 1), y)
    end
end

function CommonListView:ClearItems()
    for i = 1, #self.items do
        if self.items[i] ~= nil then
            CS.WindowsUtil.RemoveWindow(self.items[i])
        end
    end
    self.items = {}
end

return CommonListView
