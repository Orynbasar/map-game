if HeroSelection == nil then
    HeroSelection = class({})
end

HeroSelection.playerPicks = {}

function HeroSelection.init()
    HeroSelection.heroSelectListener = CustomGameEventManager:RegisterListener("hero_selected", HeroSelection.HeroSelected)

    HeroSelection.TimeLeft = Game.heroSelectTime

    for order, playerID in ipairs(Game.playersPool) do
        HeroSelection.playerPicks[playerID] = ''
    end

    Timers:CreateTimer(1, function()
        CustomGameEventManager:Send_ServerToAllClients("hero_selection_time_update", { time = HeroSelection.TimeLeft })
        HeroSelection.TimeLeft = HeroSelection.TimeLeft - 1

        if HeroSelection.TimeLeft >= 0 then
            return 1
        else
            HeroSelection:EndHeroSelection()
            return nil
        end
    end)
end

function HeroSelection:HeroSelected(event)
    HeroSelection:AssignHero(event.PlayerID, event.HeroName)
    HeroSelection.playerPicks[event.PlayerID] = event.HeroName
    CustomGameEventManager:Send_ServerToAllClients("player_selected_hero", { playerID = event.PlayerID, heroName = event.HeroName })
end

function HeroSelection:EndHeroSelection()
    for playerID, hero in pairs(HeroSelection.playerPicks) do
        if hero == '' then
            HeroSelection:AssignHero(playerID, "npc_dota_hero_naga_siren")
        end
    end

    CustomGameEventManager:Send_ServerToAllClients("hero_selection_done", {})
end

function HeroSelection:AssignHero(playerID, hero)
    PrecacheUnitByNameAsync(hero, function()
        PlayerResource:ReplaceHeroWith(playerID, hero, 0, 0)
    end, playerID)
end
