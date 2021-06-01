local BuffContainer = class("BuffContainer")

function BuffContainer:ctor(unit)
    self.master = unit
end

return BuffContainer
