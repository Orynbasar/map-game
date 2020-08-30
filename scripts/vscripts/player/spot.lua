SpotPositionList = {}

SpotList = {}

Spot = createClass({
    playerID = nil,
    position = nil,

    constructor = function(self, playerID, x, y)
        self.playerID = playerID
        self.x = x
        self.y = y
    end
}, {}, nil)

function SpotList.init()
    SpotPositionList.init()
    local spotNum = 1

    for i, v in ipairs(Teams) do
        local player = PlayerResource:GetNthPlayerIDOnTeam(v, 1)
        if player ~= -1 then
            SpotList[spotNum] = Spot(player, SpotPositionList[spotNum])
            spotNum = spotNum + 1
        end
    end

    DeepPrintTable(SpotList)
    print('=========')
    DeepPrintTable(SpotPositionList)
end

function SpotPositionList.init()
    SpotPositionList[1] = Vector(-1000, -1000, 0)
    SpotPositionList[2] = Vector(0, -1000, 0)
    SpotPositionList[3] = Vector(1000, -1000, 0)
    SpotPositionList[4] = Vector(1000, 0, 0)
    SpotPositionList[5] = Vector(1000, 1000, 0)
    SpotPositionList[6] = Vector(0, 1000, 0)
    SpotPositionList[7] = Vector(-1000, 1000, 0)
    SpotPositionList[8] = Vector(-1000, 0, 0)
end