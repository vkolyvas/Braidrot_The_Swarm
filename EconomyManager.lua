--[[
    EconomyManager ModuleScript
    Handles Coins, Diamonds, Robux and shop transactions
    Place in ReplicatedStorage > EconomyManager
]]

local EconomyManager = {}

-- Currency Settings
EconomyManager.MaxCoins = 999999999999
EconomyManager.MaxDiamonds = 999999999
EconomyManager.MaxRobux = 999999999

-- Starting values for new players
EconomyManager.StartingValues = {
    Coins = 100,
    Diamonds = 0,
    Robux = 0,
    RebirthPoints = 0
}

-- Currency multipliers
EconomyManager.Multipliers = {
    CoinMultiplier = 1.0,
    DiamondMultiplier = 1.0,
    SpeedMultiplier = 1.0,
    LuckMultiplier = 1.0
}

-- Create player economy data
function EconomyManager.CreatePlayerData()
    return {
        Coins = EconomyManager.StartingValues.Coins,
        Diamonds = EconomyManager.StartingValues.Diamonds,
        Robux = EconomyManager.StartingValues.Robux,
        RebirthPoints = EconomyManager.StartingValues.RebirthPoints,
        TotalCoinsEarned = 0,
        TotalDiamondsEarned = 0,
        LifetimeSpending = 0
    }
end

-- Add coins with multiplier
function EconomyManager.AddCoins(playerData, amount)
    local actualAmount = math.floor(amount * EconomyManager.Multipliers.CoinMultiplier)
    playerData.Coins = math.min(playerData.Coins + actualAmount, EconomyManager.MaxCoins)
    playerData.TotalCoinsEarned = playerData.TotalCoinsEarned + actualAmount
    return actualAmount
end

-- Spend coins (returns true if successful)
function EconomyManager.SpendCoins(playerData, amount)
    if playerData.Coins >= amount then
        playerData.Coins = playerData.Coins - amount
        playerData.LifetimeSpending = playerData.LifetimeSpending + amount
        return true
    end
    return false
end

-- Add diamonds
function EconomyManager.AddDiamonds(playerData, amount)
    local actualAmount = math.floor(amount * EconomyManager.Multipliers.DiamondMultiplier)
    playerData.Diamonds = math.min(playerData.Diamonds + actualAmount, EconomyManager.MaxDiamonds)
    playerData.TotalDiamondsEarned = playerData.TotalDiamondsEarned + actualAmount
    return actualAmount
end

-- Spend diamonds
function EconomyManager.SpendDiamonds(playerData, amount)
    if playerData.Diamonds >= amount then
        playerData.Diamonds = playerData.Diamonds - amount
        return true
    end
    return false
end

-- Add rebirth points
function EconomyManager.AddRebirthPoints(playerData, amount)
    playerData.RebirthPoints = playerData.RebirthPoints + amount
end

-- Apply rebirth bonus multiplier
function EconomyManager.ApplyRebirthBonus(playerData)
    local bonus = 1 + (playerData.RebirthPoints * 0.05)
    EconomyManager.Multipliers.CoinMultiplier = bonus
    EconomyManager.Multipliers.SpeedMultiplier = 1 + (playerData.RebirthPoints * 0.02)
    return bonus
end

-- Calculate total coins per second from all Braidrots
function EconomyManager.CalculateCoinsPerSecond(braidrots)
    local total = 0
    for _, braidrot in ipairs(braidrots) do
        total = total + (braidrot.CoinsPerSecond * braidrot.Level)
    end
    return total * EconomyManager.Multipliers.CoinMultiplier
end

-- Format large numbers
function EconomyManager.FormatNumber(num)
    if num >= 1e12 then
        return string.format("%.2fT", num / 1e12)
    elseif num >= 1e9 then
        return string.format("%.2fB", num / 1e9)
    elseif num >= 1e6 then
        return string.format("%.2fM", num / 1e6)
    elseif num >= 1e3 then
        return string.format("%.2fK", num / 1e3)
    end
    return tostring(math.floor(num))
end

return EconomyManager
