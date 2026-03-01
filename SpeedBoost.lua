--[[
    SpeedBoost ModuleScript
    Handles player collection speed upgrades
    Place in ReplicatedStorage > SpeedBoost
]]

local SpeedBoost = {}

-- Speed levels and costs
SpeedBoost.SpeedLevels = {
    {
        Level = 1,
        Multiplier = 1.0,
        Cost = 500,
        Name = "Basic Speed"
    },
    {
        Level = 2,
        Multiplier = 1.5,
        Cost = 5000,
        Name = "Fast Hands"
    },
    {
        Level = 3,
        Multiplier = 2.0,
        Cost = 25000,
        Name = "Quick Fingers"
    },
    {
        Level = 4,
        Multiplier = 3.0,
        Cost = 150000,
        Name = "Lightning Speed"
    },
    {
        Level = 5,
        Multiplier = 5.0,
        Cost = 500000,
        Name = "Sonic Collection"
    },
    {
        Level = 6,
        Multiplier = 7.0,
        Cost = 2500000,
        Name = "Light Speed"
    },
    {
        Level = 7,
        Multiplier = 10.0,
        Cost = 10000000,
        Name = "Instant Collection"
    }
}

-- Create player speed data
function SpeedBoost.CreatePlayerSpeedData()
    return {
        CurrentLevel = 1,
        CurrentMultiplier = 1.0,
        TotalUpgrades = 0,
        TotalSpent = 0
    }
end

-- Get current speed level info
function SpeedBoost.GetSpeedLevel(level)
    return SpeedBoost.SpeedLevels[level]
end

-- Get next upgrade cost
function SpeedBoost.GetNextUpgradeCost(currentLevel)
    if currentLevel >= #SpeedBoost.SpeedLevels then
        return nil, "Max level reached"
    end
    return SpeedBoost.SpeedLevels[currentLevel + 1].Cost
end

-- Upgrade speed
function SpeedBoost.UpgradeSpeed(playerData, coins)
    local currentLevel = playerData.CurrentLevel

    if currentLevel >= #SpeedBoost.SpeedLevels then
        return false, "Already at max level"
    end

    local nextLevelData = SpeedBoost.SpeedLevels[currentLevel + 1]

    if coins >= nextLevelData.Cost then
        playerData.Coins = playerData.Coins - nextLevelData.Cost
        playerData.CurrentLevel = currentLevel + 1
        playerData.CurrentMultiplier = nextLevelData.Multiplier
        playerData.TotalUpgrades = playerData.TotalUpgrades + 1
        playerData.TotalSpent = playerData.TotalSpent + nextLevelData.Cost

        return true, nextLevelData
    end

    return false, "Not enough coins"
end

-- Calculate actual collection speed
function SpeedBoost.CalculateCollectionSpeed(baseSpeed, speedData, braidrotSpeed)
    return baseSpeed * speedData.CurrentMultiplier * braidrotSpeed
end

-- Get all speed levels for UI
function SpeedBoost.GetAllSpeedLevels()
    return SpeedBoost.SpeedLevels
end

-- Check if can afford upgrade
function SpeedBoost.CanAffordUpgrade(playerData, coins)
    local cost = SpeedBoost.GetNextUpgradeCost(playerData.CurrentLevel)
    if type(cost) == "string" then
        return false
    end
    return coins >= cost
end

-- Calculate cost to max speed
function SpeedBoost.GetCostToMax(currentLevel)
    local total = 0
    for i = currentLevel + 1, #SpeedBoost.SpeedLevels do
        total = total + SpeedBoost.SpeedLevels[i].Cost
    end
    return total
end

return SpeedBoost
