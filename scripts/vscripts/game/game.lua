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

function Game.start()
    Timers:CreateTimer(3, function()
        DeepPrintTable(Game.playersPool)
        for _, playerID in ipairs(Game.playersPool) do
            Wave(10, 'npc_dota_hero_magnataur', playerID):spawnWave()
        end

        return 5.0
    end)

end