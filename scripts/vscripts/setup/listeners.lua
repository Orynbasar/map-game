if CustomListeners == nil then
    CustomListeners = class({})
end

function CustomListeners:init()
    ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(CustomListeners, 'OnGameRulesStateChange'), self)
    ListenToGameEvent('npc_spawned', Dynamic_Wrap(CustomListeners, 'onUnitSpawn'), self)
end

function CustomListeners:onUnitSpawn(kv)
    local unit = EntIndexToHScript(kv.entindex)

    if unit:IsHero() then
        print(unit:GetName())
    end
end

function CustomListeners:OnGameRulesStateChange()
    local state = GameRules:State_Get()

    Log:debug('new game state ' .. state)

    if state == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        SpotList.init()
        Game.init()
        Game.initDefenderTable()
        HeroSelection.init()
        Game.start()
    end
end
