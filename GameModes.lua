--[[
    GameModes ModuleScript
    Tower Defense, PvP Arena, Endless Survival, Race Mode
    Place in ReplicatedStorage > GameModes
]]

local GameModes = {}

------------------------------------------------------------------
-- TOWER DEFENSE MODE
------------------------------------------------------------------

GameModes.TowerDefense = {
    Name = "Tower Defense",
    Description = "Place Mother-Knots along paths, Braidrots march out to attack enemy waves",

    -- Map configurations
    Maps = {
        ForestPath = {
            Name = "Forest Path",
            Difficulty = 1,
            PathPoints = {
                Vector3.new(0, 0, 0),
                Vector3.new(0, 0, 50),
                Vector3.new(50, 0, 50),
                Vector3.new(50, 0, 100),
                Vector3.new(100, 0, 100)
            },
            SpawnPoints = {
                {Position = Vector3.new(0, 5, 0), EnemyType = "Basic", Interval = 5}
            },
            BaseHealth = 100,
            Waves = 20,
            Reward = {Coins = 10000, Diamonds = 10}
        },
        LavaRidge = {
            Name = "Lava Ridge",
            Difficulty = 2,
            PathPoints = {
                Vector3.new(0, 0, 0),
                Vector3.new(25, 5, 25),
                Vector3.new(75, 10, 25),
                Vector3.new(75, 15, 75),
                Vector3.new(125, 20, 75)
            },
            SpawnPoints = {
                {Position = Vector3.new(0, 5, 0), EnemyType = "Fast", Interval = 3}
            },
            BaseHealth = 150,
            Waves = 30,
            Reward = {Coins = 25000, Diamonds = 25}
        },
        CrystalCave = {
            Name = "Crystal Cave",
            Difficulty = 3,
            PathPoints = {
                Vector3.new(0, 0, 0),
                Vector3.new(30, 0, 30),
                Vector3.new(30, 10, 60),
                Vector3.new(60, 10, 60),
                Vector3.new(60, 20, 100)
            },
            SpawnPoints = {
                {Position = Vector3.new(0, 5, 0), EnemyType = "Tank", Interval = 8}
            },
            BaseHealth = 200,
            Waves = 40,
            Reward = {Coins = 50000, Diamonds = 50}
        }
    },

    -- Enemy types
    Enemies = {
        Basic = {
            Name = "Critter",
            Health = 50,
            Speed = 10,
            Damage = 10,
            Reward = 5
        },
        Fast = {
            Name = "Swift Critter",
            Health = 30,
            Speed = 20,
            Damage = 5,
            Reward = 8
        },
        Tank = {
            Name = "Armored Critter",
            Health = 200,
            Speed = 5,
            Damage = 25,
            Reward = 20
        },
        Boss = {
            Name = "Critter King",
            Health = 1000,
            Speed = 8,
            Damage = 50,
            Reward = 100
        }
    },

    -- Placement costs
    PlacementCost = 500,
    MaxTowers = 10
}

------------------------------------------------------------------
-- PVP ARENA MODE
------------------------------------------------------------------

GameModes.PvPArena = {
    Name = "PvP Arena",
    Description = "Battle other players' swarms in real-time",

    -- Arena types
    Arenas = {
        Small = {
            Name = "1v1 Duel",
            Players = 2,
            MapSize = Vector3.new(100, 50, 100),
            TimeLimit = 300,
            Reward = {Coins = 5000, Diamonds = 5, RankPoints = 10}
        },
        Medium = {
            Name = "2v2 Battle",
            Players = 4,
            MapSize = Vector3.new(150, 50, 150),
            TimeLimit = 420,
            Reward = {Coins = 10000, Diamonds = 15, RankPoints = 25}
        },
        Large = {
            Name = "4v4 War",
            Players = 8,
            MapSize = Vector3.new(200, 50, 200),
            TimeLimit = 600,
            Reward = {Coins = 25000, Diamonds = 30, RankPoints = 50}
        }
    },

    -- Scoring
    Scoring = {
        KillUnit = 1,
        KillColossus = 50,
        DestroyMotherKnot = 100,
        WinMatch = 25
    },

    -- Ban system
    BannedUnits = {},
    BanDuration = 300 -- seconds
}

------------------------------------------------------------------
-- ENDLESS SURVIVAL MODE
------------------------------------------------------------------

GameModes.EndlessSurvival = {
    Name = "Endless Survival",
    Description = "Infinite waves of enemies, see how long your swarm lasts",

    -- Difficulty scaling
    Scaling = {
        WaveMultiplier = 1.1, -- 10% harder each wave
        EnemyHealthScale = 1.05,
        EnemyDamageScale = 1.05,
        EnemySpeedScale = 1.02
    },

    -- Special waves
    SpecialWaves = {
        {
            Wave = 10,
            Name = "Boss Wave",
            EnemyType = "Boss",
            Count = 1
        },
        {
            Wave = 25,
            Name = "Swarm Wave",
            EnemyType = "Basic",
            Count = 50
        },
        {
            Wave = 50,
            Name = "Titan Wave",
            EnemyType = "Tank",
            Count = 10
        },
        {
            Wave = 100,
            Name = "Final Stand",
            EnemyType = "Boss",
            Count = 5
        }
    },

    -- Rewards (per wave survived)
    Rewards = {
        CoinsPerWave = 100,
        DiamondsEvery10Waves = 5,
        RareBraidrotEvery25Waves = true
    },

    -- Leaderboard
    HighScores = {}
}

------------------------------------------------------------------
-- RACE MODE
------------------------------------------------------------------

GameModes.RaceMode = {
    Name = "Race Mode",
    Description = "Your swarm runs through obstacle courses, first to finish wins",

    -- Race tracks
    Tracks = {
        BasicTrack = {
            Name = "Grasslands Run",
            Difficulty = 1,
            Length = 500,
            Checkpoints = 5,
            Obstacles = {"Spikes", "Pits", "Barriers"},
            Reward = {Coins = 3000, Diamonds = 3}
        },
        HardTrack = {
            Name = "Lava Canyon",
            Difficulty = 2,
            Length = 750,
            Checkpoints = 7,
            Obstacles = {"Lava", "MovingPlatforms", "WindTunnels"},
            Reward = {Coins = 8000, Diamonds = 10}
        },
        ExtremeTrack = {
            Name = "Void Path",
            Difficulty = 3,
            Length = 1000,
            Checkpoints = 10,
            Obstacles = {"Void", "ElectricGates", " collapsingBridges"},
            Reward = {Coins = 15000, Diamonds = 25}
        }
    },

    -- Race mechanics
    Mechanics = {
        FirstUnitFinishes = true, -- Race ends when first unit crosses finish
        CheckpointRespawn = true, -- Units respawn at last checkpoint
        StunOnHit = 0.5, -- Seconds stunned when hitting obstacle
        SpeedBoostZones = true
    },

    -- Rewards
    PlacementRewards = {
        [1] = {Coins = 5000, Diamonds = 10, Title = "Speed Demon"},
        [2] = {Coins = 3000, Diamonds = 5},
        [3] = {Coins = 1500, Diamonds = 2},
        [4] = {Coins = 500}
    }
}

------------------------------------------------------------------
-- HELPER FUNCTIONS
------------------------------------------------------------------

function GameModes.GetTowerDefenseMaps()
    return GameModes.TowerDefense.Maps
end

function GameModes.GetPvPArenas()
    return GameModes.PvPArena.Arenas
end

function GameModes.GetRaceTracks()
    return GameModes.RaceMode.Tracks
end

function GameModes.GetEndlessWaveInfo(waveNumber)
    for _, special in ipairs(GameModes.EndlessSurvival.SpecialWaves) do
        if special.Wave == waveNumber then
            return special
        end
    end
    return nil
end

function GameModes.CalculateEndlessDifficulty(wave)
    local scale = math.pow(GameModes.EndlessSurvival.Scaling.WaveMultiplier, wave - 1)
    return {
        HealthMultiplier = scale * GameModes.EndlessSurvival.Scaling.EnemyHealthScale,
        DamageMultiplier = scale * GameModes.EndlessSurvival.Scaling.EnemyDamageScale,
        SpeedMultiplier = scale * GameModes.EndlessSurvival.Scaling.EnemySpeedScale
    }
end

function GameModes.GetPvPScoreBreakdown()
    return GameModes.PvPArena.Scoring
end

return GameModes
