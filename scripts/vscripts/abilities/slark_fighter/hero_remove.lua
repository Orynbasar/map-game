hero_remove = class({})
LinkLuaModifier( "modifier_hero_remove_lua", "modifiers/modifier_hero_remove_lua", LUA_MODIFIER_MOTION_NONE )

function hero_remove:GetIntrinsicModifierName()
    return "modifier_hero_remove_lua"
end
