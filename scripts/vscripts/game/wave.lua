Wave = createClass({
    unitCount = 20,
    unitName = 'npc_dota_creature_dire_ranged',
    playerID = nil,

    constructor = function(self, unitCount, unitName, playerID)
        self.unitCount = unitCount
        self.unitName = unitName
        self.playerID = playerID
    end

}, {}, nil)

function Wave:spawnWave()
    local playerSpot

    --change to SpotList:getSpotByPlayerID()
    for _, spot in ipairs(SpotList) do
        if spot.playerID == self.playerID then
            playerSpot = spot
            break
        end
    end

    self:createWave(playerSpot)
end

function Wave:createWave(playerSpot)
    for _ = 1, self.unitCount, 1
    do
        print(playerSpot.position)
        local unit = CreateUnitByName(self.unitName, playerSpot.position, true, nil, nil, DOTA_TEAM_BADGUYS)
        FindClearSpaceForUnit(unit, playerSpot.position, true)
    end
end
