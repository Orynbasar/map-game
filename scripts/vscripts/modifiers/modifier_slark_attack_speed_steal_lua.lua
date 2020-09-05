modifier_slark_attack_speed_steal_lua = class({})

function modifier_slark_attack_speed_steal_lua:IsHidden()
    return ( self:GetStackCount() == 0 )
end

function modifier_slark_attack_speed_steal_lua:IsDebuff()
    return false
end

function modifier_slark_attack_speed_steal_lua:IsPurgable()
    return false
end

function modifier_slark_attack_speed_steal_lua:RemoveOnDeath()
    return true
end

function modifier_slark_attack_speed_steal_lua:OnCreated(kv)
    if IsServer() then
        self:SetStackCount(0)
    end
    self.stackMultiplier = self:GetAbility():GetSpecialValueFor("attack_speed")
    self.maxStacks = self:GetAbility():GetSpecialValueFor("max_stacks")
end

function modifier_slark_attack_speed_steal_lua:OnRefresh(kv)
    self.stackMultiplier = self:GetAbility():GetSpecialValueFor("attack_speed")
    self.maxStacks = self:GetAbility():GetSpecialValueFor("max_stacks")
end

function modifier_slark_attack_speed_steal_lua:DeclareFunctions()
    local functions = {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_EVENT_ON_ATTACK
    }

    return functions
end

function modifier_slark_attack_speed_steal_lua:OnAttack(params)
    if IsServer() then
        if params.attacker == self:GetParent() then
            self:AddStack()
        end
    end
end

function modifier_slark_attack_speed_steal_lua:GetModifierAttackSpeedBonus_Constant(params)
    if self:GetParent():PassivesDisabled() then
        return 0
    end
    return self:GetStackCount() * self.stackMultiplier
end

function modifier_slark_attack_speed_steal_lua:AddStack()
    if not self:GetParent():PassivesDisabled() then
        if self:GetStackCount() < self.maxStacks then
            self:IncrementStackCount()
        end
    end
end