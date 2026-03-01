--[[
    UpgradeSystem ModuleScript
    Handles Braidrot upgrades, fusion, and evolution
    Place in ReplicatedStorage > UpgradeSystem
]]

local UpgradeSystem = {}

-- Upgrade cost formula: BaseCost * (GrowthRate ^ CurrentLevel)
UpgradeSystem.UpgradeFormula = {
    BaseCost = 100,
    GrowthRate = 1.5,
    MaxLevel = 100
}

-- Evolution requirements
UpgradeSystem.EvolutionRequirements = {
    {
        Level = 10,
        Name = "Evolved Form",
        CoinMultiplier = 2.0,
        SpeedMultiplier = 1.5,
        VisualEffect = "GlowAura"
    },
    {
        Level = 25,
        Name = "Advanced Form",
        CoinMultiplier = 3.0,
        SpeedMultiplier = 2.0,
        VisualEffect = "Wings"
    },
    {
        Level = 50,
        Name = "Ultimate Form",
        CoinMultiplier = 5.0,
        SpeedMultiplier = 3.0,
        VisualEffect = "Halo"
    }
}

-- Fusion recipes
UpgradeSystem.FusionRecipes = {
    { -- Combine 2 same Braidrots
        Inputs = 2,
        Output = "Enhanced",
        Multiplier = 1.5,
        Cost = 500
    },
    { -- Combine 3 same Braidrots
        Inputs = 3,
        Output = "Superior",
        Multiplier = 2.0,
        Cost = 2000
    },
    { -- Combine 5 same Braidrots
        Inputs = 5,
        Output = "Legendary",
        Multiplier = 3.0,
        Cost = 10000
    }
}

-- Calculate upgrade cost
function UpgradeSystem.GetUpgradeCost(braidrot)
    local level = braidrot.Level or 1
    return math.floor(
        UpgradeSystem.UpgradeFormula.BaseCost *
        math.pow(UpgradeSystem.UpgradeFormula.GrowthRate, level - 1)
    )
end

-- Upgrade a Braidrot
function UpgradeSystem.UpgradeBraidrot(braidrot, coins)
    local cost = UpgradeSystem.GetUpgradeCost(braidrot)

    if coins >= cost and braidrot.Level < UpgradeSystem.UpgradeFormula.MaxLevel then
        braidrot.Coins = coins - cost
        braidrot.Level = braidrot.Level + 1

        -- Apply level bonuses
        braidrot.CoinsPerSecond = braidrot.CoinsPerSecond * 1.1
        braidrot.Speed = braidrot.Speed * 1.05

        -- Check for evolution
        braidrot.IsEvolved = UpgradeSystem.CheckEvolution(braidrot.Level)

        return true, braidrot.Level
    end

    return false, 0
end

-- Check if Braidrot can evolve
function UpgradeSystem.CheckEvolution(level)
    for _, evolution in ipairs(UpgradeSystem.EvolutionRequirements) do
        if level >= evolution.Level then
            return evolution.Name
        end
    end
    return nil
end

-- Get evolution details
function UpgradeSystem.GetEvolution(level)
    for _, evolution in ipairs(UpgradeSystem.EvolutionRequirements) do
        if level >= evolution.Level then
            return evolution
        end
    end
    return nil
end

-- Fuse Braidrots
function UpgradeSystem.FuseBraidrots(braidrots, coins)
    if #braidrots < 2 then
        return nil, "Need at least 2 Braidrots"
    end

    -- Check all are same type
    local firstName = braidrots[1].Name
    for i = 2, #braidrots do
        if braidrots[i].Name ~= firstName then
            return nil, "All Braidrots must be the same"
        end
    end

    -- Find matching recipe
    local recipe = nil
    for _, r in ipairs(UpgradeSystem.FusionRecipes) do
        if r.Inputs == #braidrots then
            recipe = r
            break
        end
    end

    if not recipe then
        return nil, "Invalid fusion recipe"
    end

    if coins < recipe.Cost then
        return nil, "Not enough coins"
    end

    -- Create fused Braidrot
    local fused = braidrots[1]
    fused.CoinsPerSecond = fused.CoinsPerSecond * recipe.Multiplier
    fused.Speed = fused.Speed * recipe.Multiplier
    fused.IsFused = true
    fused.FusionLevel = recipe.Output

    return fused, "Success"
end

-- Get upgrade info for UI
function UpgradeSystem.GetUpgradeInfo(braidrot)
    local cost = UpgradeSystem.GetUpgradeCost(braidrot)
    local nextEvolution = UpgradeSystem.CheckEvolution(braidrot.Level + 1)
    local currentEvolution = UpgradeSystem.CheckEvolution(braidrot.Level)

    return {
        CurrentLevel = braidrot.Level,
        MaxLevel = UpgradeSystem.UpgradeFormula.MaxLevel,
        UpgradeCost = cost,
        NextEvolution = nextEvolution,
        CurrentEvolution = currentEvolution,
        ProgressToEvolution = braidrot.Level / (UpgradeSystem.EvolutionRequirements[#UpgradeSystem.EvolutionRequirements].Level or 50)
    }
end

-- Calculate stats after upgrade (preview)
function UpgradeSystem.PreviewUpgrade(braidrot)
    local preview = {
        CoinsPerSecond = braidrot.CoinsPerSecond * 1.1,
        Speed = braidrot.Speed * 1.05,
        Level = braidrot.Level + 1
    }
    return preview
end

return UpgradeSystem
