function startWave()

    local player = PlayerResource:GetPlayer(0)
    local team = player:GetTeam()
    print(team)
    local playerID = player:GetPlayerID()
    local hero = player:GetAssignedHero()

    print('---------------------------------')
    print(player)
    print(playerID)
    print(hero)
    print(team)
    print('---------------------------------')

    if hero ~= nil then
        local unit = CreateUnitByName("npc_dota_creep_badguys_melee",
                Vector(0, 0, 0), true, hero, hero, hero:GetTeamNumber())

        unit:SetControllableByPlayer(playerID, true)
    end
end
