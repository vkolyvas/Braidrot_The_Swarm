--[[
    HazardSystem ModuleScript
    Handles environmental hazards in Obby levels
    Place in ReplicatedStorage > HazardSystem
]]

local HazardSystem = {}

-- Hazard types and properties
HazardSystem.HazardTypes = {
    Slippery = {
        Name = "Slippery Platform",
        Damage = 0,
        Effect = "Slide",
        Color = Color3.fromRGB(173, 216, 230),
        Description = "Makes player slide uncontrollably"
    },
    Lava = {
        Name = "Rising Lava",
        Damage = 100,
        Effect = "DamageOverTime",
        Color = Color3.fromRGB(255, 69, 0),
        Description = "Rising lava that deals damage over time"
    },
    Acid = {
        Name = "Acid Pool",
        Damage = 1000,
        Effect = "InstantKill",
        Color = Color3.fromRGB(0, 255, 0),
        Description = "Instant death on contact"
    },
    Fire = {
        Name = "Fire Trap",
        Damage = 50,
        Effect = "TimedBurst",
        Color = Color3.fromRGB(255, 140, 0),
        Description = "Flames burst at timed intervals"
    },
    Water = {
        Name = "Sinking Water",
        Damage = 0,
        Effect = "Sink",
        Color = Color3.fromRGB(30, 144, 255),
        Description = "Player sinks and must jump to survive"
    },
    Wind = {
        Name = "Strong Wind",
        Damage = 0,
        Effect = "Knockback",
        Color = Color3.fromRGB(192, 192, 192),
        Description = "Pushes player back on platforms"
    },
    Electric = {
        Name = "Electrical Grid",
        Damage = 500,
        Effect = "InstantKill",
        Color = Color3.fromRGB(255, 255, 0),
        Description = "Contact causes instant death"
    },
    Spike = {
        Name = "Spike Trap",
        Damage = 200,
        Effect = "InstantKill",
        Color = Color3.fromRGB(128, 128, 128),
        Description = "Sharp spikes that impale players"
    },
    Void = {
        Name = "The Void",
        Damage = 1000,
        Effect = "InstantKill",
        Color = Color3.fromRGB(0, 0, 0),
        Description = "Falling into void is instant death"
    }
}

-- World hazard configurations
HazardSystem.WorldHazards = {
    IceWorld = {
        Hazards = {"Slippery", "Spike"},
        Difficulty = 1,
        Description = "Slippery ice platforms with hidden spikes"
    },
    LavaWorld = {
        Hazards = {"Lava", "Fire"},
        Difficulty = 2,
        Description = "Rising lava and fire traps"
    },
    AcidWorld = {
        Hazards = {"Acid", "Spike"},
        Difficulty = 3,
        Description = "Deadly acid pools"
    },
    FireWorld = {
        Hazards = {"Fire", "Void"},
        Difficulty = 3,
        Description = "Intense fire with void gaps"
    },
    WaterWorld = {
        Hazards = {"Water", "Electric"},
        Difficulty = 4,
        Description = "Sinking water with electric currents"
    },
    WindWorld = {
        Hazards = {"Wind", "Spike"},
        Difficulty = 4,
        Description = "Powerful wind pushing players"
    },
    ElectricWorld = {
        Hazards = {"Electric", "Void"},
        Difficulty = 5,
        Description = "Electrical grids everywhere"
    },
    DiamondUniverse = {
        Hazards = {"Lava", "Acid", "Fire", "Electric", "Void"},
        Difficulty = 10,
        Description = "Ultimate challenge combining all hazards"
    }
}

-- Create hazard instance
function HazardSystem.CreateHazard(hazardType, position, size)
    local hazardTemplate = HazardSystem.HazardTypes[hazardType]
    if not hazardTemplate then
        return nil
    end

    return {
        Type = hazardType,
        Name = hazardTemplate.Name,
        Damage = hazardTemplate.Damage,
        Effect = hazardTemplate.Effect,
        Color = hazardTemplate.Color,
        Position = position or Vector3.new(0, 0, 0),
        Size = size or Vector3.new(10, 1, 10),
        IsActive = true,
        Cooldown = 0
    }
end

-- Handle player touching hazard
function HazardSystem.OnPlayerTouchHazard(player, hazard, braidrot)
    if not hazard.IsActive then
        return
    end

    -- Check for immunity from Infinite Braidrot
    if braidrot and braidrot.SpecialAbility == "Immunity" then
        return false, "Immune"
    end

    local effect = hazard.Effect

    if effect == "InstantKill" then
        return true, "Killed"
    elseif effect == "DamageOverTime" then
        local damage = hazard.Damage
        return true, {Damage = damage, Type = "DOT"}
    elseif effect == "Slide" then
        return true, {Effect = "Slide", Duration = 2}
    elseif effect == "Knockback" then
        return true, {Effect = "Knockback", Force = 50}
    elseif effect == "Sink" then
        return true, {Effect = "Sink", SinkSpeed = 10}
    elseif effect == "TimedBurst" then
        return true, {Effect = "Timed", Interval = 3}
    end

    return false, "NoEffect"
end

-- Get world hazards
function HazardSystem.GetWorldHazards(worldName)
    return HazardSystem.WorldHazards[worldName]
end

-- Get all worlds
function HazardSystem.GetAllWorlds()
    local worlds = {}
    for name, data in pairs(HazardSystem.WorldHazards) do
        table.insert(worlds, {
            Name = name,
            Difficulty = data.Difficulty,
            Description = data.Description
        })
    end
    return worlds
end

-- Get hazard by type
function HazardSystem.GetHazardType(hazardType)
    return HazardSystem.HazardTypes[hazardType]
end

return HazardSystem
