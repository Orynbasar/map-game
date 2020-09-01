Wave = createClass({
    units = {
        {
            unitCount = 20,
            unitName = 'npc_dota_creep_badguys_ranged',
            frontLinePriority = 10 --- more = front row, less = last row
        } --- feel free to add new units, like income units and etc...
    },
    playerID = nil,

    constructor = function(self, units, playerID)
        self.units = units
        self.playerID = playerID
    end

}, {}, nil)

function Wave:spawnWave()
    local playerSpot = SpotList:getSpotByPlayerID(self.playerID)
    local spawnPosition = playerSpot.position + Vector(0, MAP_Y_BETWEEN_DEFENDER_AND_WAVE, 0)
    local spawnPositionFirstEdge = spawnPosition - Vector(MAP_SPOT_X_LENGTH / 2, -MAP_WAVE_Y_LENGTH / 2)

    local units = {}

    for _, unitPack in ipairs(self.units) do
        for _ = 1, unitPack.unitCount, 1 do
            table.insert(units, {
                unitName = unitPack.unitName,
                frontLinePriority = unitPack.frontLinePriority
            })
        end
    end

    local totalUnitsCount = #units
    local rowCount = 3
    local unitCountInRow = math.ceil(totalUnitsCount / rowCount)
    local counter = 1

    for _, unitInPack in spairs(units, function(t, a, b)
        return t[b].frontLinePriority < t[a].frontLinePriority
    end) do
        local row = math.ceil(counter / unitCountInRow)
        local column = ((counter - 1) % unitCountInRow) + 1
        local oneUnitYLength = MAP_WAVE_Y_LENGTH / 4
        local oneUnitXLength = 0

        if row ~= rowCount then
            oneUnitXLength = MAP_SPOT_X_LENGTH / (unitCountInRow + 1)
        else
            oneUnitXLength = MAP_SPOT_X_LENGTH / (totalUnitsCount - (unitCountInRow * 2) + 1)
        end

        local unitPosition = spawnPositionFirstEdge - Vector(-oneUnitXLength * column, oneUnitYLength * (rowCount - (row - 1)), 0)
        local unit = CreateUnitByName(unitInPack.unitName, unitPosition, true, nil, nil, DOTA_TEAM_BADGUYS)
        FindClearSpaceForUnit(unit, unitPosition, true)
        counter = counter + 1
    end
end