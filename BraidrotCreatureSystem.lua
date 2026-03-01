--[[
    BraidrotCreatureSystem ModuleScript
    Complete creature system: Collectibles + Swarm Units + Evolution Tree
    Place in ReplicatedStorage > BraidrotCreatureSystem
]]

local BraidrotCreatureSystem = {}

------------------------------------------------------------------
-- SECTION 1: COLLECTIBLE BRAIDROTS (Original System)
------------------------------------------------------------------

BraidrotCreatureSystem.Collectibles = {
    -- BASIC (Green) - 8 Braidrots
    {
        Id = "braidrot_001",
        Name = "Rap-Rap-Rap",
        Class = "Basic",
        Rarity = "Basic",
        BaseCoinsPerSecond = 10,
        BaseSpeed = 1.0,
        SpecialAbility = nil,
        Image = "Rap-Rap-Rap-Sagour.png",
        Description = "A rhythmic tapping Braidrot that bounces along"
    },
    {
        Id = "braidrot_002",
        Name = "Sagur",
        Class = "Basic",
        Rarity = "Basic",
        BaseCoinsPerSecond = 12,
        BaseSpeed = 1.1,
        SpecialAbility = nil,
        Image = "Rap-Rap-Rap-Sagour.png",
        Description = "A sleepy, happy Braidrot that drools coins"
    },
    {
        Id = "braidrot_003",
        Name = "Monkey Banana",
        Class = "Basic",
        Rarity = "Basic",
        BaseCoinsPerSecond = 15,
        BaseSpeed = 1.2,
        SpecialAbility = nil,
        Image = "Monkey_Banana.png",
        Description = "Loves bananas and throws them for coins"
    },
    {
        Id = "braidrot_004",
        Name = "Shark Shoes",
        Class = "Basic",
        Rarity = "Basic",
        BaseCoinsPerSecond = 14,
        BaseSpeed = 1.3,
        SpecialAbility = nil,
        Image = "Shark_Shoes.png",
        Description = "Swims through coins like a shark"
    },
    {
        Id = "braidrot_005",
        Name = "Frame Mouth",
        Class = "Basic",
        Rarity = "Basic",
        BaseCoinsPerSecond = 13,
        BaseSpeed = 1.0,
        SpecialAbility = nil,
        Image = "Frame_Mouth.png",
        Description = "Has a picture frame for a mouth"
    },
    {
        Id = "braidrot_006",
        Name = "Light Eyes",
        Class = "Basic",
        Rarity = "Basic",
        BaseCoinsPerSecond = 11,
        BaseSpeed = 1.15,
        SpecialAbility = nil,
        Image = "Light_Eyes.png",
        Description = "Eyes that shine like lightbulbs"
    },
    {
        Id = "braidrot_007",
        Name = "Moon Teeth",
        Class = "Basic",
        Rarity = "Basic",
        BaseCoinsPerSecond = 16,
        BaseSpeed = 1.0,
        SpecialAbility = nil,
        Image = "Moon_Teeth.png",
        Description = "Teeth that glow in the dark"
    },
    {
        Id = "braidrot_008",
        Name = "Table Eyes",
        Class = "Basic",
        Rarity = "Basic",
        BaseCoinsPerSecond = 12,
        BaseSpeed = 1.1,
        SpecialAbility = nil,
        Image = "Table_Eyes.png",
        Description = "Eyes on a tiny table"
    },

    -- RARE (Blue) - 4 Braidrots
    {
        Id = "braidrot_009",
        Name = "Flying Fish",
        Class = "Rare",
        Rarity = "Rare",
        BaseCoinsPerSecond = 35,
        BaseSpeed = 1.8,
        SpecialAbility = "DoubleJump",
        Image = "Flying_Fish.png",
        Description = "Can fly short distances over hazards"
    },
    {
        Id = "braidrot_010",
        Name = "Burger Legs",
        Class = "Rare",
        Rarity = "Rare",
        BaseCoinsPerSecond = 40,
        BaseSpeed = 1.5,
        SpecialAbility = "SpeedBoost",
        Image = "Burger_Legs.png",
        Description = "Runs fast on burger-shaped legs"
    },
    {
        Id = "braidrot_011",
        Name = "Potato Tractor",
        Class = "Rare",
        Rarity = "Rare",
        BaseCoinsPerSecond = 50,
        BaseSpeed = 1.2,
        SpecialAbility = "AutoCollect",
        Image = "Potato_Tractor.png",
        Description = "Harvests coins automatically"
    },
    {
        Id = "braidrot_012",
        Name = "Orca Shoes",
        Class = "Rare",
        Rarity = "Rare",
        BaseCoinsPerSecond = 45,
        BaseSpeed = 2.0,
        SpecialAbility = "Swim",
        Image = nil, -- Use placeholder
        Description = "Swim through acid and water safely"
    },

    -- EPIC (Purple) - 4 Braidrots
    {
        Id = "braidrot_013",
        Name = "Jerry",
        Class = "Epic",
        Rarity = "Epic",
        BaseCoinsPerSecond = 100,
        BaseSpeed = 2.5,
        SpecialAbility = "PhaseThrough",
        Image = "Jerry_claw.png",
        Description = "Can phase through certain hazards"
    },
    {
        Id = "braidrot_014",
        Name = "Gun with Cucumber",
        Class = "Epic",
        Rarity = "Epic",
        BaseCoinsPerSecond = 120,
        BaseSpeed = 2.2,
        SpecialAbility = "Shield",
        Image = "bbGun_Cucumber.png",
        Description = "Shoots cucumber shields for protection"
    },
    {
        Id = "braidrot_015",
        Name = "Bear with Macaroni",
        Class = "Epic",
        Rarity = "Epic",
        BaseCoinsPerSecond = 150,
        BaseSpeed = 2.0,
        SpecialAbility = "Grow",
        Image = "Bear_Macaroni.png",
        Description = "Can grow larger to avoid small hazards"
    },
    {
        Id = "braidrot_016",
        Name = "Shoe with Head",
        Class = "Epic",
        Rarity = "Epic",
        BaseCoinsPerSecond = 110,
        BaseSpeed = 3.0,
        SpecialAbility = "Teleport",
        Image = "Shoe_Head.png",
        Description = "Can teleport to safe platforms"
    },

    -- CELESTIAL (Star) - 1 Braidrot
    {
        Id = "braidrot_017",
        Name = "Family with Brairos",
        Class = "Celestial",
        Rarity = "Celestial",
        BaseCoinsPerSecond = 300,
        BaseSpeed = 4.0,
        SpecialAbility = "Respawn",
        Image = "Family_Braidrots.png",
        Description = "The legendary family that found Brairos"
    },

    -- SECRET (Hidden) - 2 Braidrots
    {
        Id = "braidrot_018",
        Name = "Shadow Braidrot",
        Class = "Secret",
        Rarity = "Secret",
        BaseCoinsPerSecond = 500,
        BaseSpeed = 3.5,
        SpecialAbility = "Invisibility",
        Image = "Secret_ghosts.png",
        Description = "A mysterious hidden Braidrot"
    },
    {
        Id = "braidrot_019",
        Name = "Golden Glitch",
        Class = "Secret",
        Rarity = "Secret",
        BaseCoinsPerSecond = 750,
        BaseSpeed = 5.0,
        SpecialAbility = "Glitch",
        Image = nil,
        Description = "Exists outside normal game rules"
    },

    -- INFINITE (Fire) - Ultimate
    {
        Id = "braidrot_020",
        Name = "Dragon with Cinnamon",
        Class = "Infinite",
        Rarity = "Infinite",
        BaseCoinsPerSecond = 2000,
        BaseSpeed = 6.0,
        SpecialAbility = "Immunity",
        Image = "Dragon_Cinnamon.png",
        Description = "The ultimate Braidrot - immune to all hazards"
    }
}

------------------------------------------------------------------
-- SECTION 2: SWARM CREATURE SYSTEM (Mother-Knot & Rotlets)
------------------------------------------------------------------

-- Mother-Knot (Main Spawner)
BraidrotCreatureSystem.MotherKnot = {
    Id = "mother_knot",
    Name = "Mother the Knot",
    Type = "Spawner",
    Image = "Boss_Mother_the_knot.png",
    Description = "The main spawner - a glowing pulsating mass of Braidrot roots",

    -- Spawning Stats
    MaxUnits = 10,
    PassiveSpawnTime = 10, -- seconds
    PassiveSpawnAmount = {1, 2}, -- min, max

    -- Resource Costs
    SporeBurstCost = 25, -- Energy cost for Q ability
    SporeBurstAmount = 5, -- Units spawned per burst

    -- Upgrades
    Upgrades = {
        {
            Level = 1,
            Name = "Root Expansion",
            MaxUnits = 15,
            PassiveSpawnTime = 8,
            Cost = 1000
        },
        {
            Level = 2,
            Name = "Dense Thicket",
            MaxUnits = 20,
            PassiveSpawnTime = 6,
            Cost = 5000
        },
        {
            Level = 3,
            Name = "Ancient Grove",
            MaxUnits = 30,
            PassiveSpawnTime = 4,
            Cost = 25000
        },
        {
            Level = 4,
            Name = "Forest Primeval",
            MaxUnits = 50,
            PassiveSpawnTime = 2,
            Cost = 100000
        }
    }
}

-- Tier 1: Rotlet (Basic Swarm Unit)
BraidrotCreatureSystem.Units = {
    Rotlet = {
        Id = "unit_rotlet",
        Name = "Rotlet",
        Tier = 1,
        Type = "Basic",
        Image = "Boss_Rotlet.png",
        Description = "Small, fast, very low health. Attacks deal Poison DoT.",

        -- Stats
        Health = 50,
        Damage = 5,
        AttackSpeed = 1.0,
        MoveSpeed = 16,
        Range = 3,

        -- Abilities
        Abilities = {
            {
                Name = "Poison Bite",
                Type = "Passive",
                Description = "Deals damage over time",
                DamagePerTick = 2,
                Duration = 3
            }
        },

        -- Visual
        Size = Vector3.new(1, 1, 1),
        Color = Color3.fromRGB(120, 200, 100),
        ParticleEffect = "Spores"
    },

    -- Tier 2: Tank Path - Bulker
    Bulker = {
        Id = "unit_bulker",
        Name = "Bulker",
        Tier = 2,
        Type = "Tank",
        Image = "Boss_Bulker.png",
        ParentUnit = "Rotlet",
        Description = "Large, stone-bark body. Protects smaller Rotlets.",

        -- Stats
        Health = 500,
        Damage = 25,
        AttackSpeed = 0.8,
        MoveSpeed = 8,
        Range = 5,

        -- Abilities
        Abilities = {
            {
                Name = "Vine-Guard",
                Type = "Active",
                Cooldown = 15,
                Description = "Creates shield protecting nearby Rotlets",
                ShieldAmount = 200,
                Radius = 15
            },
            {
                Name = "Stomp",
                Type = "Active",
                Cooldown = 8,
                Description = "AoE attack that slows enemies",
                Damage = 50,
                Radius = 10,
                SlowDuration = 3
            }
        },

        -- Visual
        Size = Vector3.new(4, 4, 4),
        Color = Color3.fromRGB(80, 120, 60),
        ParticleEffect = "Roots"
    },

    -- Tier 2: Ranged Path - Spitter
    Spitter = {
        Id = "unit_spitter",
        Name = "Spitter",
        Tier = 2,
        Type = "Ranged",
        Image = "Boss_Spitter.png",
        ParentUnit = "Rotlet",
        Description = "Pitcher-plant back. Fires poison projectiles.",

        -- Stats
        Health = 150,
        Damage = 30,
        AttackSpeed = 1.5,
        MoveSpeed = 12,
        Range = 30,

        -- Abilities
        Abilities = {
            {
                Name = "Spore Shot",
                Type = "Passive",
                Description = "Ranged poison projectile",
                ProjectileSpeed = 40,
                Damage = 30
            },
            {
                Name = "Cloud Burst",
                Type = "Active",
                Cooldown = 12,
                Description = "Launches cloud that poisons and obscures vision",
                Radius = 15,
                Duration = 5,
                DamagePerSecond = 10
            }
        },

        -- Visual
        Size = Vector3.new(2, 3, 2),
        Color = Color3.fromRGB(150, 100, 150),
        ParticleEffect = "SporeCloud"
    },

    -- Tier 2: Mobility Path - Runner
        Id = "unit_runner",
    Runner = {
        Id = "unit_runner",
        Name = "Runner",
",
        Tier = 2,
        Type = "Mobility",
        Image = "Boss_Runner.png",
        ParentUnit = "Rotlet",
        Description = "Sleek, four-legged. Glowing bright. Fast.",

        -- Stats
        Health = 100,
        Damage = 15,
        AttackSpeed = 2.0,
        MoveSpeed = 32,
        Range = 5,

        -- Abilities
        Abilities = {
            {
                Name = "Haste Aura",
                Type = "Passive",
                Description = "Boosts movement speed of nearby Rotlets",
                Radius = 20,
                SpeedBonus = 1.5
            },
            {
                Name = "Tackle",
                Type = "Active",
                Cooldown = 5,
                Description = "Launches forward, stuns first enemy hit",
                Damage = 30,
                Knockback = 20,
                StunDuration = 1.5
            }
        },

        -- Visual
        Size = Vector3.new(1.5, 1.5, 2.5),
        Color = Color3.fromRGB(200, 255, 150),
        ParticleEffect = "Trail"
    }
}

-- Tier 3: Ultimate - Colossus
BraidrotCreatureSystem.Colossus = {
    Id = "unit_colossus",
    Name = "The Colossus",
    Tier = 3,
    Type = "Ultimate",
    Image = "Boss_The_Colossus.png",
    Description = "Building-sized ancient forest walking. Boss-level monster.",

    -- Unlock Requirements
    UnlockRequirement = {
        MinRotlets = 50,
        MinBulker = 5,
        MinSpitter = 5,
        MinRunner = 5,
        Cost = 500000
    },

    -- Stats
    Health = 10000,
    Damage = 200,
    AttackSpeed = 0.5,
    MoveSpeed = 4,
    Range = 15,

    -- Abilities
    Abilities = {
        {
            Name = "Nature's Wrath",
            Type = "Active",
            Cooldown = 10,
            Description = "Massive slam creating shockwaves of poison",
            Damage = 500,
            Radius = 30,
            Knockback = 50
        },
        {
            Name = "Grasp of the Rot",
            Type = "Active",
            Cooldown = 20,
            Description = "Throws web of roots trapping entire enemy team",
            Radius = 25,
            Duration = 5,
            DamagePerSecond = 50
        },
        {
            Name = "Rotlet Bomb",
            Type = "Active",
            Cooldown = 15,
            Description = "Launches tiny Rotlets as projectiles",
            ProjectileCount = 10,
            DamagePerRotlet = 25
        }
    },

    -- Visual
    Size = Vector3.new(30, 50, 30),
    Color = Color3.fromRGB(60, 100, 40),
    ParticleEffect = "Forest",
    Sound = "NatureRoar"
}

------------------------------------------------------------------
-- SECTION 3: EVOLUTION TREE CONFIGURATION
------------------------------------------------------------------

BraidrotCreatureSystem.EvolutionTree = {
    Tier1 = {
        Unit = "Rotlet",
        MaxCount = 50,
        UpgradePath = {
            {
                Path = "Tank",
                TargetUnit = "Bulker",
                Cost = 1000,
                Requires = {Rotlet = 10}
            },
            {
                Path = "Ranged",
                TargetUnit = "Spitter",
                Cost = 1000,
                Requires = {Rotlet = 10}
            },
            {
                Path = "Mobility",
                TargetUnit = "Runner",
                Cost = 1000,
                Requires = {Rotlet = 10}
            }
        }
    }
}

------------------------------------------------------------------
-- SECTION 4: HELPER FUNCTIONS
------------------------------------------------------------------

-- Get collectible by ID
function BraidrotCreatureSystem.GetCollectible(id)
    for _, c in ipairs(BraidrotCreatureSystem.Collectibles) do
        if c.Id == id then
            return c
        end
    end
    return nil
end

-- Get collectible by name
function BraidrotCollectibleByName(name)
    for _, c in ipairs(BraidrotCreatureSystem.Collectibles) do
        if c.Name == name then
            return c
        end
    end
    return nil
end

-- Get swarm unit by name
function BraidrotCreatureSystem.GetUnit(unitName)
    return BraidrotCreatureSystem.Units[unitName]
end

-- Get all collectibles by rarity
function BraidrotCreatureSystem.GetByRarity(rarity)
    local result = {}
    for _, c in ipairs(BraidrotCreatureSystem.Collectibles) do
        if c.Rarity == rarity then
            table.insert(result, c)
        end
    end
    return result
end

-- Get Mother-Knot upgrade info
function BraidrotCreatureSystem.GetMotherKnotUpgrade(currentLevel)
    return BraidrotCreatureSystem.MotherKnot.Upgrades[currentLevel + 1]
end

-- Calculate total swarm power
function BraidrotCreatureSystem.CalculateSwarmPower(units)
    local power = 0
    for unitName, count in pairs(units) do
        local unit = BraidrotCreatureSystem.Units[UnitName]
        if unit then
            power = power + (unit.Health + unit.Damage) * count
        end
    end
    return power
end

-- Check if can evolve to Colossus
function BraidrotCreatureSystem.CanSpawnColossus(units)
    local req = BraidrotCreatureSystem.Colossus.UnlockRequirement
    return units.Rotlet >= req.MinRotlets
        and units.Bulker >= req.MinBulker
        and units.Spitter >= req.MinSpitter
        and units.Runner >= req.MinRunner
end

return BraidrotCreatureSystem
