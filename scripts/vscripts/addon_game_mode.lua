-- Generated from template

if CAddonTemplateGameMode == nil then
    CAddonTemplateGameMode = class({})
end

require('util/class')
require('util/timers')
require('util/log')
require('setup/init')
require('player/teams')
require('player/spot')

require('waves/wave_spawn')
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
    Log:SetLogLevel(DEBUG)
    Log:trace('Activate')
    GameRules.AddonTemplate = CAddonTemplateGameMode()
    GameRules.AddonTemplate:InitGameMode()
    Log:trace('Activate end')
end

function CAddonTemplateGameMode:InitGameMode()
    Log:trace('InitGameMode')
    CustomGameSetup:init()
    CustomListeners:init()
    Log:trace('InitGameMode end')
end
