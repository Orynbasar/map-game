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
    Timers:CreateTimer(1, function()
        for _, playerID in ipairs(Game.playersPool) do
            Wave({ { unitCount = 5, unitName = 'npc_dota_creep_badguys_ranged', frontLinePriority = 20 } ,
                   { unitCount = 5, unitName = 'npc_dota_badguys_siege', frontLinePriority = 10 }   }, playerID):spawnWave()
        end

        return 5000.0
    end)

end