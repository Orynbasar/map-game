if CustomListeners == nil then
    CustomListeners = class({})
end

function CustomListeners:init()
    ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(CustomListeners, 'OnGameRulesStateChange'), self)
end

function CustomListeners:OnGameRulesStateChange()
    local state = GameRules:State_Get()

    print('new game state ', state)

    if state == DOTA_GAMERULES_STATE_HERO_SELECTION then
        for i, v in ipairs(Teams) do
            self.selectRandomHeroForTeam(v)
        end
    end

    if state == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        SpotList.init()
        GameRules:GetGameModeEntity():SetThink("OnThink", CustomListeners, "GlobalThink", 0)
    end
end

function CustomListeners.selectRandomHeroForTeam(teamNum)
    local playerID = PlayerResource:GetNthPlayerIDOnTeam(teamNum, 1)
    if playerID ~= nil then
        if not PlayerResource:HasSelectedHero(playerID) then
            local hPlayer = PlayerResource:GetPlayer(playerID)
            if hPlayer ~= nil then
                hPlayer:MakeRandomHeroSelection()
            end
        end
    end
end

function CustomListeners:OnThink()
    startWave()

    LimitPathingSearchDepth(1)

    if GameRules:State_Get() > DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        return nil
    end
    return 1
end

