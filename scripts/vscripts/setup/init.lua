if CustomGameSetup == nil then
    CustomGameSetup = class({})
end

function CustomGameSetup:init()
    GameRules:GetGameModeEntity():SetCustomGameForceHero("npc_dota_hero_wisp")
    CustomGameSetup:setupTeams()
    CustomGameSetup:setupGame()
end

function CustomGameSetup:setupGame()
    --Когда игроки заняли тимы после загрузочного экрана
    GameRules:EnableCustomGameSetupAutoLaunch(true)
    GameRules:SetCustomGameSetupAutoLaunchDelay(0)

    --Что бы быстрее пикались герои
    GameRules:SetHeroSelectionTime(0)
    GameRules:SetHeroSelectPenaltyTime(0)
    GameRules:SetStrategyTime(0)
    GameRules:SetShowcaseTime(0)
    GameRules:SetPreGameTime(0)

    GameRules:SetPostGameTime(5)
end

function CustomGameSetup:setupTeams()
    GameRules:SetCustomGameTeamMaxPlayers(TEAM_GOODGUYS, 0)
    GameRules:SetCustomGameTeamMaxPlayers(TEAM_BADGUYS, 0)
    GameRules:SetCustomGameTeamMaxPlayers(TEAM_CUSTOM_1, 1)
    GameRules:SetCustomGameTeamMaxPlayers(TEAM_CUSTOM_2, 1)
    GameRules:SetCustomGameTeamMaxPlayers(TEAM_CUSTOM_3, 1)
    GameRules:SetCustomGameTeamMaxPlayers(TEAM_CUSTOM_4, 1)
    GameRules:SetCustomGameTeamMaxPlayers(TEAM_CUSTOM_5, 1)
    GameRules:SetCustomGameTeamMaxPlayers(TEAM_CUSTOM_6, 1)
    GameRules:SetCustomGameTeamMaxPlayers(TEAM_CUSTOM_7, 1)
    GameRules:SetCustomGameTeamMaxPlayers(TEAM_CUSTOM_8, 1)
end
