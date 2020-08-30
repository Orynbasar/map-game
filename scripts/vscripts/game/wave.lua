Wave = createClass({
    unitCount = 20,
    unitName = 'npc_dota_hero_magnataur',
    playerID = nil,

    constructor = function(self, unitCount, unitName)
        self.unitCount = unitCount
        self.unitName = unitName
    end

}, {}, nil)

function startWave()
    local player = PlayerResource:GetPlayer(0)
    local hero = player:GetAssignedHero()

    for i = 50, 1, -1
    do
        if hero ~= nil then
            local unit = CreateUnitByName("npc_dota_creep_badguys_melee",
                    Vector(0, 0, 128), true, hero, hero, hero:GetTeamNumber())

            unit:SetControllableByPlayer(player:GetPlayerID(), true)
            FindClearSpaceForUnit(unit, Vector(0, 0, 128), true)

        end

    end

end
