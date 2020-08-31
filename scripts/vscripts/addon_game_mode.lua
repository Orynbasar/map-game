if NewMap == nil then
    NewMap = class({})
end

require('map/map')
require('util/class')
require('util/timers')
require('util/log')
require('setup/init')

require('player/teams')
require('player/spot')

require('game/game')
require('game/wave')
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
        --clear annoying previous console messages
        --SendToServerConsole("clear")
        Log:SetLogLevel(DEBUG)
    else
        Log:SetLogLevel(INFO)
    end
end