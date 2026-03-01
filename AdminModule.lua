--[[
    AdminModule Script
    Developer God Mode - Full control for testing and building
    Place in ServerScriptService > AdminModule

    Usage in Studio:
    local Admin = require(game.ServerScriptService.AdminModule)

    Admin:SpawnBraidrot(game.Players.vkolyvas, "Dragon with Cinnamon", 100)
    Admin:AddCoins(game.Players.vkolyvas, 999999999)
    Admin:EnableGodMode(game.Players.vkolyvas)
]]

local AdminModule = {}

------------------------------------------------------------------
-- CONFIGURATION
------------------------------------------------------------------

AdminModule.Config = {
    -- Developer user IDs (add your Roblox ID here)
    Developers = {
        [12345678] = true -- Replace with your UserId
    },

    -- Default god mode settings
    GodModeDefaults = {
        InfiniteCoins = true,
        InfiniteDiamonds = true,
        InfiniteRobux = true,
        AllBraidrotsUnlocked = true,
        AllWorldsUnlocked = true,
        AllHazardsDisabled = true,
        AllSpeedBoosts = true,
        AllVIPPerks = true,
        RebirthUnlocked = true,
        BossAccess = true,
        InfiniteEnergy = true,
        NoCooldowns = true,
        MaxUpgrades = true
    }
}

------------------------------------------------------------------
-- PLAYER DATA OVERRIDE
------------------------------------------------------------------

function AdminModule.ApplyGodMode(playerData)
    -- Currency overrides
    playerData.Coins = 999999999999
    playerData.Diamonds = 999999999
    playerData.RebirthPoints = 999999

    -- Unlock everything
    playerData.UnlockedWorlds = {
        "IceWorld", "LavaWorld", "AcidWorld", "FireWorld",
        "WaterWorld", "WindWorld", "ElectricWorld", "DiamondUniverse"
    }

    -- Max speed
    playerData.SpeedLevel = 7
    playerData.CurrentMultiplier = 10.0

    -- VIP perks
    playerData.IsVIP = true
    playerData.IsPremium = true

    -- Rebirth
    playerData.RebirthCount = 999
    playerData.TotalRebirthPoints = 999
    playerData.CoinMultiplier = 50.0

    -- Energy
    playerData.Energy = 999999

    return playerData
end

------------------------------------------------------------------
-- CORE ADMIN FUNCTIONS
------------------------------------------------------------------

-- Enable god mode for a player
function AdminModule:EnableGodMode(player)
    if not self:IsDeveloper(player) then
        warn("[Admin] " .. player.Name .. " is not authorized for god mode")
        return false
    end

    local playerData = self:GetPlayerData(player)
    if playerData then
        self:ApplyGodMode(playerData)
        self:Notify(player, "God Mode Enabled! You have unlimited resources.")
        print("[Admin] God mode enabled for " .. player.Name)
        return true
    end
    return false
end

-- Disable god mode
function AdminModule:DisableGodMode(player)
    local playerData = self:GetPlayerData(player)
    if playerData then
        playerData.Coins = 0
        playerData.Diamonds = 0
        playerData.IsGodMode = false
        self:Notify(player, "God Mode Disabled")
        return true
    end
    return false
end

------------------------------------------------------------------
-- CURRENCY FUNCTIONS
------------------------------------------------------------------

-- Add coins
function AdminModule:AddCoins(player, amount)
    local playerData = self:GetPlayerData(player)
    if playerData then
        playerData.Coins = playerData.Coins + amount
        self:Notify(player, "Added " .. self:FormatNumber(amount) .. " Coins!")
        print("[Admin] Added " .. amount .. " coins to " .. player.Name)
        return true
    end
    return false
end

-- Set coins
function AdminModule:SetCoins(player, amount)
    local playerData = self:GetPlayerData(player)
    if playerData then
        playerData.Coins = amount
        self:Notify(player, "Coins set to " .. self:FormatNumber(amount))
        return true
    end
    return false
end

-- Add diamonds
function AdminModule:AddDiamonds(player, amount)
    local playerData = self:GetPlayerData(player)
    if playerData then
        playerData.Diamonds = playerData.Diamonds + amount
        self:Notify(player, "Added " .. amount .. " Diamonds!")
        print("[Admin] Added " .. amount .. " diamonds to " .. player.Name)
        return true
    end
    return false
end

-- Set diamonds
function AdminModule:SetDiamonds(player, amount)
    local playerData = self:GetPlayerData(player)
    if playerData then
        playerData.Diamonds = amount
        self:Notify(player, "Diamonds set to " .. amount)
        return true
    end
    return false
end

-- Add rebirth points
function AdminModule:AddRebirthPoints(player, amount)
    local playerData = self:GetPlayerData(player)
    if playerData then
        playerData.RebirthPoints = playerData.RebirthPoints + amount
        playerData.TotalRebirthPoints = playerData.TotalRebirthPoints + amount
        self:Notify(player, "Added " .. amount .. " Rebirth Points!")
        return true
    end
    return false
end

------------------------------------------------------------------
-- BRAIDROT FUNCTIONS
------------------------------------------------------------------

-- Spawn a specific Braidrot
function AdminModule:SpawnBraidrot(player, braidrotName, level)
    level = level or 1

    local BraidrotData = require(game.ReplicatedStorage.BraidrotData)
    local newBraidrot = BraidrotData.CreateBraidrot(braidrotName)

    if newBraidrot then
        newBraidrot.Level = level

        local playerData = self:GetPlayerData(player)
        if playerData then
            table.insert(playerData.Braidrots, newBraidrot)
            self:Notify(player, "Spawned " .. braidrotName .. " (Level " .. level .. ")")
            print("[Admin] Spawned " .. braidrotName .. " for " .. player.Name)
            return newBraidrot
        end
    else
        self:Notify(player, "Braidrot '" .. braidrotName .. "' not found!")
    end
    return nil
end

-- Spawn all Braidrots
function AdminModule:SpawnAllBraidrots(player, level)
    level = level or 50

    local BraidrotData = require(game.ReplicatedStorage.BraidrotData)
    local allBraidrots = BraidrotData.Braidrots
    local playerData = self:GetPlayerData(player)

    if playerData then
        for _, braidrotTemplate in ipairs(allBraidrots) do
            local newBraidrot = BraidrotData.CreateBraidrot(braidrotTemplate.Name)
            newBraidrot.Level = level
            table.insert(playerData.Braidrots, newBraidrot)
        end

        self:Notify(player, "Spawned ALL Braidrots (Level " .. level .. ")!")
        print("[Admin] Spawned all Braidrots for " .. player.Name)
        return #allBraidrots
    end
    return 0
end

-- Max upgrade a Braidrot
function AdminModule:MaxUpgradeBraidrot(player, braidrotIndex)
    local playerData = self:GetPlayerData(player)
    if playerData and playerData.Braidrots[braidrotIndex] then
        local braidrot = playerData.Braidrots[braidrotIndex]
        braidrot.Level = 100
        braidrot.CoinsPerSecond = braidrot.CoinsPerSecond * 100
        self:Notify(player, "Braidrot maxed out!")
        return true
    end
    return false
end

------------------------------------------------------------------
-- WORLD FUNCTIONS
------------------------------------------------------------------

-- Unlock a specific world
function AdminModule:UnlockWorld(player, worldName)
    local playerData = self:GetPlayerData(player)
    if playerData then
        if not table.find(playerData.UnlockedWorlds, worldName) then
            table.insert(playerData.UnlockedWorlds, worldName)
        end
        self:Notify(player, "Unlocked world: " .. worldName)
        return true
    end
    return false
end

-- Unlock all worlds
function AdminModule:UnlockAllWorlds(player)
    local playerData = self:GetPlayerData(player)
    if playerData then
        playerData.UnlockedWorlds = {
            "IceWorld", "LavaWorld", "AcidWorld", "FireWorld",
            "WaterWorld", "WindWorld", "ElectricWorld", "DiamondUniverse"
        }
        self:Notify(player, "All worlds unlocked!")
        print("[Admin] All worlds unlocked for " .. player.Name)
        return true
    end
    return false
end

-- Teleport to world
function AdminModule:TeleportToWorld(player, worldName)
    local WorldManager = require(game.ReplicatedStorage.WorldManager)
    local world = WorldManager.GetWorld(worldName)

    if world then
        player.Character:PivotTo(CFrame.new(world.SpawnPoint))
        self:Notify(player, "Teleported to " .. world.Name)
        return true
    end
    return false
end

------------------------------------------------------------------
-- HAZARD FUNCTIONS
------------------------------------------------------------------

-- Enable/disable hazards
function AdminModule:EnableHazards(player, enabled)
    local playerData = self:GetPlayerData(player)
    if playerData then
        playerData.HazardsDisabled = not enabled
        self:Notify(player, "Hazards " .. (enabled and "enabled" or "disabled"))
        return true
    end
    return false
end

-- Make player immune to hazards
function AdminModule:SetHazardImmunity(player, immune)
    local playerData = self:GetPlayerData(player)
    if playerData then
        playerData.HazardImmunity = immune
        self:Notify(player, "Hazard immunity: " .. (immune and "ON" or "OFF"))
        return true
    end
    return false
end

------------------------------------------------------------------
-- COMBAT FUNCTIONS
------------------------------------------------------------------

-- Spawn a boss
function AdminModule:SpawnBoss(player, bossName)
    local BossSystem = require(game.ReplicatedStorage.BossSystem)
    local position = player.Character and player.Character.Position or Vector3.new(0, 50, 0)

    local boss = BossSystem.SpawnBoss(bossName, position)
    if boss then
        self:Notify(player, "Spawned boss: " .. bossName)
        print("[Admin] Spawned " .. bossName .. " at " .. tostring(position))
        return boss
    end
    return nil
end

-- Kill all enemies
function AdminModule:KillAllEnemies()
    local workspace = game.Workspace
    for _, entity in ipairs(workspace:GetChildren()) do
        if entity:FindFirstChild("Enemy") or entity:FindFirstChild("Boss") then
            entity:Destroy()
        end
    end
    print("[Admin] All enemies killed")
    return true
end

-- Spawn enemy wave
function AdminModule:SpawnWave(waveNumber)
    local GameModes = require(game.ReplicatedStorage.GameModes)
    -- Implementation depends on your enemy spawning system
    print("[Admin] Spawned wave " .. waveNumber)
    return true
end

------------------------------------------------------------------
-- SWARM FUNCTIONS
------------------------------------------------------------------

-- Spawn Rotlets
function AdminModule:SpawnRotlets(player, amount)
    amount = amount or 10
    local playerData = self:GetPlayerData(player)
    if playerData then
        playerData.SwarmUnits = playerData.SwarmUnits or {}
        playerData.SwarmUnits.Rotlet = (playerData.SwarmUnits.Rotlet or 0) + amount
        self:Notify(player, "Spawned " .. amount .. " Rotlets!")
        return true
    end
    return false
end

-- Spawn all swarm units
function AdminModule:SpawnAllUnits(player)
    local playerData = self:GetPlayerData(player)
    if playerData then
        playerData.SwarmUnits = {
            Rotlet = 50,
            Bulker = 10,
            Spitter = 10,
            Runner = 10,
            Colossus = 1
        }
        self:Notify(player, "Spawned full swarm!")
        return true
    end
    return false
end

------------------------------------------------------------------
-- REBIRTH FUNCTIONS
------------------------------------------------------------------

-- Perform rebirth
function AdminModule:DoRebirth(player)
    local RebirthSystem = require(game.ReplicatedStorage.RebirthSystem)
    local playerData = self:GetPlayerData(player)

    if playerData then
        playerData.Coins = 0
        playerData.RebirthCount = playerData.RebirthCount + 1
        playerData.TotalRebirthPoints = playerData.TotalRebirthPoints + 10
        playerData.CoinMultiplier = playerData.CoinMultiplier + 0.5
        self:Notify(player, "Rebirth complete! Points: " .. playerData.TotalRebirthPoints)
        return true
    end
    return false
end

-- Set rebirth level
function AdminModule:SetRebirthLevel(player, level)
    local playerData = self:GetPlayerData(player)
    if playerData then
        playerData.RebirthCount = level
        playerData.TotalRebirthPoints = level * 10
        playerData.CoinMultiplier = 1.0 + (level * 0.05)
        self:Notify(player, "Rebirth level set to " .. level)
        return true
    end
    return false
end

------------------------------------------------------------------
-- SHOP & UPGRADE FUNCTIONS
------------------------------------------------------------------

-- Unlock all shop items
function AdminModule:UnlockAllShop(player)
    local playerData = self:GetPlayerData(player)
    if playerData then
        playerData.UnlockedCosmetics = {
            Hats = {"hat_crown", "hat_glasses", "hat_bow", "hat_helmet", "hat_wizard",
                    "hat_devil", "hat_angel", "hat_crystal", "hat_fire"},
            Skins = {"skin_crystal", "skin_shadow", "skin_golden", "skin_neon", "skin_rainbow"},
            Trails = {"trail_sparkles", "trail_leaves", "trail_fire", "trail_ice",
                     "trail_rainbow", "trail_void"},
            Animations = {"anim_dance", "anim_spin", "anim_wave", "anim_attack",
                         "anim_floating", "anim_glow"}
        }
        self:Notify(player, "All shop items unlocked!")
        return true
    end
    return false
end

-- Max all speed upgrades
function AdminModule:MaxSpeed(player)
    local playerData = self:GetPlayerData(player)
    if playerData then
        playerData.SpeedLevel = 7
        playerData.CurrentMultiplier = 10.0
        self:Notify(player, "Speed maxed out!")
        return true
    end
    return false
end

-- Unlock all eggs
function AdminModule:UnlockAllEggs(player)
    local playerData = self:GetPlayerData(player)
    if playerData then
        playerData.UnlockedEggs = {"BasicEgg", "RareEgg", "EpicEgg", "CelestialEgg", "InfiniteEgg"}
        self:Notify(player, "All eggs unlocked!")
        return true
    end
    return false
end

------------------------------------------------------------------
-- UTILITY FUNCTIONS
------------------------------------------------------------------

-- Check if developer
function AdminModule:IsDeveloper(player)
    return self.Config.Developers[player.UserId] == true
end

-- Get player data (implement based on your system)
function AdminModule:GetPlayerData(player)
    -- This depends on your player data system
    -- Replace with your actual implementation
    if player:FindFirstChild("PlayerData") then
        return player.PlayerData
    end
    return nil
end

-- Notify player
function AdminModule:Notify(player, message)
    if player:FindFirstChild("PlayerGui") then
        -- Replace with your notification system
        warn("[Admin Notification to " .. player.Name .. "]: " .. message)
    end
end

-- Format large numbers
function AdminModule:FormatNumber(num)
    if num >= 1e12 then
        return string.format("%.2fT", num / 1e12)
    elseif num >= 1e9 then
        return string.format("%.2fB", num / 1e9)
    elseif num >= 1e6 then
        return string.format("%.2fM", num / 1e6)
    elseif num >= 1e3 then
        return string.format("%.2fK", num / 1e3)
    end
    return tostring(math.floor(num))
end

------------------------------------------------------------------
-- ADMIN COMMANDS (Chat-based)
------------------------------------------------------------------

AdminModule.Commands = {
    ["!god"] = function(player)
        AdminModule:EnableGodMode(player)
    end,

    ["!coins"] = function(player, amount)
        AdminModule:AddCoins(player, amount or 999999999)
    end,

    ["!diamonds"] = function(player, amount)
        AdminModule:AddDiamonds(player, amount or 999999)
    end,

    ["!spawn"] = function(player, braidrotName, level)
        AdminModule:SpawnBraidrot(player, braidrotName, level or 1)
    end,

    ["!spawnall"] = function(player)
        AdminModule:SpawnAllBraidrots(player, 50)
    end,

    ["!unlockworlds"] = function(player)
        AdminModule:UnlockAllWorlds(player)
    end,

    ["!boss"] = function(player, bossName)
        AdminModule:SpawnBoss(player, bossName or "IceGiant")
    end,

    ["!kill"] = function()
        AdminModule:KillAllEnemies()
    end,

    ["!swarm"] = function(player)
        AdminModule:SpawnAllUnits(player)
    end,

    ["!shop"] = function(player)
        AdminModule:UnlockAllShop(player)
    end,

    ["!speed"] = function(player)
        AdminModule:MaxSpeed(player)
    end,

    ["!rebirth"] = function(player)
        AdminModule:DoRebirth(player)
    end,

    ["!tp"] = function(player, worldName)
        AdminModule:TeleportToWorld(player, worldName or "IceWorld")
    end,

    ["!immunity"] = function(player)
        AdminModule:SetHazardImmunity(player, true)
    end,

    ["!help"] = function(player)
        AdminModule:Notify(player, "Commands: !god, !coins, !diamonds, !spawn [name], !spawnall, !unlockworlds, !boss [name], !kill, !swarm, !shop, !speed, !rebirth, !tp [world], !immunity")
    end
}

-- Process chat command
function AdminModule:ProcessCommand(player, message)
    if not self:IsDeveloper(player) then return end

    local parts = string.split(message, " ")
    local command = parts[1]
    local args = {unpack(parts, 2)}

    local cmdFunc = self.Commands[command]
    if cmdFunc then
        cmdFunc(player, unpack(args))
    end
end

------------------------------------------------------------------
-- INITIALIZATION
------------------------------------------------------------------

-- Connect to chat service (requires your chat system)
task.spawn(function()
    local Players = game:GetService("Players")

    Players.PlayerAdded:Connect(function(player)
        -- Auto-enable god mode for developers
        if AdminModule:IsDeveloper(player) then
            task.wait(2)
            AdminModule:EnableGodMode(player)
            print("[Admin] Auto god mode enabled for developer: " .. player.Name)
        end
    end)
end)

print("[AdminModule] Loaded - Developer commands ready")

return AdminModule
