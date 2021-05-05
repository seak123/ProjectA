local BaseParam = class("BaseParam")

BaseParam.TaskType = {
    Target = 0,
    Path = 1,
}

function BaseParam:ctor()
    self.taskType = nil
end

function BaseParam:GetType()
    return self.taskType
end

return BaseParam
