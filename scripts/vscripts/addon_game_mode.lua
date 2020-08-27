-- Generated from template

if CAddonTemplateGameMode == nil then
    CAddonTemplateGameMode = class({})
end

require('waves/wave_spawn')
require('setup/init')
require('setup/listeners')

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

    CustomGameSetup:init()
    CustomListeners:init(CAddonTemplateGameMode)
end
