--[[
    EconomyExtras ModuleScript
    Pet System, Gift Shop, Lucky Wheel
    Place in ReplicatedStorage > EconomyExtras
]]

local EconomyExtras = {}

------------------------------------------------------------------
-- PET SYSTEM
------------------------------------------------------------------

EconomyExtras.Pets = {
    -- Pet slots
    MaxPets = 3,

    -- Pet categories
    Categories = {
        Companion = {Name = "Companion", BuffType = "StatBoost"},
        Lucky = {Name = "Lucky", BuffType = "LuckBoost"},
        Guard = {Name = "Guard", BuffType = "Combat"},
        Rare = {Name = "Rare", BuffType = "Special"}
    },

    -- All pets
    List = {
        -- Common
        {
            Id = "pet_cat",
            Name = "Fluffy Cat",
            Category = "Companion",
            Rarity = "Common",
            Price = 500,
            Currency = "Coins",
            Buff = {Type = "CoinBonus", Value = 5},
            Description = "A cute cat that increases coin earnings"
        },
        {
            Id = "pet_dog",
            Name = "Loyal Dog",
            Category = "Companion",
            Rarity = "Common",
            Price = 500,
            Currency = "Coins",
            Buff = {Type = "CoinBonus", Value = 5},
            Description = "Faithful companion"
        },
        {
            Id = "pet_bird",
            Name = "Tiny Bird",
            Category = "Companion",
            Rarity = "Common",
            Price = 300,
            Currency = "Coins",
            Buff = {Type = "SpeedBonus", Value = 3},
            Description = "A quick little bird"
        },

        -- Uncommon
        {
            Id = "pet_rabbit",
            Name = "Lucky Rabbit",
            Category = "Lucky",
            Rarity = "Uncommon",
            Price = 1000,
            Currency = "Coins",
            Buff = {Type = "LuckBonus", Value = 10},
            Description = "Brings good fortune"
        },
        {
            Id = "pet_owl",
            Name = "Wise Owl",
            Category = "Companion",
            Rarity = "Uncommon",
            Price = 1200,
            Currency = "Coins",
            Buff = {Type = "XPBonus", Value = 15},
            Description = "Increases XP gain"
        },

        -- Rare
        {
            Id = "pet_dragon",
            Name = "Mini Dragon",
            Category = "Guard",
            Rarity = "Rare",
            Price = 100,
            Currency = "Diamonds",
            Buff = {Type = "DamageBonus", Value = 15},
            Description = "A tiny fierce dragon"
        },
        {
            Id = "pet_phoenix",
            Name = "Baby Phoenix",
            Category = "Rare",
            Rarity = "Rare",
            Price = 150,
            Currency = "Diamonds",
            Buff = {Type = "Revive", Value = 1},
            Description = "Can revive once per game"
        },

        -- Epic
        {
            Id = "pet_griffin",
            Name = "Griffin",
            Category = "Guard",
            Rarity = "Epic",
            Price = 300,
            Currency = "Diamonds",
            Buff = {Type = "AllStats", Value = 10},
            Description = "Magnificent creature"
        },
        {
            Id = "pet_unicorn",
            Name = "Unicorn",
            Category = "Lucky",
            Rarity = "Epic",
            Price = 350,
            Currency = "Diamonds",
            Buff = {Type = "LuckBonus", Value = 25},
            Description = "Magical fortune bringer"
        },

        -- Legendary
        {
            Id = "pet_leviathan",
            Name = "Baby Leviathan",
            Category = "Guard",
            Rarity = "Legendary",
            Price = 1000,
            Currency = "Robux",
            Buff = {Type = "AllStats", Value = 25},
            Description = "Ocean giant in miniature"
        },
        {
            Id = "pet_kraken",
            Name = "Kraken Spawn",
            Category = "Guard",
            Rarity = "Legendary",
            Price = 1500,
            Currency = "Robux",
            Buff = {Type = "SwarmDamage", Value = 50},
            Description = "Increases swarm damage significantly"
        }
    }
}

------------------------------------------------------------------
-- GIFT SHOP
------------------------------------------------------------------

EconomyExtras.GiftShop = {
    -- Gift types
    GiftTypes = {
        Small = {
            Name = "Small Gift",
            Price = 50,
            Currency = "Robux",
            PossibleContents = {
                {Item = "Coins", Amount = 1000, Chance = 40},
                {Item = "Diamonds", Amount = 5, Chance = 30},
                {Item = "BasicEgg", Amount = 1, Chance = 20},
                {Item = "Hat_Common", Amount = 1, Chance = 10}
            }
        },
        Medium = {
            Name = "Medium Gift",
            Price = 150,
            Currency = "Robux",
            PossibleContents = {
                {Item = "Coins", Amount = 5000, Chance = 35},
                {Item = "Diamonds", Amount = 15, Chance = 30},
                {Item = "RareEgg", Amount = 1, Chance = 25},
                {Item = "Hat_Rare", Amount = 1, Chance = 10}
            }
        },
        Large = {
            Name = "Large Gift",
            Price = 500,
            Currency = "Robux",
            PossibleContents = {
                {Item = "Coins", Amount = 25000, Chance = 30},
                {Item = "Diamonds", Amount = 50, Chance = 30},
                {Item = "EpicEgg", Amount = 1, Chance = 25},
                {Item = "Skin_Epic", Amount = 1, Chance = 15}
            }
        },
        Mega = {
            Name = "Mega Gift",
            Price = 1000,
            Currency = "Robux",
            PossibleContents = {
                {Item = "Coins", Amount = 100000, Chance = 25},
                {Item = "Diamonds", Amount = 100, Chance = 25},
                {Item = "CelestialEgg", Amount = 1, Chance = 25},
                {Item = "Skin_Legendary", Amount = 1, Chance = 25}
            }
        }
    },

    -- Gift history
    GiftCooldown = 86400, -- 24 hours between gifts to same player
    MaxGiftsPerDay = 10,

    -- Free daily gift
    FreeGift = {
        Cooldown = 43200, -- 12 hours
        Reward = {Coins = 100, Diamonds = 1}
    },

    -- Create gift
    CreateGift = function(giftType, senderId, receiverId)
        local giftTemplate = EconomyExtras.GiftShop.GiftTypes[giftType]
        if not giftTemplate then return nil end

        return {
            Id = os.time(),
            Type = giftType,
            SenderId = senderId,
            ReceiverId = receiverId,
            Contents = EconomyExtras.RollGiftContents(giftType),
            Message = "",
            SentAt = os.time(),
            Opened = false
        }
    end
}

-- Roll gift contents
function EconomyExtras.RollGiftContents(giftType)
    local template = EconomyExtras.GiftShop.GiftTypes[giftType]
    local roll = math.random() * 100
    local current = 0

    for _, item in ipairs(template.PossibleContents) do
        current = current + item.Chance
        if roll <= current then
            return {Item = item.Item, Amount = item.Amount}
        end
    end

    return template.PossibleContents[1]
end

------------------------------------------------------------------
-- LUCKY WHEEL
------------------------------------------------------------------

EconomyExtras.LuckyWheel = {
    -- Spin cost
    SpinCost = 50, -- Robux
    FreeSpinCooldown = 86400, -- 24 hours

    -- Wheel segments
    Segments = {
        {Reward = {Coins = 100}, Weight = 20, Color = Color3.fromRGB(200, 200, 200)},
        {Reward = {Coins = 500}, Weight = 15, Color = Color3.fromRGB(180, 180, 180)},
        {Reward = {Coins = 1000}, Weight = 12, Color = Color3.fromRGB(100, 200, 100)},
        {Reward = {Diamonds = 5}, Weight = 15, Color = Color3.fromRGB(100, 150, 255)},
        {Reward = {Diamonds = 10}, Weight = 10, Color = Color3.fromRGB(100, 100, 255)},
        {Reward = {Diamonds = 25}, Weight = 5, Color = Color3.fromRGB(255, 100, 255)},
        {Reward = {BasicEgg = 1}, Weight = 8, Color = Color3.fromRGB(144, 238, 144)},
        {Reward = {RareEgg = 1}, Weight = 5, Color = Color3.fromRGB(100, 149, 237)},
        {Reward = {EpicEgg = 1}, Weight = 3, Color = Color3.fromRGB(147, 112, 219)},
        {Reward = {Hat_Crown = 1}, Weight = 2, Color = Color3.fromRGB(255, 215, 0)},
        {Reward = {Nothing = true}, Weight = 3, Color = Color3.fromRGB(50, 50, 50)},
        {Reward = {Jackpot = true}, Weight = 2, Color = Color3.fromRGB(255, 0, 0)}
    },

    -- Jackpot
    Jackpot = {
        Reward = {Robux = 100},
        Multiplier = 10
    },

    -- Lucky Spin (guaranteed good reward)
    LuckySpin = {
        Cost = 200,
        MinReward = "RareEgg"
    },

    -- Spin the wheel
    Spin = function(isFree)
        if not isFree and not EconomyExtras.CanAffordSpin() then
            return nil, "Cannot afford spin"
        end

        local totalWeight = 0
        for _, segment in ipairs(EconomyExtras.LuckyWheel.Segments) do
            totalWeight = totalWeight + segment.Weight
        end

        local roll = math.random() * totalWeight
        local current = 0

        for _, segment in ipairs(EconomyExtras.LuckyWheel.Segments) do
            current = current + segment.Weight
            if roll <= current then
                return segment.Reward, segment.Color
            end
        end

        return EconomyExtras.LuckyWheel.Segments[1].Reward
    end
}

------------------------------------------------------------------
-- DAILY REWARDS
------------------------------------------------------------------

EconomyExtras.DailyRewards = {
    -- Reward streak
    MaxStreak = 7,

    -- Rewards by day
    Rewards = {
        {Day = 1, Reward = {Coins = 100}},
        {Day = 2, Reward = {Coins = 250}},
        {Day = 3, Reward = {Coins = 500, Diamonds = 1}},
        {Day = 4, Reward = {Coins = 750}},
        {Day = 5, Reward = {Coins = 1000, Diamonds = 2}},
        {Day = 6, Reward = {Coins = 1500}},
        {Day = 7, Reward = {Coins = 5000, Diamonds = 10, RareEgg = 1}}
    },

    -- Claim daily reward
    ClaimDaily = function(streak)
        local day = ((streak - 1) % 7) + 1
        return EconomyExtras.DailyRewards.Rewards[day].Reward
    end
}

------------------------------------------------------------------
-- BUNDLES
------------------------------------------------------------------

EconomyExtras.Bundles = {
    -- Available bundles
    List = {
        {
            Id = "bundle_beginner",
            Name = "Beginner Bundle",
            Price = 99,
            Currency = "Robux",
            Contents = {
                {Item = "Coins", Amount = 5000},
                {Item = "BasicEgg", Amount = 3},
                {Item = "SpeedBoost", Amount = 1}
            },
            Value = 250,
            Description = "Perfect for new players"
        },
        {
            Id = "bundle_grower",
            Name = "Grower Bundle",
            Price = 249,
            Currency = "Robux",
            Contents = {
                {Item = "Coins", Amount = 25000},
                {Item = "RareEgg", Amount = 2},
                {Item = "EpicEgg", Amount = 1},
                {Item = "SpeedBoost", Amount = 3}
            },
            Value = 750,
            Description = "For growing swarms"
        },
        {
            Id = "bundle_master",
            Name = "Master Bundle",
            Price = 499,
            Currency = "Robux",
            Contents = {
                {Item = "Coins", Amount = 100000},
                {Item = "EpicEgg", Amount = 3},
                {Item = "CelestialEgg", Amount = 1},
                {Item = "Hat_Legendary", Amount = 1},
                {Item = "Skin_Epic", Amount = 1}
            },
            Value = 2000,
            Description = "For dedicated players"
        },
        {
            Id = "bundle_ultimate",
            Name = "Ultimate Bundle",
            Price = 999,
            Currency = "Robux",
            Contents = {
                {Item = "Coins", Amount = 500000},
                {Item = "CelestialEgg", Amount = 2},
                {Item = "InfiniteEgg", Amount = 1},
                {Item = "Hat_Ultimate", Amount = 1},
                {Item = "Skin_Legendary", Amount = 1},
                {Item = "Pet_Legendary", Amount = 1}
            },
            Value = 5000,
            Description = "Everything you need!"
        }
    }
}

------------------------------------------------------------------
-- HELPER FUNCTIONS
------------------------------------------------------------------

function EconomyExtras.GetPet(petId)
    for _, pet in ipairs(EconomyExtras.Pets.List) do
        if pet.Id == petId then
            return pet
        end
    end
    return nil
end

function EconomyExtras.GetPetsByRarity(rarity)
    local result = {}
    for _, pet in ipairs(EconomyExtras.Pets.List) do
        if pet.Rarity == rarity then
            table.insert(result, pet)
        end
    end
    return result
end

function EconomyExtras.CreatePlayerPetData()
    return {
        OwnedPets = {},
        EquippedPets = {},
        PetSlots = EconomyExtras.Pets.MaxPets
    }
end

function EconomyExtras.ClaimDailyReward(streak)
    return EconomyExtras.DailyRewards.ClaimDaily(streak)
end

function EconomyExtras.GetBundle(bundleId)
    for _, bundle in ipairs(EconomyExtras.Bundles.List) do
        if bundle.Id == bundleId then
            return bundle
        end
    end
    return nil
end

return EconomyExtras
