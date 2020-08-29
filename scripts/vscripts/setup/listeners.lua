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
        self.selectRandomHeroForTeam(DOTA_TEAM_CUSTOM_1)
        self.selectRandomHeroForTeam(DOTA_TEAM_CUSTOM_2)
        self.selectRandomHeroForTeam(DOTA_TEAM_CUSTOM_3)
        self.selectRandomHeroForTeam(DOTA_TEAM_CUSTOM_4)
        self.selectRandomHeroForTeam(DOTA_TEAM_CUSTOM_5)
        self.selectRandomHeroForTeam(DOTA_TEAM_CUSTOM_6)
        self.selectRandomHeroForTeam(DOTA_TEAM_CUSTOM_7)
        self.selectRandomHeroForTeam(DOTA_TEAM_CUSTOM_8)
    end

    if state == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
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
    print("Template addon script is running.")

    if GameRules:State_Get() > DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        return nil
    end
    return 1
end

