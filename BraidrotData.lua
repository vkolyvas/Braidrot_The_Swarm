--[[
    BraidrotData ModuleScript
    Contains all Braidrot definitions, classes, rarity multipliers, and base stats
    Place in ReplicatedStorage > BraidrotData
]]

local BraidrotData = {}

-- Rarity Multipliers
BraidrotData.RarityMultipliers = {
    Basic = {
        CoinMultiplier = 1.0,
        SpeedMultiplier = 1.0,
        AbilityLevel = 0
    },
    Rare = {
        CoinMultiplier = 2.5,
        SpeedMultiplier = 1.5,
        AbilityLevel = 1
    },
    Epic = {
        CoinMultiplier = 5.0,
        SpeedMultiplier = 2.0,
        AbilityLevel = 2
    },
    Celestial = {
        CoinMultiplier = 10.0,
        SpeedMultiplier = 3.0,
        AbilityLevel = 3
    },
    Secret = {
        CoinMultiplier = 15.0,
        SpeedMultiplier = 2.5,
        AbilityLevel = 3
    },
    Infinite = {
        CoinMultiplier = 25.0,
        SpeedMultiplier = 5.0,
        AbilityLevel = 4
    }
}

-- All Braidrots with their properties
BraidrotData.Braidrots = {
    -- BASIC CLASS (Green)
    {
        Name = "Rap-Rap-Rap",
        Class = "Basic",
        Rarity = "Basic",
        BaseCoinsPerSecond = 10,
        BaseSpeed = 1,
        SpecialAbility = nil,
        Description = "A basic Braidrot that taps rhythmically."
    },
    {
        Name = "Sagur",
        Class = "Basic",
        Rarity = "Basic",
        BaseCoinsPerSecond = 12,
        BaseSpeed = 1.1,
        SpecialAbility = nil,
        Description = "A sleepy Braidrot that drools coins."
    },
    {
        Name = "Monkey Banana",
        Class = "Basic",
        Rarity = "Basic",
        BaseCoinsPerSecond = 15,
        BaseSpeed = 1.2,
        SpecialAbility = nil,
        Description = "Loves bananas and throws them for coins."
    },
    {
        Name = "Shark Shoes",
        Class = "Basic",
        Rarity = "Basic",
        BaseCoinsPerSecond = 14,
        BaseSpeed = 1.3,
        SpecialAbility = nil,
        Description = "Swims through coins like a shark."
    },
    {
        Name = "Frame Mouth",
        Class = "Basic",
        Rarity = "Basic",
        BaseCoinsPerSecond = 13,
        BaseSpeed = 1.0,
        SpecialAbility = nil,
        Description = "Has a picture frame for a mouth."
    },
    {
        Name = "Light Eyes",
        Class = "Basic",
        Rarity = "Basic",
        BaseCoinsPerSecond = 11,
        BaseSpeed = 1.15,
        SpecialAbility = nil,
        Description = "Eyes that shine like lightbulbs."
    },
    {
        Name = "Moon Teeth",
        Class = "Basic",
        Rarity = "Basic",
        BaseCoinsPerSecond = 16,
        BaseSpeed = 1.0,
        SpecialAbility = nil,
        Description = "Teeth that glow in the dark."
    },
    {
        Name = "Table Eyes",
        Class = "Basic",
        Rarity = "Basic",
        BaseCoinsPerSecond = 12,
        BaseSpeed = 1.1,
        SpecialAbility = nil,
        Description = "Eyes on a tiny table."
    },

    -- RARE CLASS (Blue)
    {
        Name = "Flying Fish",
        Class = "Rare",
        Rarity = "Rare",
        BaseCoinsPerSecond = 35,
        BaseSpeed = 1.8,
        SpecialAbility = "DoubleJump",
        Description = "Can fly short distances over hazards."
    },
    {
        Name = "Burger Legs",
        Class = "Rare",
        Rarity = "Rare",
        BaseCoinsPerSecond = 40,
        BaseSpeed = 1.5,
        SpecialAbility = "SpeedBoost",
        Description = "Runs fast on burger-shaped legs."
    },
    {
        Name = "Potato Tractor",
        Class = "Rare",
        Rarity = "Rare",
        BaseCoinsPerSecond = 50,
        BaseSpeed = 1.2,
        SpecialAbility = "AutoCollect",
        Description = "Harvests coins automatically."
    },
    {
        Name = "Orca Shoes",
        Class = "Rare",
        Rarity = "Rare",
        BaseCoinsPerSecond = 45,
        BaseSpeed = 2.0,
        SpecialAbility = "Swim",
        Description = "Swim through acid and water safely."
    },

    -- EPIC CLASS (Purple)
    {
        Name = "Jerry",
        Class = "Epic",
        Rarity = "Epic",
        BaseCoinsPerSecond = 100,
        BaseSpeed = 2.5,
        SpecialAbility = "PhaseThrough",
        Description = "Can phase through certain hazards."
    },
    {
        Name = "Gun with Cucumber",
        Class = "Epic",
        Rarity = "Epic",
        BaseCoinsPerSecond = 120,
        BaseSpeed = 2.2,
        SpecialAbility = "Shield",
        Description = "Shoots cucumber shields for protection."
    },
    {
        Name = "Bear with Macaroni",
        Class = "Epic",
        Rarity = "Epic",
        BaseCoinsPerSecond = 150,
        BaseSpeed = 2.0,
        SpecialAbility = "Grow",
        Description = "Can grow larger to avoid small hazards."
    },
    {
        Name = "Shoe with Head",
        Class = "Epic",
        Rarity = "Epic",
        BaseCoinsPerSecond = 110,
        BaseSpeed = 3.0,
        SpecialAbility = "Teleport",
        Description = "Can teleport to safe platforms."
    },

    -- CELESTIAL CLASS (Star)
    {
        Name = "Family with Brairos",
        Class = "Celestial",
        Rarity = "Celestial",
        BaseCoinsPerSecond = 300,
        BaseSpeed = 4.0,
        SpecialAbility = "Respawn",
        Description = "The legendary family that found Brairos."
    },

    -- SECRET CLASS (Hidden)
    {
        Name = "Shadow Braidrot",
        Class = "Secret",
        Rarity = "Secret",
        BaseCoinsPerSecond = 500,
        BaseSpeed = 3.5,
        SpecialAbility = "Invisibility",
        Description = "A mysterious hidden Braidrot."
    },
    {
        Name = "Golden Glitch",
        Class = "Secret",
        Rarity = "Secret",
        BaseCoinsPerSecond = 750,
        BaseSpeed = 5.0,
        SpecialAbility = "Glitch",
        Description = "Exists outside normal game rules."
    },

    -- INFINITE CLASS (Fire - Ultimate)
    {
        Name = "Dragon with Cinnamon",
        Class = "Infinite",
        Rarity = "Infinite",
        BaseCoinsPerSecond = 2000,
        BaseSpeed = 6.0,
        SpecialAbility = "Immunity",
        Description = "The ultimate Braidrot. Immune to all hazards.",
        IsInfinite = true
    }
}

-- Helper function to create a new Braidrot instance
function BraidrotData.CreateBraidrot(braidrotName)
    for _, braidrotTemplate in ipairs(BraidrotData.Braidrots) do
        if braidrotTemplate.Name == braidrotName then
            local multipliers = BraidrotData.RarityMultipliers[braidrotTemplate.Rarity]
            return {
                Name = braidrotTemplate.Name,
                Class = braidrotTemplate.Class,
                Rarity = braidrotTemplate.Rarity,
                Level = 1,
                CoinsPerSecond = braidrotTemplate.BaseCoinsPerSecond * multipliers.CoinMultiplier,
                Speed = braidrotTemplate.BaseSpeed * multipliers.SpeedMultiplier,
                SpecialAbility = braidrotTemplate.SpecialAbility,
                Description = braidrotTemplate.Description,
                IsInfinite = braidrotTemplate.IsInfinite or false,
                Experience = 0
            }
        end
    end
    return nil
end

-- Get Braidrots by rarity
function BraidrotData.GetBraidrotsByRarity(rarity)
    local result = {}
    for _, braidrot in ipairs(BraidrotData.Braidrots) do
        if braidrot.Rarity == rarity then
            table.insert(result, braidrot)
        end
    end
    return result
end

-- Get all rarity types
function BraidrotData.GetRarities()
    return {"Basic", "Rare", "Epic", "Celestial", "Secret", "Infinite"}
end

return BraidrotData
