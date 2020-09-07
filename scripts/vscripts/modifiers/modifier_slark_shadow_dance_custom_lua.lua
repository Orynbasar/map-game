modifier_slark_shadow_dance_custom_lua = class({})

function modifier_slark_shadow_dance_custom_lua:IsHidden()
    return false
end

function modifier_slark_shadow_dance_custom_lua:IsDebuff()
    return false
end

function modifier_slark_shadow_dance_custom_lua:IsPurgable()
    return false
end

function modifier_slark_shadow_dance_custom_lua:OnCreated(kv)
    if IsServer() then
        self:PlayEffects()
    end
end

function modifier_slark_shadow_dance_custom_lua:OnDestroy(kv)
    if IsServer() then
        StopSoundOn("Hero_Slark.ShadowDance", self:GetParent())
    end
end

function modifier_slark_shadow_dance_custom_lua:DeclareFunctions()
    local functions = {
        MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
    }

    return functions
end

function modifier_slark_shadow_dance_custom_lua:GetModifierInvisibilityLevel()
    return 1
end

function modifier_slark_shadow_dance_custom_lua:CheckState()
    local state = {
        [MODIFIER_STATE_INVISIBLE] = true,
        [MODIFIER_STATE_TRUESIGHT_IMMUNE] = true,
    }

    return state
end

function modifier_slark_shadow_dance_custom_lua:PlayEffects()
    local parent = self:GetParent()
    local particle_cast = "particles/units/heroes/hero_slark/slark_shadow_dance.vpcf"

    local effect_cast = ParticleManager:CreateParticleForTeam(particle_cast, PATTACH_ABSORIGIN_FOLLOW, parent, parent:GetTeamNumber())
    ParticleManager:SetParticleControlEnt(effect_cast, 1, parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
    ParticleManager:SetParticleControlEnt(effect_cast, 3, parent, PATTACH_POINT_FOLLOW, "attach_eyeR", Vector(0, 0, 0), true)
    ParticleManager:SetParticleControlEnt(effect_cast, 4, parent, PATTACH_POINT_FOLLOW, "attach_eyeL", Vector(0, 0, 0), true)

    self:AddParticle(effect_cast, false, false, -1, false, false)

    EmitSoundOn("Hero_Slark.ShadowDance", parent)
end
