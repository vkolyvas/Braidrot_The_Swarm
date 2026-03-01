--[[
    ProgressionSystem ModuleScript
    Daily Quests, Achievements, Season Pass, Artifacts
    Place in ReplicatedStorage > ProgressionSystem
]]

local ProgressionSystem = {}

------------------------------------------------------------------
-- DAILY QUESTS
------------------------------------------------------------------

ProgressionSystem.DailyQuests = {
    -- Quest refresh time (24 hours)
    RefreshTime = 86400,

    -- Quest types
    Types = {
        Collect = {
            Name = "Collect Coins",
            Description = "Collect {amount} coins",
            Icon = "💰"
        },
        Hatch = {
            Name = "Hatch Eggs",
            Description = "Hatch {amount} eggs",
            Icon = "🥚"
        },
        Upgrade = {
            Name = "Upgrade Braidrots",
            Description = "Upgrade {amount} Braidrots",
            Icon = "⬆️"
        },
        Battle = {
            Name = "Win Battles",
            Description = "Win {amount} battles",
            Icon = "⚔️"
        },
        Spawn = {
            Name = "Spawn Units",
            Description = "Spawn {amount} swarm units",
            Icon = "🧬"
        },
        Visit = {
            Name = "Visit Friends",
            Description = "Visit {amount} friends",
            Icon = "👥"
        },
        Trade = {
            Name = "Complete Trades",
            Description = "Complete {amount} trades",
            Icon = "🤝"
        }
    },

    -- Quest templates (randomly selected daily)
    Templates = {
        {
            Type = "Collect",
            Amount = 10000,
            Reward = {Coins = 500, Diamonds = 5}
        },
        {
            Type = "Collect",
            Amount = 50000,
            Reward = {Coins = 2000, Diamonds = 10}
        },
        {
            Type = "Hatch",
            Amount = 3,
            Reward = {Coins = 1000, Diamonds = 10}
        },
        {
            Type = "Hatch",
            Amount = 5,
            Reward = {Coins = 2500, Diamonds = 25}
        },
        {
            Type = "Upgrade",
            Amount = 5,
            Reward = {Coins = 1500, Diamonds = 15}
        },
        {
            Type = "Battle",
            Amount = 3,
            Reward = {Coins = 2000, Diamonds = 20}
        },
        {
            Type = "Spawn",
            Amount = 20,
            Reward = {Coins = 1000, Diamonds = 5}
        },
        {
            Type = "Visit",
            Amount = 2,
            Reward = {Coins = 500, Diamonds = 10}
        },
        {
            Type = "Trade",
            Amount = 1,
            Reward = {Coins = 1000, Diamonds = 15}
        }
    },

    -- Bonus quest (harder)
    BonusQuest = {
        Type = "Collect",
        Amount = 100000,
        Reward = {Coins = 10000, Diamonds = 50},
        IsBonus = true
    }
}

------------------------------------------------------------------
-- ACHIEVEMENTS
------------------------------------------------------------------

ProgressionSystem.Achievements = {
    -- Achievement categories
    Categories = {
        Collection = {Name = "Collection", Icon = "🃏"},
        Combat = {Name = "Combat", Icon = "⚔️"},
        Economy = {Name = "Economy", Icon = "💰"},
        Social = {Name = "Social", Icon = "👥"},
        Progression = {Name = "Progression", Icon = "📈"},
        Special = {Name = "Special", Icon = "⭐"}
    },

    -- All achievements
    List = {
        -- Collection achievements
        {
            Id = "collect_10",
            Name = "Beginner Collector",
            Description = "Collect 10 unique Braidrots",
            Category = "Collection",
            Requirement = 10,
            Stat = "UniqueBraidrots",
            Reward = {Coins = 1000, Title = "Collector"},
            Icon = "🎯"
        },
        {
            Id = "collect_50",
            Name = "Master Collector",
            Description = "Collect 50 unique Braidrots",
            Category = "Collection",
            Requirement = 50,
            Stat = "UniqueBraidrots",
            Reward = {Diamonds = 50, Title = "Master Collector"},
            Icon = "🏆"
        },
        {
            Id = "collect_all",
            Name = "Braidrot Professor",
            Description = "Collect all Braidrots",
            Category = "Collection",
            Requirement = 20,
            Stat = "UniqueBraidrots",
            Reward = {Robux = 100, Title = "Professor", ExclusiveSkin = "skin_rainbow"},
            Icon = "🎓"
        },

        -- Combat achievements
        {
            Id = "kill_1000",
            Name = "Swarm Killer",
            Description = "Defeat 1,000 enemies",
            Category = "Combat",
            Requirement = 1000,
            Stat = "EnemiesKilled",
            Reward = {Coins = 5000, Title = "Swarm Killer"},
            Icon = "🗡️"
        },
        {
            Id = "win_100",
            Name = "Battle Champion",
            Description = "Win 100 battles",
            Category = "Combat",
            Requirement = 100,
            Stat = "BattlesWon",
            Reward = {Diamonds = 100, Title = "Champion"},
            Icon = "🥇"
        },
        {
            Id = "boss_1",
            Name = "Boss Slayer",
            Description = "Defeat your first boss",
            Category = "Combat",
            Requirement = 1,
            Stat = "BossesDefeated",
            Reward = {Coins = 2500, Title = "Boss Slayer"},
            Icon = "👹"
        },

        -- Economy achievements
        {
            Id = "earn_1m",
            Name = "Millionaire",
            Description = "Earn 1,000,000 coins total",
            Category = "Economy",
            Requirement = 1000000,
            Stat = "TotalCoinsEarned",
            Reward = {Coins = 10000, Title = "Millionaire"},
            Icon = "💎"
        },
        {
            Id = "spend_100k",
            Name = "Big Spender",
            Description = "Spend 100,000 coins on upgrades",
            Category = "Economy",
            Requirement = 100000,
            Stat = "TotalSpent",
            Reward = {Diamonds = 25, Title = "Big Spender"},
            Icon = "🛒"
        },

        -- Progression achievements
        {
            Id = "level_10",
            Name = "Getting Stronger",
            Description = "Reach level 10",
            Category = "Progression",
            Requirement = 10,
            Stat = "PlayerLevel",
            Reward = {Coins = 500, Title = "Rising Star"},
            Icon = "⭐"
        },
        {
            Id = "rebirth_5",
            Name = "Prestige V",
            Description = "Rebirth 5 times",
            Category = "Progression",
            Requirement = 5,
            Stat = "RebirthCount",
            Reward = {Diamonds = 100, Title = "Prestige V"},
            Icon = "🔄"
        },

        -- Special achievements
        {
            Id = "first_diamond",
            Name = "Diamond Digger",
            Description = "Earn your first diamond",
            Category = "Special",
            Requirement = 1,
            Stat = "DiamondsEarned",
            Reward = {Diamonds = 10},
            Icon = "💠"
        },
        {
            Id = "colossus_spawn",
            Name = "Colossus Commander",
            Description = "Spawn The Colossus",
            Category = "Special",
            Requirement = 1,
            Stat = "ColossusSpawned",
            Reward = {Robux = 50, Title = "Colossus Commander"},
            Icon = "🦍"
        }
    }
}

------------------------------------------------------------------
-- SEASON PASS / BATTLE PASS
------------------------------------------------------------------

ProgressionSystem.SeasonPass = {
    -- Season settings
    Duration = 90, -- days
    MaxLevel = 100,

    -- Free track rewards
    FreeRewards = {
        {Level = 1, Reward = {Coins = 100}},
        {Level = 5, Reward = {Coins = 500}},
        {Level = 10, Reward = {Diamonds = 10}},
        {Level = 20, Reward = {Coins = 1000}},
        {Level = 30, Reward = {Diamonds = 25}},
        {Level = 50, Reward = {Coins = 2500}},
        {Level = 75, Reward = {Diamonds = 50}},
        {Level = 100, Reward = {Diamonds = 100, ExclusiveBraidrot = "Shadow Braidrot"}}
    },

    -- Premium track rewards
    PremiumRewards = {
        {Level = 1, Reward = {Coins = 500, Diamonds = 5}},
        {Level = 5, Reward = {Coins = 1000, ExclusiveHat = "hat_crystal"}},
        {Level = 10, Reward = {Diamonds = 25, ExclusiveSkin = "skin_rainbow"}},
        {Level = 20, Reward = {Coins = 2500, Diamonds = 50}},
        {Level = 30, Reward = {ExclusiveTrail = "trail_void"}},
        {Level = 50, Reward = {Diamonds = 100, ExclusiveBraidrot = "Golden Glitch"}},
        {Level = 75, Reward = {Robux = 100}},
        {Level = 100, Reward = {Robux = 500, ExclusiveColossusSkin = "golden"}}
    },

    -- Premium cost
    PremiumCost = 950, -- Robux

    -- XP per level
    XPPerLevel = 1000,
    XPMultipliers = {
        DailyQuest = 2.0,
        Battle = 1.5,
        Hatch = 1.0,
        Achievement = 3.0
    }
}

------------------------------------------------------------------
-- ARTIFACT SYSTEM
------------------------------------------------------------------

ProgressionSystem.Artifacts = {
    -- Artifact slots
    Slots = {
        {Id = "weapon", Name = "Weapon", MaxArtifacts = 1},
        {Id = "armor", Name = "Armor", MaxArtifacts = 1},
        {Id = "accessory", Name = "Accessory", MaxArtifacts = 2},
        {Id = "pet", Name = "Pet", MaxArtifacts = 1}
    },

    -- Artifacts
    List = {
        {
            Id = "art_spore_orb",
            Name = "Spore Orb",
            Slot = "weapon",
            Rarity = "Common",
            StatBoost = {Damage = 10},
            Description = "Increases unit damage by 10%",
            Price = 500
        },
        {
            Id = "art_root_shield",
            Name = "Root Shield",
            Slot = "armor",
            Rarity = "Common",
            StatBoost = {Defense = 10},
            Description = "Increases unit defense by 10%",
            Price = 500
        },
        {
            Id = "art_speed_boots",
            Name = "Speed Boots",
            Slot = "accessory",
            Rarity = "Uncommon",
            StatBoost = {Speed = 15},
            Description = "Increases movement speed by 15%",
            Price = 1000
        },
        {
            Id = "art_lucky_charm",
            Name = "Lucky Charm",
            Slot = "accessory",
            Rarity = "Rare",
            StatBoost = {Luck = 20},
            Description = "Increases hatch luck by 20%",
            Price = 2500
        },
        {
            Id = "art_ancient_tome",
            Name = "Ancient Tome",
            Slot = "weapon",
            Rarity = "Epic",
            StatBoost = {Damage = 25, CritChance = 10},
            Description = "+25% Damage, 10% Crit chance",
            Price = 5000
        },
        {
            Id = "art_dragon_heart",
            Name = "Dragon Heart",
            Slot = "armor",
            Rarity = "Legendary",
            StatBoost = {Defense = 30, Health = 50},
            Description = "+30% Defense, +50% Health",
            Price = 10000
        },
        {
            Id = "art_colossus_soul",
            Name = "Colossus Soul",
            Slot = "pet",
            Rarity = "Ultimate",
            StatBoost = {AllStats = 20},
            Description = "+20% to ALL stats",
            Price = 50000
        }
    }
}

------------------------------------------------------------------
-- HELPER FUNCTIONS
------------------------------------------------------------------

function ProgressionSystem.GetDailyQuests()
    local quests = {}
    local used = {}

    -- Select 3 random quests
    for i = 1, 3 do
        local template
        repeat
            template = ProgressionSystem.DailyQuests.Templates[math.random(#ProgressionSystem.DailyQuests.Templates)]
        until not used[template.Type]

        used[template.Type] = true
        table.insert(quests, {
            Type = template.Type,
            Amount = template.Amount,
            Progress = 0,
            Reward = template.Reward,
            Completed = false
        })
    end

    -- Add bonus quest
    table.insert(quests, {
        Type = ProgressionSystem.BonusQuest.Type,
        Amount = ProgressionSystem.BonusQuest.Amount,
        Progress = 0,
        Reward = ProgressionSystem.BonusQuest.Reward,
        Completed = false,
        IsBonus = true
    })

    return quests
end

function ProgressionSystem.GetAchievements()
    return ProgressionSystem.Achievements.List
end

function ProgressionSystem.GetAchievementCategory(category)
    local result = {}
    for _, ach in ipairs(ProgressionSystem.Achievements.List) do
        if ach.Category == category then
            table.insert(result, ach)
        end
    end
    return result
end

function ProgressionSystem.GetSeasonReward(level, isPremium)
    local rewards = isPremium and ProgressionSystem.SeasonPass.PremiumRewards or ProgressionSystem.SeasonPass.FreeRewards
    for _, reward in ipairs(rewards) do
        if reward.Level == level then
            return reward.Reward
        end
    end
    return nil
end

function ProgressionSystem.GetArtifact(artifactId)
    for _, art in ipairs(ProgressionSystem.Artifacts.List) do
        if art.Id == artifactId then
            return art
        end
    end
    return nil
end

function ProgressionSystem.CreatePlayerProgressionData()
    return {
        Level = 1,
        XP = 0,
        DailyQuests = ProgressionSystem.GetDailyQuests(),
        DailyQuestsLastRefresh = os.time(),
        Achievements = {},
        SeasonLevel = 1,
        SeasonXP = 0,
        SeasonPremium = false,
        Artifacts = {
            weapon = nil,
            armor = nil,
            accessory = {},
            pet = nil
        },
        Stats = {
            UniqueBraidrots = 0,
            EnemiesKilled = 0,
            BattlesWon = 0,
            BossesDefeated = 0,
            TotalCoinsEarned = 0,
            TotalSpent = 0,
            DiamondsEarned = 0,
            RebirthCount = 0,
            PlayerLevel = 1,
            ColossusSpawned = 0
        }
    }
end

return ProgressionSystem
