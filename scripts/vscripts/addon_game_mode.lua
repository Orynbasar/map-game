if NewMap == nil then
    NewMap = class({})
end

require('map/map')
require('util/class')
require('util/util')
require('util/timers')
require('util/log')
require('setup/init')

require('player/teams')
require('player/spot')

require('game/game')
require('game/wave')
require('setup/hero_selection')
require('setup/listeners')
require('units/defender')

function Precache(context)
    --[[
        Precache things we know we'll use.  Possible file types include (but not limited to):
            PrecacheResource( "model", "*.vmdl", context )
            PrecacheResource( "soundfile", "*.vsndevts", context )
            PrecacheResource( "particle", "*.vpcf", context )
            PrecacheResource( "particle_folder", "particles/folder", context )
    ]]
    PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_slark.vsndevts", context )

end

-- Create the game mode when we activate
function Activate()
    initDebugMode()
    Log:trace('Activate')
    GameRules.AddonTemplate = NewMap()
    GameRules.AddonTemplate:InitGameMode()
    GameRules:GetGameModeEntity():SetFogOfWarDisabled(true)
    Log:trace('Activate end')
end

function NewMap:InitGameMode()
    Log:trace('InitGameMode')
    CustomGameSetup:init()
    CustomListeners:init()
    Log:trace('InitGameMode end')
end

function initDebugMode()
    if IsInToolsMode() then
        Log:SetLogLevel(INFO)
    else
        Log:SetLogLevel(INFO)
    end
end