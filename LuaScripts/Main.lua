require("GameBase.Utils.Functions")
require("GameBase.Utils.Handle")
require("GameBase.Utils.List")

_G.Math = require("GameBase.Utils.MathUtil")
_G.Debug = require("GameBase.Utils.DebugUtil")
_G.EventConst = require("GameCore.Constant.EventConst")
_G.EventManager = require("GameBase.Event.EventManager").new()
_G.BehaviourManager = require("GameCore.Frame.BehaviourManager").new()

_G.BattleSession = require("GameLogic.Battle.BattleSession")

function RootFunction()
    print("hello world")
end
