slark_attack_speed_steal = class({})
LinkLuaModifier( "modifier_slark_attack_speed_steal_lua", "modifiers/modifier_slark_attack_speed_steal_lua", LUA_MODIFIER_MOTION_NONE )

function slark_attack_speed_steal:GetIntrinsicModifierName()
    return "modifier_slark_attack_speed_steal_lua"
end
