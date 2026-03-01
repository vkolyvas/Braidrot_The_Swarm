--[[
    BossSystem ModuleScript
    Handles boss spawns and challenge events
    Place in ReplicatedStorage > BossSystem
]]

local BossSystem = {}

-- Boss definitions
BossSystem.Bosses = {
    IceGiant = {
        Name = "Ice Giant",
        World = "IceWorld",
        Health = 50000,
        MaxHealth = 50000,
        Damage = 100,
        AttackSpeed = 2,
        Drops = {
            {Item = "Flying Fish", Chance = 0.3},
            {Item = "Orca Shoes", Chance = 0.1},
            {Item = "Diamonds", Amount = 10, Chance = 0.5}
        },
        Weakness = "Fire",
        Color = Color3.fromRGB(176, 224, 230)
    },
    LavaTitan = {
        Name = "Lava Titan",
        World = "LavaWorld",
        Health = 100000,
        MaxHealth = 100000,
        Damage = 200,
        AttackSpeed = 1.5,
        Drops = {
            {Item = "Jerry", Chance = 0.2},
            {Item = "Gun with Cucumber", Chance = 0.15},
            {Item = "Diamonds", Amount = 25, Chance = 0.6}
        },
        Weakness = "Water",
        Color = Color3.fromRGB(255, 69, 0)
    },
    AcidQueen = {
        Name = "Acid Queen",
        World = "AcidWorld",
        Health = 150000,
        MaxHealth = 150000,
        Damage = 300,
        AttackSpeed = 1,
        Drops = {
            {Item = "Bear with Macaroni", Chance = 0.25},
            {Item = "Shoe with Head", Chance = 0.15},
            {Item = "Diamonds", Amount = 50, Chance = 0.7}
        },
        Weakness = "Ice",
        Color = Color3.fromRGB(50, 205, 50)
    },
    FireDragon = {
        Name = "Fire Dragon",
        World = "FireWorld",
        Health = 250000,
        MaxHealth = 250000,
        Damage = 400,
        AttackSpeed = 1,
        Drops = {
            {Item = "Family with Brairos", Chance = 0.1},
            {Item = "CelestialEgg", Chance = 0.2},
            {Item = "Diamonds", Amount = 100, Chance = 0.8}
        },
        Weakness = "Water",
        Color = Color3.fromRGB(255, 100, 0)
    },
    StormLord = {
        Name = "Storm Lord",
        World = "WindWorld",
        Health = 300000,
        MaxHealth = 300000,
        Damage = 350,
        AttackSpeed = 0.8,
        Drops = {
            {Item = "Shadow Braidrot", Chance = 0.05},
            {Item = "Golden Glitch", Chance = 0.02},
            {Item = "Diamonds", Amount = 150, Chance = 0.9}
        },
        Weakness = "Electric",
        Color = Color3.fromRGB(128, 128, 128)
    },
    ThunderKing = {
        Name = "Thunder King",
        World = "ElectricWorld",
        Health = 500000,
        MaxHealth = 500000,
        Damage = 500,
        AttackSpeed = 0.5,
        Drops = {
            {Item = "Dragon with Cinnamon", Chance = 0.01},
            {Item = "InfiniteEgg", Chance = 0.1},
            {Item = "Diamonds", Amount = 500, Chance = 1.0}
        },
        Weakness = "Ground",
        Color = Color3.fromRGB(255, 255, 0)
    },
    DiamondOverlord = {
        Name = "Diamond Overlord",
        World = "DiamondUniverse",
        Health = 1000000,
        MaxHealth = 1000000,
        Damage = 1000,
        AttackSpeed = 0.3,
        Drops = {
            {Item = "Dragon with Cinnamon", Chance = 0.1},
            {Item = "InfiniteEgg", Chance = 0.5},
            {Item = "Diamonds", Amount = 1000, Chance = 1.0}
        },
        Weakness = "All",
        Color = Color3.fromRGB(0, 215, 255)
    }
}

-- Boss spawn settings
BossSystem.SpawnSettings = {
    MinPlayers = 1,
    SpawnInterval = 600, -- 10 minutes
    SpawnRadius = 500,
    BossDuration = 300 -- 5 minutes
}

-- Active boss state
BossSystem.ActiveBoss = nil

-- Create boss instance
function BossSystem.SpawnBoss(bossName, position)
    local bossTemplate = BossSystem.Bosses[bossName]
    if not bossTemplate then
        return nil
    end

    BossSystem.ActiveBoss = {
        Name = bossTemplate.Name,
        World = bossTemplate.World,
        Health = bossTemplate.Health,
        MaxHealth = bossTemplate.MaxHealth,
        Damage = bossTemplate.Damage,
        AttackSpeed = bossTemplate.AttackSpeed,
        Drops = bossTemplate.Drops,
        Weakness = bossTemplate.Weakness,
        Color = bossTemplate.Color,
        Position = position or Vector3.new(0, 50, 0),
        SpawnTime = os.time(),
        IsActive = true,
        Attackers = {}
    }

    return BossSystem.ActiveBoss
end

-- Get boss by name
function BossSystem.GetBoss(bossName)
    return BossSystem.Bosses[bossName]
end

-- Get active boss
function BossSystem.GetActiveBoss()
    return BossSystem.ActiveBoss
end

-- Deal damage to boss
function BossSystem.DamageBoss(player, damage)
    if not BossSystem.ActiveBoss or not BossSystem.ActiveBoss.IsActive then
        return false, "No active boss"
    end

    BossSystem.ActiveBoss.Health = BossSystem.ActiveBoss.Health - damage

    -- Track attacker
    if not BossSystem.ActiveBoss.Attackers[player.UserId] then
        BossSystem.ActiveBoss.Attackers[player.UserId] = {
            Damage = 0,
            Name = player.Name
        }
    end
    BossSystem.ActiveBoss.Attackers[player.UserId].Damage =
        BossSystem.ActiveBoss.Attackers[player.UserId].Damage + damage

    -- Check if defeated
    if BossSystem.ActiveBoss.Health <= 0 then
        BossSystem.DefeatBoss()
        return true, "Defeated"
    end

    return true, {
        Health = BossSystem.ActiveBoss.Health,
        MaxHealth = BossSystem.ActiveBoss.MaxHealth,
        HealthPercent = BossSystem.ActiveBoss.Health / BossSystem.ActiveBoss.MaxHealth
    }
end

-- Boss defeated - distribute drops
function BossSystem.DefeatBoss()
    if not BossSystem.ActiveBoss then
        return
    end

    local drops = {}

    -- Calculate drops for each attacker
    for playerId, attacker in pairs(BossSystem.ActiveBoss.Attackers) do
        local playerDrops = {}

        for _, drop in ipairs(BossSystem.ActiveBoss.Drops) do
            local roll = math.random()
            if roll <= drop.Chance then
                table.insert(playerDrops, drop)
            end
        end

        drops[playerId] = playerDrops
    end

    BossSystem.ActiveBoss.IsActive = false
    BossSystem.ActiveBoss = nil

    return drops
end

-- Get bosses for a world
function BossSystem.GetWorldBosses(worldName)
    local bosses = {}
    for name, boss in pairs(BossSystem.Bosses) do
        if boss.World == worldName then
            table.insert(bosses, boss)
        end
    end
    return bosses
end

-- Get all available bosses
function BossSystem.GetAllBosses()
    return BossSystem.Bosses
end

-- Get boss spawn info for UI
function BossSystem.GetSpawnInfo()
    return {
        IsActive = BossSystem.ActiveBoss ~= nil,
        Boss = BossSystem.ActiveBoss,
        Settings = BossSystem.SpawnSettings
    }
end

return BossSystem
