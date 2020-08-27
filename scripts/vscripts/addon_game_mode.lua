-- Generated from template

if CAddonTemplateGameMode == nil then
    CAddonTemplateGameMode = class({})
end

require('waves/wave_spawn')
require('setup/init')

function Precache(context)
    --[[
        Precache things we know we'll use.  Possible file types include (but not limited to):
            PrecacheResource( "model", "*.vmdl", context )
            PrecacheResource( "soundfile", "*.vsndevts", context )
            PrecacheResource( "particle", "*.vpcf", context )
            PrecacheResource( "particle_folder", "particles/folder", context )
    ]]
end

-- Create the game mode when we activate
function Activate()
    GameRules.AddonTemplate = CAddonTemplateGameMode()
    GameRules.AddonTemplate:InitGameMode()
end

function CAddonTemplateGameMode:InitGameMode()
    CAddonTemplateGameMode = self

    ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(CAddonTemplateGameMode, 'OnGameRulesStateChange'), self)
    init()

end

-- Evaluate the state of the game
function CAddonTemplateGameMode:OnThink()
    startWave()
    print("Template addon script is running.")

    if GameRules:State_Get() > DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        return nil
    end
    return 1
end

function CAddonTemplateGameMode:OnGameRulesStateChange(keys)
    local state = GameRules:State_Get()

    print('new game state ', state)

    if state == DOTA_GAMERULES_STATE_HERO_SELECTION then
        selectRandomHeroForTeam(DOTA_TEAM_CUSTOM_1)
        selectRandomHeroForTeam(DOTA_TEAM_CUSTOM_2)
        selectRandomHeroForTeam(DOTA_TEAM_CUSTOM_3)
        selectRandomHeroForTeam(DOTA_TEAM_CUSTOM_4)
        selectRandomHeroForTeam(DOTA_TEAM_CUSTOM_5)
        selectRandomHeroForTeam(DOTA_TEAM_CUSTOM_6)
        selectRandomHeroForTeam(DOTA_TEAM_CUSTOM_7)
        selectRandomHeroForTeam(DOTA_TEAM_CUSTOM_8)
    end

    if state == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        GameRules:GetGameModeEntity():SetThink("OnThink", self, "GlobalThink", 1)
    end
end

function selectRandomHeroForTeam(teamNum)
    local playerID = PlayerResource:GetNthPlayerIDOnTeam(teamNum, 1)
    if playerID ~= nil then
        print('player', playerID)
        if not PlayerResource:HasSelectedHero(playerID) then
            local hPlayer = PlayerResource:GetPlayer(playerID)
            if hPlayer ~= nil then
                hPlayer:MakeRandomHeroSelection()
            end
        end
    end
end