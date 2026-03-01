--[[
    RebirthSystem ModuleScript
    Handles player rebirth/prestige mechanics
    Place in ReplicatedStorage > RebirthSystem
]]

local RebirthSystem = {}

-- Rebirth requirements
RebirthSystem.RebirthRequirements = {
    {
        Level = 1,
        MinCoins = 10000,
        MinBraidrots = 1,
        PointsGained = 1,
        BonusMultiplier = 0.05
    },
    {
        Level = 2,
        MinCoins = 100000,
        MinBraidrots = 5,
        PointsGained = 2,
        BonusMultiplier = 0.10
    },
    {
        Level = 3,
        MinCoins = 1000000,
        MinBraidrots = 10,
        PointsGained = 3,
        BonusMultiplier = 0.15
    },
    {
        Level = 4,
        MinCoins = 10000000,
        MinBraidrots = 20,
        PointsGained = 5,
        BonusMultiplier = 0.20
    },
    {
        Level = 5,
        MinCoins = 100000000,
        MinBraidrots = 30,
        PointsGained = 10,
        BonusMultiplier = 0.25
    }
}

-- World unlock requirements (by rebirth points)
RebirthSystem.WorldUnlocks = {
    {
        World = "IceWorld",
        RequiredRebirths = 0,
        Description = "Starting world with slippery platforms"
    },
    {
        World = "LavaWorld",
        RequiredRebirths = 1,
        Description = "Rising lava hazards"
    },
    {
        World = "AcidWorld",
        RequiredRebirths = 2,
        Description = "Deadly acid pools"
    },
    {
        World = "FireWorld",
        RequiredRebirths = 3,
        Description = "Intense fire traps"
    },
    {
        World = "WaterWorld",
        RequiredRebirths = 5,
        Description = "Sinking water challenge"
    },
    {
        World = "WindWorld",
        RequiredRebirths = 7,
        Description = "Powerful wind gusts"
    },
    {
        World = "ElectricWorld",
        RequiredRebirths = 10,
        Description = "Electrical grid danger"
    },
    {
        World = "DiamondUniverse",
        RequiredRebirths = 15,
        Description = "Ultimate challenge"
    }
}

-- Create player rebirth data
function RebirthSystem.CreatePlayerRebirthData()
    return {
        RebirthCount = 0,
        TotalRebirthPoints = 0,
        CurrentRebirthLevel = 0,
        CoinMultiplier = 1.0,
        SpeedBonus = 1.0,
        LuckBonus = 1.0,
        UnlockedWorlds = {"IceWorld"}
    }
end

-- Check if player can rebirth
function RebirthSystem.CanRebirth(playerData)
    local req = RebirthSystem.RebirthRequirements[playerData.CurrentRebirthLevel + 1]
    if not req then
        return false, "Max rebirth level reached"
    end

    if playerData.Coins < req.MinCoins then
        return false, "Not enough coins"
    end

    if #playerData.Braidrots < req.MinBraidrots then
        return false, "Not enough Braidrots"
    end

    return true, "Ready"
end

-- Perform rebirth
function RebirthSystem.Rebirth(playerData)
    local canRebirth, message = RebirthSystem.CanRebirth(playerData)

    if not canRebirth then
        return false, message
    end

    local req = RebirthSystem.RebirthRequirements[playerData.CurrentRebirthLevel + 1]

    -- Reset progress
    playerData.Coins = 0
    playerData.Braidrots = {}
    playerData.SpeedLevel = 1

    -- Add rebirth points and apply bonuses
    playerData.TotalRebirthPoints = playerData.TotalRebirthPoints + req.PointsGained
    playerData.RebirthCount = playerData.RebirthCount + 1
    playerData.CurrentRebirthLevel = playerData.CurrentRebirthLevel + 1
    playerData.CoinMultiplier = 1.0 + (playerData.TotalRebirthPoints * req.BonusMultiplier)
    playerData.SpeedBonus = 1.0 + (playerData.TotalRebirthPoints * 0.02)

    -- Check for world unlocks
    RebirthSystem.CheckWorldUnlocks(playerData)

    return true, {
        PointsGained = req.PointsGained,
        NewMultiplier = playerData.CoinMultiplier,
        UnlockedWorlds = playerData.UnlockedWorlds
    }
end

-- Check and unlock worlds
function RebirthSystem.CheckWorldUnlocks(playerData)
    for _, world in ipairs(RebirthSystem.WorldUnlocks) do
        if playerData.TotalRebirthPoints >= world.RequiredRebirths then
            -- Check if already unlocked
            local alreadyUnlocked = false
            for _, unlocked in ipairs(playerData.UnlockedWorlds) do
                if unlocked == world.World then
                    alreadyUnlocked = true
                    break
                end
            end

            if not alreadyUnlocked then
                table.insert(playerData.UnlockedWorlds, world.World)
            end
        end
    end
end

-- Get next rebirth info
function RebirthSystem.GetNextRebirthInfo(playerData)
    local req = RebirthSystem.RebirthRequirements[playerData.CurrentRebirthLevel + 1]
    if not req then
        return nil
    end

    return {
        Level = req.Level,
        MinCoins = req.MinCoins,
        MinBraidrots = req.MinBraidrots,
        PointsToGain = req.PointsGained,
        BonusMultiplier = req.BonusMultiplier,
        CurrentCoins = playerData.Coins,
        CurrentBraidrots = #playerData.Braidrots
    }
end

-- Get all world unlocks
function RebirthSystem.GetAllWorldUnlocks()
    return RebirthSystem.WorldUnlocks
end

-- Get player's unlocked worlds
function RebirthSystem.GetUnlockedWorlds(playerData)
    return playerData.UnlockedWorlds
end

-- Calculate prestige bonus
function RebirthSystem.CalculatePrestigeBonus(totalPoints)
    return {
        CoinBonus = 1.0 + (totalPoints * 0.05),
        SpeedBonus = 1.0 + (totalPoints * 0.02),
        LuckBonus = 1.0 + (totalPoints * 0.01)
    }
end

return RebirthSystem
