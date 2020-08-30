Wave = createClass({
    unitCount = 20,
    unitName = 'npc_dota_hero_magnataur',
    playerID = nil,

    constructor = function(self, unitCount, unitName)
        self.unitCount = unitCount
        self.unitName = unitName
    end

}, {}, nil)

function Wave:spawnWave()
    local playerSpot

    --change to SpotList:getSpotByPlayerID()
    DeepPrintTable(SpotList)
    for _, spot in ipairs(SpotList) do
        DeepPrintTable(spot)
        print('kek')
        print(spot.playerID)
        print(self.playerID)
        if spot.playerID == self.playerID then
            playerSpot = spot
            break
        end
    end

    DeepPrintTable(playerSpot)
    self:createWave(playerSpot)
end

function Wave:createWave(playerSpot)
    for i = 30, 1, -1
    do
        local unit = CreateUnitByName(self.unitName, playerSpot.position, true, nil, nil, DOTA_TEAM_BADGUYS)
        FindClearSpaceForUnit(unit, Vector(0, 0, 128), true)
    end
end
