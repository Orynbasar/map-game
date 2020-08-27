function startWave()

    local player = PlayerResource:GetPlayer(0)
    local hero = player:GetAssignedHero()

    if hero ~= nil then
        local unit = CreateUnitByName("npc_dota_creep_badguys_melee",
                Vector(-8192, -8192, 128), true, hero, hero, hero:GetTeamNumber())

        unit:SetControllableByPlayer(player:GetPlayerID(), true)
    end
end
