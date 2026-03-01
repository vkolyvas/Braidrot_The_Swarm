--[[
    EggSystem ModuleScript
    Handles egg hatching with probability-based Braidrot selection
    Place in ReplicatedStorage > EggSystem
]]

local EggSystem = {}
local BraidrotData = require(script.Parent.BraidrotData)

-- Egg definitions with Braidrots and probabilities
EggSystem.Eggs = {
    BasicEgg = {
        Name = "Basic Egg",
        Price = 100,
        Currency = "Coins",
        Braidrots = {
            {Name = "Rap-Rap-Rap", Weight = 35},
            {Name = "Sagur", Weight = 25},
            {Name = "Monkey Banana", Weight = 20},
            {Name = "Shark Shoes", Weight = 10},
            {Name = "Frame Mouth", Weight = 5},
            {Name = "Light Eyes", Weight = 3},
            {Name = "Moon Teeth", Weight = 1.5},
            {Name = "Table Eyes", Weight = 0.5}
        },
        HatchingTime = 0,
        SecretChance = 0.001,
        Color = Color3.fromRGB(144, 238, 144)
    },
    RareEgg = {
        Name = "Rare Egg",
        Price = 500,
        Currency = "Coins",
        Braidrots = {
            {Name = "Flying Fish", Weight = 35},
            {Name = "Burger Legs", Weight = 30},
            {Name = "Potato Tractor", Weight = 20},
            {Name = "Orca Shoes", Weight = 10},
            {Name = "Rap-Rap-Rap", Weight = 3},
            {Name = "Sagur", Weight = 2}
        },
        HatchingTime = 0,
        SecretChance = 0.005,
        Color = Color3.fromRGB(100, 149, 237)
    },
    EpicEgg = {
        Name = "Epic Egg",
        Price = 100,
        Currency = "Diamonds",
        Braidrots = {
            {Name = "Jerry", Weight = 30},
            {Name = "Gun with Cucumber", Weight = 25},
            {Name = "Bear with Macaroni", Weight = 25},
            {Name = "Shoe with Head", Weight = 15},
            {Name = "Flying Fish", Weight = 3},
            {Name = "Burger Legs", Weight = 2}
        },
        HatchingTime = 5,
        SecretChance = 0.01,
        Color = Color3.fromRGB(147, 112, 219)
    },
    CelestialEgg = {
        Name = "Celestial Egg",
        Price = 500,
        Currency = "Diamonds",
        Braidrots = {
            {Name = "Family with Brairos", Weight = 70},
            {Name = "Jerry", Weight = 15},
            {Name = "Gun with Cucumber", Weight = 10},
            {Name = "Bear with Macaroni", Weight = 5}
        },
        HatchingTime = 10,
        SecretChance = 0.05,
        Color = Color3.fromRGB(255, 215, 0)
    },
    InfiniteEgg = {
        Name = "Infinite Egg",
        Price = 1000,
        Currency = "Robux",
        Braidrots = {
            {Name = "Dragon with Cinnamon", Weight = 100}
        },
        HatchingTime = 0,
        SecretChance = 0,
        Color = Color3.fromRGB(255, 69, 0)
    }
}

-- Get egg by name
function EggSystem.GetEgg(eggName)
    return EggSystem.Eggs[eggName]
end

-- Hatch an egg - returns Braidrot name
function EggSystem.HatchEgg(eggName, luckMultiplier)
    local egg = EggSystem.Eggs[eggName]
    if not egg then
        return nil
    end

    -- Check for Secret Braidrot
    local secretRoll = math.random()
    if egg.SecretChance > 0 and secretRoll <= (egg.SecretChance * luckMultiplier) then
        local secretBraidrots = BraidrotData.GetBraidrotsByRarity("Secret")
        if #secretBraidrots > 0 then
            return secretBraidrots[math.random(#secretBraidrots)].Name
        end
    end

    -- Calculate total weight
    local totalWeight = 0
    for _, b in ipairs(egg.Braidrots) do
        totalWeight = totalWeight + b.Weight
    end

    -- Random selection based on weight
    local roll = math.random() * totalWeight
    local currentWeight = 0

    for _, b in ipairs(egg.Braidrots) do
        currentWeight = currentWeight + b.Weight
        if roll <= currentWeight then
            return b.Name
        end
    end

    -- Fallback
    return egg.Braidrots[1].Name
end

-- Get all available eggs
function EggSystem.GetAllEggs()
    return EggSystem.Eggs
end

-- Get hatching animation data
function EggSystem.GetHatchAnimation(eggName)
    local egg = EggSystem.Eggs[eggName]
    if not egg then
        return nil
    end

    return {
        Duration = egg.HatchingTime,
        Color = egg.Color,
        ParticleEffects = {
            "Sparkles",
            "PointLight",
            "Smoke"
        }
    }
end

-- Calculate duplicate Braidrot value
function EggSystem.GetDuplicateValue(braidrotName)
    local braidrot = BraidrotData.CreateBraidrot(braidrotName)
    local baseValue = braidrot.CoinsPerSecond * 10

    -- Rarity bonus
    local rarityBonus = {
        Basic = 1,
        Rare = 3,
        Epic = 10,
        Celestial = 50,
        Secret = 100,
        Infinite = 500
    }

    return math.floor(baseValue * (rarityBonus[braidrot.Rarity] or 1))
end

return EggSystem
