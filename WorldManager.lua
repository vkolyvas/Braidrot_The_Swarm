--[[
    WorldManager ModuleScript
    Handles world progression and unlock system
    Place in ReplicatedStorage > WorldManager
]]

local WorldManager = {}

-- World definitions
WorldManager.Worlds = {
    {
        Id = "IceWorld",
        Name = "Ice World",
        Order = 1,
        RequiredRebirths = 0,
        Hazards = {"Slippery", "Spike"},
        Color = Color3.fromRGB(173, 216, 230),
        BackgroundColor = Color3.fromRGB(240, 248, 255),
        SpawnPoint = Vector3.new(0, 10, 0),
        Checkpoints = {
            {Position = Vector3.new(0, 10, 50), Reward = 100},
            {Position = Vector3.new(0, 10, 100), Reward = 250},
            {Position = Vector3.new(0, 10, 150), Reward = 500},
            {Position = Vector3.new(0, 10, 200), Reward = 1000}
        },
        CompletionReward = 2000
    },
    {
        Id = "LavaWorld",
        Name = "Lava World",
        Order = 2,
        RequiredRebirths = 1,
        Hazards = {"Lava", "Fire"},
        Color = Color3.fromRGB(255, 69, 0),
        BackgroundColor = Color3.fromRGB(139, 0, 0),
        SpawnPoint = Vector3.new(0, 10, 0),
        Checkpoints = {
            {Position = Vector3.new(0, 10, 50), Reward = 500},
            {Position = Vector3.new(0, 10, 100), Reward = 1000},
            {Position = Vector3.new(0, 10, 150), Reward = 2500},
            {Position = Vector3.new(0, 10, 200), Reward = 5000}
        },
        CompletionReward = 10000
    },
    {
        Id = "AcidWorld",
        Name = "Acid World",
        Order = 3,
        RequiredRebirths = 2,
        Hazards = {"Acid", "Spike"},
        Color = Color3.fromRGB(0, 255, 0),
        BackgroundColor = Color3.fromRGB(0, 100, 0),
        SpawnPoint = Vector3.new(0, 10, 0),
        Checkpoints = {
            {Position = Vector3.new(0, 10, 50), Reward = 1000},
            {Position = Vector3.new(0, 10, 100), Reward = 2500},
            {Position = Vector3.new(0, 10, 150), Reward = 5000},
            {Position = Vector3.new(0, 10, 200), Reward = 10000}
        },
        CompletionReward = 25000
    },
    {
        Id = "FireWorld",
        Name = "Fire World",
        Order = 4,
        RequiredRebirths = 3,
        Hazards = {"Fire", "Void"},
        Color = Color3.fromRGB(255, 140, 0),
        BackgroundColor = Color3.fromRGB(80, 0, 0),
        SpawnPoint = Vector3.new(0, 10, 0),
        Checkpoints = {
            {Position = Vector3.new(0, 10, 50), Reward = 2500},
            {Position = Vector3.new(0, 10, 100), Reward = 5000},
            {Position = Vector3.new(0, 10, 150), Reward = 10000},
            {Position = Vector3.new(0, 10, 200), Reward = 25000}
        },
        CompletionReward = 50000
    },
    {
        Id = "WaterWorld",
        Name = "Water World",
        Order = 5,
        RequiredRebirths = 5,
        Hazards = {"Water", "Electric"},
        Color = Color3.fromRGB(30, 144, 255),
        BackgroundColor = Color3.fromRGB(0, 0, 139),
        SpawnPoint = Vector3.new(0, 10, 0),
        Checkpoints = {
            {Position = Vector3.new(0, 10, 50), Reward = 5000},
            {Position = Vector3.new(0, 10, 100), Reward = 10000},
            {Position = Vector3.new(0, 10, 150), Reward = 25000},
            {Position = Vector3.new(0, 10, 200), Reward = 50000}
        },
        CompletionReward = 100000
    },
    {
        Id = "WindWorld",
        Name = "Wind World",
        Order = 6,
        RequiredRebirths = 7,
        Hazards = {"Wind", "Spike"},
        Color = Color3.fromRGB(192, 192, 192),
        BackgroundColor = Color3.fromRGB(105, 105, 105),
        SpawnPoint = Vector3.new(0, 10, 0),
        Checkpoints = {
            {Position = Vector3.new(0, 10, 50), Reward = 10000},
            {Position = Vector3.new(0, 10, 100), Reward = 25000},
            {Position = Vector3.new(0, 10, 150), Reward = 50000},
            {Position = Vector3.new(0, 10, 200), Reward = 100000}
        },
        CompletionReward = 250000
    },
    {
        Id = "ElectricWorld",
        Name = "Electric World",
        Order = 7,
        RequiredRebirths = 10,
        Hazards = {"Electric", "Void"},
        Color = Color3.fromRGB(255, 255, 0),
        BackgroundColor = Color3.fromRGB(47, 79, 79),
        SpawnPoint = Vector3.new(0, 10, 0),
        Checkpoints = {
            {Position = Vector3.new(0, 10, 50), Reward = 25000},
            {Position = Vector3.new(0, 10, 100), Reward = 50000},
            {Position = Vector3.new(0, 10, 150), Reward = 100000},
            {Position = Vector3.new(0, 10, 200), Reward = 250000}
        },
        CompletionReward = 500000
    },
    {
        Id = "DiamondUniverse",
        Name = "Diamond Universe",
        Order = 8,
        RequiredRebirths = 15,
        Hazards = {"Lava", "Acid", "Fire", "Electric", "Void"},
        Color = Color3.fromRGB(0, 215, 255),
        BackgroundColor = Color3.fromRGB(25, 25, 112),
        SpawnPoint = Vector3.new(0, 10, 0),
        Checkpoints = {
            {Position = Vector3.new(0, 10, 50), Reward = 50000},
            {Position = Vector3.new(0, 10, 100), Reward = 100000},
            {Position = Vector3.new(0, 10, 150), Reward = 250000},
            {Position = Vector3.new(0, 10, 200), Reward = 500000}
        },
        CompletionReward = 1000000
    }
}

-- Create player world data
function WorldManager.CreatePlayerWorldData()
    return {
        CurrentWorld = "IceWorld",
        CompletedWorlds = {},
        CheckpointsReached = {},
        BestTimes = {},
        Attempts = {}
    }
end

-- Get world by ID
function WorldManager.GetWorld(worldId)
    for _, world in ipairs(WorldManager.Worlds) do
        if world.Id == worldId then
            return world
        end
    end
    return nil
end

-- Check if world is unlocked
function WorldManager.IsWorldUnlocked(worldId, rebirthCount)
    local world = WorldManager.GetWorld(worldId)
    if not world then
        return false
    end
    return rebirthCount >= world.RequiredRebirths
end

-- Get available worlds for player
function WorldManager.GetAvailableWorlds(rebirthCount)
    local available = {}
    for _, world in ipairs(WorldManager.Worlds) do
        if world.RequiredRebirths <= rebirthCount then
            table.insert(available, world)
        end
    end
    return available
end

-- Get next world
function WorldManager.GetNextWorld(currentWorldId)
    local current = WorldManager.GetWorld(currentWorldId)
    if not current then
        return nil
    end

    return WorldManager.GetWorldByOrder(current.Order + 1)
end

-- Get world by order
function WorldManager.GetWorldByOrder(order)
    for _, world in ipairs(WorldManager.Worlds) do
        if world.Order == order then
            return world
        end
    end
    return nil
end

-- Complete checkpoint
function WorldManager.CompleteCheckpoint(worldId, checkpointIndex, playerData)
    local world = WorldManager.GetWorld(worldId)
    if not world or not world.Checkpoints[checkpointIndex] then
        return nil
    end

    local checkpointKey = worldId .. "_" .. checkpointIndex
    if playerData.CheckpointsReached[checkpointKey] then
        return nil -- Already completed
    end

    playerData.CheckpointsReached[checkpointKey] = true
    return world.Checkpoints[checkpointIndex].Reward
end

-- Complete world
function WorldManager.CompleteWorld(worldId, playerData)
    local world = WorldManager.GetWorld(worldId)
    if not world then
        return nil
    end

    -- Check if already completed
    for _, completed in ipairs(playerData.CompletedWorlds) do
        if completed == worldId then
            return nil
        end
    end

    table.insert(playerData.CompletedWorlds, worldId)
    return world.CompletionReward
end

-- Get world progress
function WorldManager.GetWorldProgress(worldId, playerData)
    local checkpoints = {}
    for i = 1, 4 do
        local checkpointKey = worldId .. "_" .. i
        checkpoints[i] = playerData.CheckpointsReached[checkpointKey] or false
    end

    local isCompleted = false
    for _, completed in ipairs(playerData.CompletedWorlds) do
        if completed == worldId then
            isCompleted = true
            break
        end
    end

    return {
        WorldId = worldId,
        Checkpoints = checkpoints,
        IsCompleted = isCompleted
    }
end

-- Get all worlds (for world select UI)
function WorldManager.GetAllWorlds()
    return WorldManager.Worlds
end

return WorldManager
