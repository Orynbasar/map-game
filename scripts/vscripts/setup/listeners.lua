if CustomListeners == nil then
    CustomListeners = class({})
end

function CustomListeners:init()
    ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(CustomListeners, 'OnGameRulesStateChange'), self)
end

function CustomListeners:OnGameRulesStateChange()
    local state = GameRules:State_Get()

    Log:debug('new game state ' .. state)

    if state == DOTA_GAMERULES_STATE_HERO_SELECTION then
        for _, v in ipairs(Teams) do
            self.selectHeroForTeam(v)
        end
    end

    if state == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        SpotList.init()
        Game.init()
        Game.start()
    end
end

function CustomListeners.selectHeroForTeam(teamNum)
    local playerID = PlayerResource:GetNthPlayerIDOnTeam(teamNum, 1)
    if playerID ~= nil then
        if not PlayerResource:HasSelectedHero(playerID) then
            local hPlayer = PlayerResource:GetPlayer(playerID)
            if hPlayer ~= nil then
                Log:info('Create hero for player:' .. playerID)
                UTIL_Remove(CreateHeroForPlayer('npc_dota_hero_magnataur', hPlayer))
            end
        end
    end
end
