SpotPositionList = {
    [1] = Vector(-1000, -1000, 0),
    [2] = Vector(0, -1000, 0),
    [3] = Vector(1000, -1000, 0),
    [4] = Vector(1000, 0, 0),
    [5] = Vector(1000, 1000, 0),
    [6] = Vector(0, 1000, 0),
    [7] = Vector(-1000, 1000, 0),
    [8] = Vector(-1000, 0, 0)
}

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
    Log:trace('Start spots init')

    local spotNum = 1

    for _, v in ipairs(Teams) do
        local playerID = PlayerResource:GetNthPlayerIDOnTeam(v, 1)
        if playerID ~= -1 then
            Log:info('Init spot for player:' .. playerID)
            SpotList[spotNum] = Spot(playerID, SpotPositionList[spotNum])
            spotNum = spotNum + 1
        end
    end

    Log:trace('End spots init')
end