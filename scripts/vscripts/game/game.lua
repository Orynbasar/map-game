Game = {
    waveNumber = 0,
    playersPool = {},
}

function Game.init()
    local playerCount = 1
    for _, team in ipairs(Teams) do
        local playerID = PlayerResource:GetNthPlayerIDOnTeam(team, 1)
        if playerID ~= -1 then
            Game.playersPool[playerCount] = playerID
            playerCount = playerCount + 1
        end
    end
end

function Game.initDefenderTable()
    for _, playerID in ipairs(Game.playersPool) do
        DefenderTable[playerID] = {}

        local playerSpotPosition = SpotList:getSpotByPlayerID(playerID).position

        local xStep = MAP_SPOT_X_LENGTH / (DEFENDERS_COUNT_X + 1)
        local yStep = MAP_DEFENDERS_Y_LENGTH / (DEFENDERS_COUNT_Y + 1)

        local defendersSpotCenter = playerSpotPosition + Vector(0, MAP_SPOT_CENTER_TO_DEFENDER_Y_LENGTH, 0)
        local defendersSpotFirstEdge = defendersSpotCenter - Vector(MAP_SPOT_X_LENGTH / 2, -MAP_WAVE_Y_LENGTH / 2, 0)

        for x = 1, DEFENDERS_COUNT_X do
            DefenderTable[playerID][x] = {}
            for y = 1, DEFENDERS_COUNT_Y do
                DefenderTable[playerID][x][y] = { playerSpot = defendersSpotFirstEdge + Vector(xStep * x, -yStep * y, 0) }
            end
        end
    end
end

function Game.start()
    Timers:CreateTimer(1, function()
        for _, playerID in ipairs(Game.playersPool) do
            Wave({ { unitCount = 5, unitName = 'npc_dota_creep_badguys_ranged', frontLinePriority = 20 },
                   { unitCount = 5, unitName = 'npc_dota_badguys_siege', frontLinePriority = 10 } }, playerID):spawnWave()
        end

        return 5000.0
    end)

end