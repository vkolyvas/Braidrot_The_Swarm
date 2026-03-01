--[[
    LeaderboardSystem ModuleScript
    Handles leaderboards and social features
    Place in ReplicatedStorage > LeaderboardSystem
]]

local LeaderboardSystem = {}

-- Leaderboard types
LeaderboardSystem.LeaderboardTypes = {
    Coins = {
        Name = "Richest Players",
        Icon = "rbxassetid://12345678",
        SortOrder = "Descending"
    },
    Diamonds = {
        Name = "Diamond Hunters",
        Icon = "rbxassetid://12345679",
        SortOrder = "Descending"
    },
    Braidrots = {
        Name = "Top Collectors",
        Icon = "rbxassetid://12345680",
        SortOrder = "Descending"
    },
    Rebirths = {
        Name = "Prestige Masters",
        Icon = "rbxassetid://12345681",
        SortOrder = "Descending"
    },
    World = {
        Name = "World Conquerors",
        Icon = "rbxassetid://12345682",
        SortOrder = "Descending"
    }
}

-- Maximum entries per leaderboard
LeaderboardSystem.MaxEntries = 100

-- Cache for leaderboard data
LeaderboardSystem.LeaderboardCache = {
    Coins = {},
    Diamonds = {},
    Braidrots = {},
    Rebirths = {},
    World = {}
}

-- Cache expiration time (seconds)
LeaderboardSystem.CacheExpiration = 60

-- Create player stats for leaderboard
function LeaderboardSystem.CreatePlayerStats(player)
    return {
        UserId = player.UserId,
        Username = player.Name,
        Coins = 0,
        Diamonds = 0,
        BraidrotCount = 0,
        RebirthCount = 0,
        WorldsCompleted = 0,
        LastUpdated = os.time()
    }
end

-- Update player stats
function LeaderboardSystem.UpdatePlayerStats(playerId, stats)
    -- In a real implementation, this would update a database
    -- For now, we simulate with in-memory storage

    local entry = {
        UserId = stats.UserId,
        Username = stats.Username,
        Coins = stats.Coins or 0,
        Diamonds = stats.Diamonds or 0,
        BraidrotCount = stats.BraidrotCount or 0,
        RebirthCount = stats.RebirthCount or 0,
        WorldsCompleted = stats.WorldsCompleted or 0,
        LastUpdated = os.time()
    }

    return entry
end

-- Get leaderboard entries
function LeaderboardSystem.GetLeaderboard(boardType, limit)
    if not LeaderboardSystem.LeaderboardTypes[boardType] then
        return nil, "Invalid leaderboard type"
    end

    limit = limit or LeaderboardSystem.MaxEntries

    -- In production, this would fetch from a database
    -- For now, return cached data
    local cache = LeaderboardSystem.LeaderboardCache[boardType]

    -- Sort and limit
    local sorted = {}
    for _, entry in pairs(cache) do
        table.insert(sorted, entry)
    end

    table.sort(sorted, function(a, b)
        return a[boardType] > b[boardType]
    })

    local result = {}
    for i = 1, math.min(limit, #sorted) do
        table.insert(result, {
            Rank = i,
            Username = sorted[i].Username,
            Value = sorted[i][boardType]
        })
    end

    return result
end

-- Get player rank
function LeaderboardSystem.GetPlayerRank(playerId, boardType)
    local leaderboard = LeaderboardSystem.GetLeaderboard(boardType, 1000)

    for rank, entry in ipairs(leaderboard) do
        if entry.UserId == playerId then
            return rank
        end
    end

    return nil
end

-- Get surrounding players (for positioning UI)
function LeaderboardSystem.GetSurroundingPlayers(playerId, boardType, range)
    range = range or 2

    local leaderboard = LeaderboardSystem.GetLeaderboard(boardType, 1000)
    local playerRank = LeaderboardSystem.GetPlayerRank(playerId, boardType)

    if not playerRank then
        return nil
    end

    local startRank = math.max(1, playerRank - range)
    local endRank = math.min(#leaderboard, playerRank + range)

    local result = {}
    for i = startRank, endRank do
        table.insert(result, leaderboard[i])
    end

    return result
end

-- Get all leaderboard types
function LeaderboardSystem.GetLeaderboardTypes()
    return LeaderboardSystem.LeaderboardTypes
end

-- Subscribe to leaderboard updates (for real-time)
LeaderboardSystem.Subscribers = {}

function LeaderboardSystem.Subscribe(callback)
    table.insert(LeaderboardSystem.Subscribers, callback)
end

function LeaderboardSystem.NotifySubscribers(boardType, update)
    for _, callback in ipairs(LeaderboardSystem.Subscribers) do
        task.spawn(callback, boardType, update)
    end
end

-- Get formatted leaderboard for display
function LeaderboardSystem.GetFormattedEntry(entry, boardType)
    local value = entry.Value
    local formatted = tostring(value)

    if boardType == "Coins" then
        if value >= 1e12 then
            formatted = string.format("%.2fT", value / 1e12)
        elseif value >= 1e9 then
            formatted = string.format("%.2fB", value / 1e9)
        elseif value >= 1e6 then
            formatted = string.format("%.2fM", value / 1e6)
        elseif value >= 1e3 then
            formatted = string.format("%.2fK", value / 1e3)
        end
    elseif boardType == "Diamonds" then
        formatted = tostring(value)
    end

    return {
        Rank = entry.Rank,
        Username = entry.Username,
        Value = formatted,
        RawValue = value
    }
end

return LeaderboardSystem
