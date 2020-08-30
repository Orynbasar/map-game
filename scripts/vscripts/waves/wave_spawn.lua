onceeeeeeee = true

function startWave()

    local player = PlayerResource:GetPlayer(0)
    local hero = player:GetAssignedHero()

    if onceeeeeeee then

        for i = 50,1,-1
        do
            if hero ~= nil then
                local unit = CreateUnitByName("npc_dota_creep_badguys_melee",
                        Vector(0, 0, 128), true, hero, hero, hero:GetTeamNumber())

                unit:SetControllableByPlayer(player:GetPlayerID(), true)
                FindClearSpaceForUnit(unit, Vector(0, 0, 128), true)
                onceeeeeeee = false

            end

        end
    end


end
