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

}, { rowCount = 3 }, nil)

function Wave:spawnWave()
    Log:info('Spawn wave for player:' .. self.playerID)
    local playerSpot = SpotList:getSpotByPlayerID(self.playerID)
    local waveSpotCenter = playerSpot.position + Vector(0, MAP_Y_BETWEEN_DEFENDER_AND_WAVE)
    local waveSpotFirstEdge = waveSpotCenter - Vector(MAP_SPOT_X_LENGTH / 2, -MAP_WAVE_Y_LENGTH / 2)

    local unitsWithPriority = reduceUnitPacksToUnitWithPriorityTable(self.units)

    local totalUnitsCount = #unitsWithPriority
    local unitCountInRow = math.ceil(totalUnitsCount / self.rowCount)

    table.sort(unitsWithPriority, function (a, b) return (a.frontLinePriority > b.frontLinePriority) end)

    for index, unit in pairs(unitsWithPriority) do
        local row = math.ceil(index / unitCountInRow)
        local column = ((index - 1) % unitCountInRow) + 1
        local oneUnitYLength = MAP_WAVE_Y_LENGTH / 4
        local oneUnitXLength = 0

        if row ~= self.rowCount then
            oneUnitXLength = MAP_SPOT_X_LENGTH / (unitCountInRow + 1)
        else
            oneUnitXLength = MAP_SPOT_X_LENGTH / (totalUnitsCount - (unitCountInRow * 2) + 1)
        end

        local unitPosition = waveSpotFirstEdge - Vector(-oneUnitXLength * column, oneUnitYLength * (self.rowCount - (row - 1)))
        local createdUnit = CreateUnitByName(unit.unitName, unitPosition, true, nil, nil, DOTA_TEAM_BADGUYS)
        FindClearSpaceForUnit(createdUnit, unitPosition, true)
    end
end

function reduceUnitPacksToUnitWithPriorityTable(units)
    local unitsWithPriority = {}

    for _, unitPack in ipairs(units) do
        for _ = 1, unitPack.unitCount, 1 do
            table.insert(unitsWithPriority, {
                unitName = unitPack.unitName,
                frontLinePriority = unitPack.frontLinePriority
            })
        end
    end

    return unitsWithPriority
end