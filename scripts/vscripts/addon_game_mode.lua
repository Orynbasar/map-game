-- Generated from template

if CAddonTemplateGameMode == nil then
	CAddonTemplateGameMode = class({})
end

require('waves/wave_spawn')

function Precache( context )
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
	print( "Template addon is loaded." )

	GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_1, 1)
	GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_2, 1)
	GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_3, 1)
	GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_4, 1)
	GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_5, 1)
	GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_6, 1)
	GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_7, 1)
	GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_8, 1)




	--skip all the starting game mode stages e.g picking screen, showcase, etc
	GameRules:EnableCustomGameSetupAutoLaunch(true)
	GameRules:SetCustomGameSetupAutoLaunchDelay(10)
	GameRules:SetHeroSelectionTime(0)
	GameRules:SetStrategyTime(0)
	GameRules:SetPreGameTime(0)
	GameRules:SetShowcaseTime(0)
	GameRules:SetPostGameTime(5)

	--disable some setting which are annoying then testing
	local GameMode = GameRules:GetGameModeEntity()
	GameMode:SetAnnouncerDisabled(true)
	GameMode:SetKillingSpreeAnnouncerDisabled(true)
	GameMode:SetDaynightCycleDisabled(true)
	GameMode:DisableHudFlip(true)
	GameMode:SetDeathOverlayDisabled(true)
	GameMode:SetWeatherEffectsDisabled(true)

	--disable music events
	GameRules:SetCustomGameAllowHeroPickMusic(false)
	GameRules:SetCustomGameAllowMusicAtGameStart(false)
	GameRules:SetCustomGameAllowBattleMusic(false)


	GameRules:GetGameModeEntity():SetThink( "OnThink", self, "GlobalThink", 1 )
end

-- Evaluate the state of the game
function CAddonTemplateGameMode:OnThink()

	print(GameRules:State_Get())

	if GameRules:State_Get() == 3 then
		--loop through each player on every team and random a hero if they haven't picked
		for teamNum = 2, 3 do
			for i=1, 5 do
				local playerID = PlayerResource:GetNthPlayerIDOnTeam(teamNum, i)
				print(playerID)
				if playerID ~= nil then
					if not PlayerResource:HasSelectedHero(playerID) then
						local hPlayer = PlayerResource:GetPlayer(playerID)
						if hPlayer ~= nil then
							hPlayer:MakeRandomHeroSelection()
						end
					end
				end
			end
		end
	end


	if GameRules:State_Get() > 7 then
		startWave()
		print( "Template addon script is running." )
	end

	if GameRules:State_Get() > 8 then
		return nil
	end
	return 1
end