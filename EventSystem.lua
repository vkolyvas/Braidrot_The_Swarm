--[[
    EventSystem ModuleScript
    Halloween, Christmas, Anniversary, Community Events
    Place in ReplicatedStorage > EventSystem
]]

local EventSystem = {}

------------------------------------------------------------------
-- EVENT TYPES
------------------------------------------------------------------

EventSystem.Events = {
    Halloween = {
        Id = "halloween",
        Name = "Spooky Season",
        Icon = "🎃",
        StartDate = "10-01",
        EndDate = "10-31",

        -- Special Braidrots
        LimitedBraidrots = {
            {
                Name = "Pumpkin Rot",
                Rarity = "Epic",
                BaseCoinsPerSecond = 150,
                Description = "A spooky pumpkin-headed Braidrot",
                Appearance = "Orange with jack-o-lantern face"
            },
            {
                Name = "Ghost Wisp",
                Rarity = "Rare",
                BaseCoinsPerSecond = 75,
                Description = "A ghostly floating Braidrot",
                Appearance = "Translucent white with glowing eyes"
            },
            {
                Name = "Skeleton Rot",
                Rarity = "Legendary",
                BaseCoinsPerSecond = 500,
                Description = "Ancient skeleton Braidrot",
                Appearance = "Bone white with glowing purple joints"
            }
        },

        -- Special cosmetics
        Cosmetics = {
            Hats = {"hat_pumpkin", "hat_witch", "hat_skull"},
            Skins = {"skin_shadow"},
            Trails = {"trail_smoke"}
        },

        -- Game modifications
        Modifiers = {
            CoinMultiplier = 1.5,
            EnemyHealth = 1.25,
            SpookyAmbience = true
        },

        -- Special rewards
        Rewards = {
            CompleteEvent = {Title = "Spooky Survivor", ExclusiveSkin = "pumpkin"},
            CollectAll = {Robux = 100, Title = "Ghost Hunter"}
        }
    },

    Christmas = {
        Id = "christmas",
        Name = "Winter Wonderland",
        Icon = "🎄",
        StartDate = "12-01",
        EndDate = "12-31",

        -- Special Braidrots
        LimitedBraidrots = {
            {
                Name = "Frosty Rot",
                Rarity = "Epic",
                BaseCoinsPerSecond = 150,
                Description = "A snow-covered Braidrot",
                Appearance = "White with ice crystals"
            },
            {
                Name = "Candy Cane",
                Rarity = "Rare",
                BaseCoinsPerSecond = 75,
                Description = "Sweet candy cane Braidrot",
                Appearance = "Red and white striped"
            },
            {
                Name = "Santa Rot",
                Rarity = "Legendary",
                BaseCoinsPerSecond = 500,
                Description = "Santa's helper Braidrot",
                Appearance = "Santa hat and bag"
            }
        },

        -- Special cosmetics
        Cosmetics = {
            Hats = {"hat_santa", "hat_elf", "hat_reindeer"},
            Skins = {"skin_snow"},
            Trails = {"trail_snow"}
        },

        -- Game modifications
        Modifiers = {
            CoinMultiplier = 1.5,
            SnowAmbience = true,
            SleighRideMinigame = true
        },

        -- Special rewards
        Rewards = {
            CompleteEvent = {Title = "Winter Champion", ExclusiveSkin = "snow"},
            CollectAll = {Robux = 100, Title = "Santa's Favorite"}
        }
    },

    Anniversary = {
        Id = "anniversary",
        Name = "Braidrot Anniversary",
        Icon = "🎉",
        StartDate = "01-01",
        EndDate = "01-07",

        -- Special Braidrots
        LimitedBraidrots = {
            {
                Name = "Party Popper",
                Rarity = "Epic",
                BaseCoinsPerSecond = 200,
                Description = "Always celebrating!",
                Appearance = "Confetti everywhere"
            },
            {
                Name = "Golden Jubilee",
                Rarity = "Legendary",
                BaseCoinsPerSecond = 750,
                Description = "Celebration in gold",
                Appearance = "Pure gold with sparkles"
            }
        },

        -- Special cosmetics
        Cosmetics = {
            Hats = {"hat_party", "hat_trophy"},
            Skins = {"skin_golden"},
            Trails = {"trail_rainbow"}
        },

        -- Game modifications
        Modifiers = {
            CoinMultiplier = 2.0,
            DiamondChance = 2.0,
            HatchLuck = 1.5
        },

        -- Special rewards
        Rewards = {
            CompleteEvent = {Title = "Anniversary Celebrant", ExclusiveEgg = "anniversary_egg"},
            CollectAll = {Robux = 200, Title = "Founding Member"}
        }
    },

    Summer = {
        Id = "summer",
        Name = "Summer Blast",
        Icon = "☀️",
        StartDate = "06-01",
        EndDate = "08-31",

        -- Special Braidrots
        LimitedBraidrots = {
            {
                Name = "Beach Ball",
                Rarity = "Epic",
                BaseCoinsPerSecond = 150,
                Description = "Fun in the sun!",
                Appearance = "Colorful beach ball pattern"
            },
            {
                Name = "Ocean Wave",
                Rarity = "Rare",
                BaseCoinsPerSecond = 75,
                Description = "Cool as ocean water",
                Appearance = "Blue with wave pattern"
            }
        },

        -- Game modifications
        Modifiers = {
            CoinMultiplier = 1.25,
            BeachMap = true,
            WaterBalloonMinigame = true
        }
    }
}

------------------------------------------------------------------
-- COMMUNITY CHALLENGES
------------------------------------------------------------------

EventSystem.CommunityChallenges = {
    -- Challenge types
    Types = {
        Collect = {Goal = "Collect {amount} coins", Metric = "coins"},
        Hatch = {Goal = "Hatch {amount} eggs", Metric = "hatches"},
        Battle = {Goal = "Win {amount} battles", Metric = "wins"},
        Spawn = {Goal = "Spawn {amount} units", Metric = "spawns"},
        Trade = {Goal = "Complete {amount} trades", Metric = "trades"}
    },

    -- Challenge templates
    Templates = {
        {
            Name = "Coin Rush",
            Type = "Collect",
            GoalAmount = 1000000,
            Duration = 86400, -- 24 hours
            Reward = {Coins = 50000, Diamonds = 25}
        },
        {
            Name = "Hatching Frenzy",
            Type = "Hatch",
            GoalAmount = 100,
            Duration = 86400,
            Reward = {Coins = 25000, Diamonds = 50}
        },
        {
            Name = "Battle Arena",
            Type = "Battle",
            GoalAmount = 50,
            Duration = 172800, -- 48 hours
            Reward = {Coins = 30000, Diamonds = 75}
        },
        {
            Name = "Swarm Swarm",
            Type = "Spawn",
            GoalAmount = 500,
            Duration = 86400,
            Reward = {Coins = 20000, Diamonds = 30}
        }
    },

    -- Server-wide goals
    ServerGoals = {
        {
            Name = "Global Coin Collection",
            Goal = 100000000,
            Current = 0,
            Reward = {AllPlayers = {Diamonds = 10}},
            Progress = 0
        },
        {
            Name = "Total Battles Won",
            Goal = 1000000,
            Current = 0,
            Reward = {AllPlayers = {Coins = 10000}},
            Progress = 0
        }
    }
}

------------------------------------------------------------------
-- LIMITED TIME OFFERS
------------------------------------------------------------------

EventSystem.LimitedOffers = {
    -- Offer types
    Types = {
        Bundle = "Bundle",
        Discount = "Discount",
        Mystery = "Mystery Box",
        Flash = "Flash Sale"
    },

    -- Active offers
    Offers = {
        {
            Id = "starter_pack",
            Name = "Starter Pack",
            Type = "Bundle",
            OriginalPrice = 1000,
            SalePrice = 250,
            Currency = "Robux",
            Contents = {
                {Item = "Egg_Basic", Amount = 5},
                {Item = "Coins", Amount = 10000},
                {Item = "Diamonds", Amount = 10}
            },
            Duration = 2592000, -- 30 days from account creation
            OneTimePurchase = true
        },
        {
            Id = "mystery_box_100",
            Name = "Mystery Box (100)",
            Type = "Mystery",
            Price = 100,
            Currency = "Robux",
            PossibleRewards = {
                {Item = "Diamonds", Amount = 10, Chance = 30},
                {Item = "Egg_Epic", Amount = 1, Chance = 20},
                {Item = "Egg_Rare", Amount = 1, Chance = 30},
                {Item = "Coins", Amount = 5000, Chance = 20}
            }
        },
        {
            Id = "flash_diamonds",
            Name = "Flash Diamond Sale",
            Type = "Flash",
            Price = 100,
            Currency = "Robux",
            BonusPercent = 100, -- Get 100% bonus diamonds
            Duration = 3600 -- 1 hour
        }
    }
}

------------------------------------------------------------------
-- DAILY / WEEKLY SPECIALS
------------------------------------------------------------------

EventSystem.DailySpecials = {
    -- Daily deals (resets every 24 hours)
    Daily = {
        {
            Id = "daily_egg_50",
            Item = "BasicEgg",
            Discount = 50,
            Limit = 3
        },
        {
            Id = "daily_coins_25",
            Item = "Coins",
            Amount = 50000,
            Discount = 25,
            Limit = 1
        }
    },

    -- Weekly deals (resets every 7 days)
    Weekly = {
        {
            Id = "weekly_epic_egg",
            Item = "EpicEgg",
            Discount = 30,
            Limit = 1
        },
        {
            Id = "weekly_mystery",
            Item = "MysteryBox",
            Discount = 50,
            Limit = 1
        }
    }
}

------------------------------------------------------------------
-- HELPER FUNCTIONS
------------------------------------------------------------------

function EventSystem.GetActiveEvent()
    local month = os.date("%m")
    local day = os.date("%d")
    local current = month .. "-" .. day

    for _, event in pairs(EventSystem.Events) do
        if current >= event.StartDate and current <= event.EndDate then
            return event
        end
    end

    return nil
end

function EventSystem.GetEventById(id)
    return EventSystem.Events[id]
end

function EventSystem.GetLimitedBraidrots(eventId)
    local event = EventSystem.Events[eventId]
    if event and event.LimitedBraidrots then
        return event.LimitedBraidrots
    end
    return {}
end

function EventSystem.GetCommunityChallenge()
    return EventSystem.CommunityChallenges.Templates[math.random(#EventSystem.CommunityChallenges.Templates)]
end

function EventSystem.GetDailyDeals()
    return EventSystem.DailySpecials.Daily
end

function EventSystem.GetWeeklyDeals()
    return EventSystem.DailySpecials.Weekly
end

function EventSystem.GetLimitedOffer(offerId)
    for _, offer in ipairs(EventSystem.LimitedOffers.Offers) do
        if offer.Id == offerId then
            return offer
        end
    end
    return nil
end

function EventSystem.RollMysteryBox(boxId)
    local offer = EventSystem.GetLimitedOffer(boxId)
    if not offer or offer.Type ~= "Mystery" then
        return nil
    end

    local roll = math.random() * 100
    local current = 0

    for _, reward in ipairs(offer.PossibleRewards) do
        current = current + reward.Chance
        if roll <= current then
            return reward
        end
    end

    return offer.PossibleRewards[1]
end

return EventSystem
