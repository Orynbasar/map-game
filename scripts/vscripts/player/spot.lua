SpotPositionList = {
    Vector(MAP_MIN_X + (1028 * 2), MAP_MAX_Y - (1028 * 5), 0),
    Vector(MAP_MIN_X + (1028 * 6), MAP_MAX_Y - (1028 * 5), 0),
    Vector(MAP_MIN_X + (1028 * 10), MAP_MAX_Y - (1028 * 5), 0),
    Vector(MAP_MIN_X + (1028 * 14), MAP_MAX_Y - (1028 * 5), 0),
    Vector(MAP_MIN_X + (1028 * 2), MAP_MAX_Y - (1028 * 11), 0),
    Vector(MAP_MIN_X + (1028 * 6), MAP_MAX_Y - (1028 * 11), 0),
    Vector(MAP_MIN_X + (1028 * 10), MAP_MAX_Y - (1028 * 11), 0),
    Vector(MAP_MIN_X + (1028 * 14), MAP_MAX_Y - (1028 * 11), 0),
}

SpotList = {}

Spot = createClass({
    playerID = nil,
    position = nil,

    constructor = function(self, playerID, position)
        self.playerID = playerID
        self.position = position
    end
}, {}, nil)

function SpotList:getSpotByPlayerID(playerID)
    for _, spot in ipairs(SpotList) do
        if spot.playerID == playerID then
            return spot
        end
    end
end

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