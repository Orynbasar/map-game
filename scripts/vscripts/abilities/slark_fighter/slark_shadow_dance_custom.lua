slark_shadow_dance_custom = class({})
LinkLuaModifier("modifier_slark_shadow_dance_custom_lua", "modifiers/modifier_slark_shadow_dance_custom_lua", LUA_MODIFIER_MOTION_NONE)

function slark_shadow_dance_custom:OnSpellStart()
    local caster = self:GetCaster()
    caster:AddNewModifier(caster, self, "modifier_slark_shadow_dance_custom_lua", { duration = self:GetSpecialValueFor("duration") })
end