--[[
    MainServerScript
    Central hub that connects all game systems
    Place in ServerScriptService > MainServerScript
]]

--!silence
local MainServerScript = {}
MainServerScript.__index = MainServerScript

------------------------------------------------------------------
-- MODULE REFERENCES
------------------------------------------------------------------

local BraidrotData
local BraidrotCreatureSystem
local EconomyManager
local EggSystem
local UpgradeSystem
local SpeedBoost
local HazardSystem
local RebirthSystem
local BossSystem
local LeaderboardSystem
local WorldManager
local Cosmetics
local SocialSystem
local ProgressionSystem
local EventSystem
local EconomyExtras

------------------------------------------------------------------
-- PLAYER DATA MANAGEMENT
------------------------------------------------------------------

local PlayerDataStore = {}

function MainServerScript:GetPlayerData(player)
    if not PlayerDataStore[player.UserId] then
        PlayerDataStore[player.UserId] = self:CreateNewPlayerData(player)
    end
    return PlayerDataStore[player.UserId]
end

function MainServerScript:CreateNewPlayerData(player)
    return {
        -- Identity
        UserId = player.UserId,
        Username = player.Name,
        JoinedAt = os.time(),

        -- Currency
        Coins = 100,
        Diamonds = 0,
        Robux = 0,
        Energy = 100,
        RebirthPoints = 0,

        -- Braidrots (Collectibles)
        Braidrots = {},
        SelectedBraidrot = nil,

        -- Swarm Units
        SwarmUnits = {
            Rotlet = 0,
            Bulker = 0,
            Spitter = 0,
            Runner = 0,
            Colossus = 0
        },

        -- Mother-Knot
        MotherKnotLevel = 1,
        MotherKnotXP = 0,

        -- Progression
        Level = 1,
        XP = 0,
        SpeedLevel = 1,
        CurrentMultiplier = 1.0,

        -- World Progress
        CurrentWorld = "IceWorld",
        UnlockedWorlds = {"IceWorld"},
        CompletedWorlds = {},
        CheckpointsReached = {},

        -- Rebirth
        RebirthCount = 0,
        TotalRebirthPoints = 0,
        CoinMultiplier = 1.0,

        -- Premium
        IsVIP = false,
        IsPremium = false,
        SeasonPassPremium = false,

        -- Cosmetics
        UnlockedCosmetics = {
            Hats = {"hat_crown"},
            Skins = {"skin_default"},
            Trails = {"trail_none"},
            Animations = {"anim_idle"}
        },
        Equipped = {
            Hat = nil,
            Skin = "skin_default",
            Trail = "trail_none",
            Animation = "anim_idle"
        },

        -- Pets
        Pets = {},

        -- Achievements
        UnlockedAchievements = {},

        -- Daily
        DailyQuests = {},
        DailyStreak = 0,
        LastDailyClaim = 0,
        LastQuestRefresh = 0,

        -- Stats
        Stats = {
            TotalCoinsEarned = 0,
            TotalDiamondsEarned = 0,
            EnemiesKilled = 0,
            BattlesWon = 0,
            BossesDefeated = 0,
            UniqueBraidrots = 0,
            TimePlayed = 0
        },

        -- Settings
        Settings = {
            MusicVolume = 1.0,
            SFXVolume = 1.0,
            GraphicsQuality = "Auto",
            Notifications = true
        },

        -- State
        IsGodMode = false,
        HazardImmunity = false,
        IsInGame = false,
        LastActive = os.time()
    }
end

------------------------------------------------------------------
-- ECONOMY FUNCTIONS
------------------------------------------------------------------

function MainServerScript:AddCoins(player, amount)
    local data = self:GetPlayerData(player)
    local actual = EconomyManager.AddCoins(data, amount)
    self:UpdatePlayerUI(player, "Coins", data.Coins)
    return actual
end

function MainServerScript:SpendCoins(player, amount)
    local data = self:GetPlayerData(player)
    return EconomyManager.SpendCoins(data, amount)
end

function MainServerScript:AddDiamonds(player, amount)
    local data = self:GetPlayerData(player)
    local actual = EconomyManager.AddDiamonds(data, amount)
    self:UpdatePlayerUI(player, "Diamonds", data.Diamonds)
    return actual
end

function MainServerScript:SpendDiamonds(player, amount)
    local data = self:GetPlayerData(player)
    return EconomyManager.SpendDiamonds(data, amount)
end

------------------------------------------------------------------
-- BRAIDROT FUNCTIONS
------------------------------------------------------------------

function MainServerScript:SpawnBraidrot(player, braidrotName, level)
    level = level or 1

    local newBraidrot = BraidrotData.CreateBraidrot(braidrotName)
    if not newBraidrot then return nil end

    newBraidrot.Level = level
    local data = self:GetPlayerData(player)
    table.insert(data.Braidrots, newBraidrot)

    self:UpdatePlayerUI(player, "BraidrotCount", #data.Braidrots)
    self:FireRemoteEvent(player, "BraidrotSpawned", newBraidrot)

    return newBraidrot
end

function MainServerScript:GetCoinsPerSecond(player)
    local data = self:GetPlayerData(player)
    return EconomyManager.CalculateCoinsPerSecond(data.Braidrots)
end

------------------------------------------------------------------
-- EGG FUNCTIONS
------------------------------------------------------------------

function MainServerScript:PurchaseEgg(player, eggName)
    local egg = EggSystem.GetEgg(eggName)
    if not egg then return false, "Invalid egg" end

    local data = self:GetPlayerData(player)

    -- Check currency
    if egg.Currency == "Coins" then
        if not self:SpendCoins(player, egg.Price) then
            return false, "Not enough coins"
        end
    elseif egg.Currency == "Diamonds" then
        if not self:SpendDiamonds(player, egg.Price) then
            return false, "Not enough diamonds"
        end
    elseif egg.Currency == "Robux" then
        -- Handle Robux through gamepass/purchase
        return false, "Robux purchase not implemented"
    end

    -- Hatch the egg
    local luckMultiplier = data.Stats.LuckMultiplier or 1.0
    local hatchedBraidrot = EggSystem.HatchEgg(eggName, luckMultiplier)

    -- Add to player collection
    self:SpawnBraidrot(player, hatchedBraidrot, 1)

    self:FireRemoteEvent(player, "EggHatched", {
        Egg = eggName,
        Braidrot = hatchedBraidrot
    })

    return true, hatchedBraidrot
end

------------------------------------------------------------------
-- UPGRADE FUNCTIONS
------------------------------------------------------------------

function MainServerScript:UpgradeBraidrot(player, braidrotIndex)
    local data = self:GetPlayerData(player)
    local braidrot = data.Braidrots[braidrotIndex]

    if not braidrot then return false, "Braidrot not found" end

    local cost = UpgradeSystem.GetUpgradeCost(braidrot)

    if not self:SpendCoins(player, cost) then
        return false, "Not enough coins"
    end

    local success, newLevel = UpgradeSystem.UpgradeBraidrot(braidrot, 0)
    if success then
        self:FireRemoteEvent(player, "BraidrotUpgraded", {
            Index = braidrotIndex,
            NewLevel = newLevel
        })
    end

    return success, newLevel
end

function MainServerScript:UpgradeSpeed(player)
    local data = self:GetPlayerData(player)
    local success, result = SpeedBoost.UpgradeSpeed(data, data.Coins)

    if success then
        self:UpdatePlayerUI(player, "SpeedLevel", data.SpeedLevel)
        self:UpdatePlayerUI(player, "SpeedMultiplier", data.CurrentMultiplier)
    end

    return success, result
end

------------------------------------------------------------------
-- SWARM FUNCTIONS
------------------------------------------------------------------

function MainServerScript:UpgradeMotherKnot(player)
    local data = self:GetPlayerData(player)
    local currentLevel = data.MotherKnotLevel
    local upgrade = BraidrotCreatureSystem.GetMotherKnotUpgrade(currentLevel)

    if not upgrade then return false, "Max level" end

    if not self:SpendCoins(player, upgrade.Cost) then
        return false, "Not enough coins"
    end

    data.MotherKnotLevel = currentLevel + 1
    self:FireRemoteEvent(player, "MotherKnotUpgraded", data.MotherKnotLevel)

    return true, data.MotherKnotLevel
end

function MainServerScript:EvoleUnit(player, unitType, targetUnit)
    local data = self:GetPlayerData(player)
    local unit = BraidrotCreatureSystem.GetUnit(targetUnit)

    if not unit then return false, "Invalid unit" end
    if data.SwarmUnits[unitType] < 10 then return false, "Not enough units" end

    -- Spend 10 base units
    data.SwarmUnits[unitType] = data.SwarmUnits[unitType] - 10
    data.SwarmUnits[targetUnit] = (data.SwarmUnits[targetUnit] or 0) + 1

    self:FireRemoteEvent(player, "UnitEvolved", {
        From = unitType,
        To = targetUnit
    })

    return true, targetUnit
end

------------------------------------------------------------------
-- WORLD FUNCTIONS
------------------------------------------------------------------

function MainServerScript:TeleportToWorld(player, worldName)
    local data = self:GetPlayerData(player)
    local world = WorldManager.GetWorld(worldName)

    if not world then return false, "World not found" end

    if not WorldManager.IsWorldUnlocked(worldName, data.TotalRebirthPoints) then
        return false, "World not unlocked"
    end

    data.CurrentWorld = worldName

    -- Teleport player
    player.Character:PivotTo(CFrame.new(world.SpawnPoint))

    self:FireRemoteEvent(player, "WorldChanged", worldName)

    return true, worldName
end

function MainServerScript:CompleteCheckpoint(player, worldId, checkpointIndex)
    local data = self:GetPlayerData(player)
    local reward = WorldManager.CompleteCheckpoint(worldId, checkpointIndex, data)

    if reward then
        self:AddCoins(player, reward)
        self:FireRemoteEvent(player, "CheckpointCompleted", {
            World = worldId,
            Checkpoint = checkpointIndex,
            Reward = reward
        })
    end

    return reward
end

function MainServerScript:CompleteWorld(player, worldId)
    local data = self:GetPlayerData(player)
    local reward = WorldManager.CompleteWorld(worldId, data)

    if reward then
        self:AddCoins(player, reward)

        -- Check for next world unlock
        local nextWorld = WorldManager.GetNextWorld(worldId)
        if nextWorld then
            table.insert(data.UnlockedWorlds, nextWorld.Id)
        end

        self:FireRemoteEvent(player, "WorldCompleted", {
            World = worldId,
            Reward = reward
        })
    end

    return reward
end

------------------------------------------------------------------
-- REBIRTH FUNCTIONS
------------------------------------------------------------------

function MainServerScript:DoRebirth(player)
    local data = self:GetPlayerData(player)
    local success, result = RebirthSystem.Rebirth(data)

    if success then
        self:FireRemoteEvent(player, "RebirthComplete", result)
        self:UpdatePlayerUI(player, "RebirthPoints", data.TotalRebirthPoints)
        self:UpdatePlayerUI(player, "CoinMultiplier", data.CoinMultiplier)
    end

    return success, result
end

------------------------------------------------------------------
-- BOSS FUNCTIONS
------------------------------------------------------------------

function MainServerScript:SpawnBoss(player, bossName)
    local position = player.Character and player.Character.Position or Vector3.new(0, 50, 0)
    return BossSystem.SpawnBoss(bossName, position)
end

function MainServerScript:DamageBoss(player, damage)
    return BossSystem.DamageBoss(player, damage)
end

------------------------------------------------------------------
-- REMOTE EVENT HANDLERS
------------------------------------------------------------------

function MainServerScript:SetupRemoteHandlers(player)
    local remoteFuncs = player:WaitForChild("RemoteFunction", 10)

    -- Currency
    remoteFuncs.GetCoins.OnServerInvoke = function()
        return self:GetPlayerData(player).Coins
    end

    remoteFuncs.GetDiamonds.OnServerInvoke = function()
        return self:GetPlayerData(player).Diamonds
    end

    -- Braidrots
    remoteFuncs.GetBraidrots.OnServerInvoke = function()
        return self:GetPlayerData(player).Braidrots
    end

    remoteFuncs.GetCoinsPerSecond.OnServerInvoke = function()
        return self:GetCoinsPerSecond(player)
    end

    -- Eggs
    remoteFuncs.GetEggs.OnServerInvoke = function()
        return EggSystem.GetAllEggs()
    end

    remoteFuncs.PurchaseEgg.OnServerInvoke = function(_, eggName)
        return self:PurchaseEgg(player, eggName)
    end

    -- Upgrades
    remoteFuncs.UpgradeBraidrot.OnServerInvoke = function(_, index)
        return self:UpgradeBraidrot(player, index)
    end

    remoteFuncs.UpgradeSpeed.OnServerInvoke = function()
        return self:UpgradeSpeed(player)
    end

    -- Worlds
    remoteFuncs.GetWorlds.OnServerInvoke = function()
        local data = self:GetPlayerData(player)
        return WorldManager.GetAvailableWorlds(data.TotalRebirthPoints)
    end

    remoteFuncs.TeleportToWorld.OnServerInvoke = function(_, worldName)
        return self:TeleportToWorld(player, worldName)
    end

    -- Progression
    remoteFuncs.GetRebirthInfo.OnServerInvoke = function()
        local data = self:GetPlayerData(player)
        return RebirthSystem.GetNextRebirthInfo(data)
    end

    remoteFuncs.DoRebirth.OnServerInvoke = function()
        return self:DoRebirth(player)
    end

    -- Settings
    remoteFuncs.GetSettings.OnServerInvoke = function()
        return self:GetPlayerData(player).Settings
    end

    remoteFuncs.UpdateSettings.OnServerInvoke = function(_, settings)
        local data = self:GetPlayerData(player)
        for k, v in pairs(settings) do
            data.Settings[k] = v
        end
        return true
    end
end

------------------------------------------------------------------
-- GAME LOOP
------------------------------------------------------------------

function MainServerScript:StartCoinGeneration()
    -- Generate coins every second based on Braidrots
    task.spawn(function()
        while true do
            task.wait(1)

            for userId, data in pairs(PlayerDataStore) do
                local player = game.Players:GetPlayerByUserId(userId)
                if player and player.Character and data.IsInGame then
                    local cps = EconomyManager.CalculateCoinsPerSecond(data.Braidrots)
                    local speedBoost = data.CurrentMultiplier or 1.0
                    local total = math.floor(cps * speedBoost)

                    if total > 0 then
                        self:AddCoins(player, total)
                    end
                end
            end
        end
    end)
end

function MainServerScript:StartPassiveSpawning()
    -- Passive spawning for Mother-Knot
    task.spawn(function()
        while true do
            task.wait(10)

            for userId, data in pairs(PlayerDataStore) do
                if data.MotherKnotLevel > 0 then
                    local spawnRate = {10, 8, 6, 4, 2}
                    local rate = spawnRate[math.min(data.MotherKnotLevel, #spawnRate)] or 10

                    -- Only spawn if waiting enough time
                    if data.MotherKnotXP >= rate then
                        data.SwarmUnits.Rotlet = (data.SwarmUnits.Rotlet or 0) + 1
                        data.MotherKnotXP = 0
                    else
                        data.MotherKnotXP = data.MotherKnotXP + 1
                    end
                end
            end
        end
    end)
end

function MainServerScript:StartBossSpawning()
    -- Auto-spawn bosses periodically
    task.spawn(function()
        while true do
            task.wait(600) -- Every 10 minutes

            -- Only spawn if players are online
            local players = game.Players:GetPlayers()
            if #players > 0 then
                -- Random chance to spawn boss in current world
                local data = self:GetPlayerData(players[1])
                local worldBosses = BossSystem.GetWorldBosses(data.CurrentWorld)

                if #worldBosses > 0 then
                    local boss = worldBosses[math.random(#worldBosses)]
                    BossSystem.SpawnBoss(boss.Name, Vector3.new(0, 100, 0))

                    -- Notify all players
                    for _, p in ipairs(players) do
                        self:FireRemoteEvent(p, "BossSpawned", boss.Name)
                    end
                end
            end
        end
    end)
end

------------------------------------------------------------------
-- PLAYER EVENTS
------------------------------------------------------------------

function MainServerScript:OnPlayerJoined(player)
    print("[Game] Player joined: " .. player.Name)

    -- Create player data
    local data = self:GetPlayerData(player)
    data.IsInGame = true
    data.LastActive = os.time()

    -- Give starter Braidrot
    if #data.Braidrots == 0 then
        self:SpawnBraidrot(player, "Rap-Rap-Rap", 1)
    end

    -- Give starter Rotlet
    if data.SwarmUnits.Rotlet == 0 then
        data.SwarmUnits.Rotlet = 3
    end

    -- Setup remote handlers
    self:SetupRemoteHandlers(player)

    -- Send initial data to client
    self:FireRemoteEvent(player, "PlayerDataLoaded", {
        Coins = data.Coins,
        Diamonds = data.Diamonds,
        Braidrots = data.Braidrots,
        SwarmUnits = data.SwarmUnits,
        UnlockedWorlds = data.UnlockedWorlds,
        CurrentWorld = data.CurrentWorld,
        Level = data.Level,
        SpeedLevel = data.SpeedLevel
    })

    print("[Game] Setup complete for: " .. player.Name)
end

function MainServerScript:OnPlayerLeaving(player)
    print("[Game] Player leaving: " .. player.Name)

    local data = self:GetPlayerData(player)
    if data then
        data.IsInGame = false
        data.LastActive = os.time()

        -- Save data to DataStore (implement persistence)
        -- self:SavePlayerData(player, data)
    end
end

------------------------------------------------------------------
-- UI HELPERS
------------------------------------------------------------------

function MainServerScript:FireRemoteEvent(player, eventName, data)
    -- Implementation depends on your RemoteEvent setup
    -- local event = game.ReplicatedStorage:FindFirstChild(eventName)
    -- if event then
    --     event:FireClient(player, data)
    -- end
    -- For now, just log
    -- print("[Remote] " .. eventName .. " to " .. player.Name)
end

function MainServerScript:UpdatePlayerUI(player, property, value)
    -- Update player GUI
    -- Implementation depends on your UI system
end

------------------------------------------------------------------
-- INITIALIZATION
------------------------------------------------------------------

function MainServerScript:Initialize()
    print("========================================")
    print("  Braidrot The Swarm - Server Starting")
    print("========================================")

    -- Load modules
    pcall(function()
        BraidrotData = require(game.ReplicatedStorage.BraidrotData)
        BraidrotCreatureSystem = require(game.ReplicatedStorage.BraidrotCreatureSystem)
        EconomyManager = require(game.ReplicatedStorage.EconomyManager)
        EggSystem = require(game.ReplicatedStorage.EggSystem)
        UpgradeSystem = require(game.ReplicatedStorage.UpgradeSystem)
        SpeedBoost = require(game.ReplicatedStorage.SpeedBoost)
        HazardSystem = require(game.ReplicatedStorage.HazardSystem)
        RebirthSystem = require(game.ReplicatedStorage.RebirthSystem)
        BossSystem = require(game.ReplicatedStorage.BossSystem)
        LeaderboardSystem = require(game.ReplicatedStorage.LeaderboardSystem)
        WorldManager = require(game.ReplicatedStorage.WorldManager)
        Cosmetics = require(game.ReplicatedStorage.Cosmetics)
        SocialSystem = require(game.ReplicatedStorage.SocialSystem)
        ProgressionSystem = require(game.ReplicatedStorage.ProgressionSystem)
        EventSystem = require(game.ReplicatedStorage.EventSystem)
        EconomyExtras = require(game.ReplicatedStorage.EconomyExtras)

        print("[Init] All modules loaded successfully!")
    end)

    -- Connect events
    game.Players.PlayerAdded:Connect(function(player)
        self:OnPlayerJoined(player)
    end)

    game.Players.PlayerRemoving:Connect(function(player)
        self:OnPlayerLeaving(player)
    end)

    -- Start game loops
    self:StartCoinGeneration()
    self:StartPassiveSpawning()
    self:StartBossSpawning()

    print("[Game] Server initialized and ready!")
    print("========================================")
end

------------------------------------------------------------------
-- START
------------------------------------------------------------------

-- Wait for ReplicatedStorage to be ready
task.wait(2)

-- Create and start the main server
local gameServer = setmetatable({}, MainServerScript)
gameServer:Initialize()

return gameServer
