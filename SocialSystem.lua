--[[
    SocialSystem ModuleScript
    Clans, Trading, Friends, Global Chat
    Place in ReplicatedStorage > SocialSystem
]]

local SocialSystem = {}

------------------------------------------------------------------
-- CLANS / GUILDS
------------------------------------------------------------------

SocialSystem.Clans = {
    -- Clan settings
    MaxMembers = 50,
    MaxClans = 1000,

    -- Clan ranks
    Ranks = {
        {
            Name = "Leader",
            Permissions = {"Kick", "Invite", "Promote", "Demote", "Disband", "EditSettings"},
            Icon = "👑"
        },
        {
            Name = "Co-Leader",
            Permissions = {"Kick", "Invite", "Promote", "EditDescription"},
            Icon = "⭐"
        },
        {
            Name = "Elder",
            Permissions = {"Invite", "Promote"},
            Icon = "⚔️"
        },
        {
            Name = "Member",
            Permissions = {"Chat"},
            Icon = "🛡️"
        },
        {
            Name = "Recruit",
            Permissions = {"Chat"},
            Icon = "🌱"
        }
    },

    -- Clan creation cost
    CreationCost = {
        Coins = 50000,
        Diamonds = 50
    },

    -- Upgrades
    Upgrades = {
        {
            Level = 1,
            Name = "Growth",
            MaxMembers = 75,
            Cost = {Coins = 25000, Diamonds = 25}
        },
        {
            Level = 2,
            Name = "Unity",
            MaxMembers = 100,
            Cost = {Coins = 50000, Diamonds = 50}
        },
        {
            Level = 3,
            Name = "Legends",
            MaxMembers = 150,
            Cost = {Coins = 100000, Diamonds = 100}
        }
    }
}

-- Create new clan
function SocialSystem.CreateClan(name, leaderId, leaderName)
    return {
        Name = name,
        LeaderId = leaderId,
        LeaderName = leaderName,
        Members = {
            {
                UserId = leaderId,
                Username = leaderName,
                Rank = "Leader",
                JoinedAt = os.time()
            }
        },
        Description = "",
        Tag = string.sub(name, 1, 4):upper(),
        Level = 1,
        XP = 0,
        CreatedAt = os.time(),
        TotalDonations = 0,
        WeeklyDonations = {},
        Wins = 0,
        Losses = 0
    }
end

------------------------------------------------------------------
-- TRADING SYSTEM
------------------------------------------------------------------

SocialSystem.Trading = {
    -- Trade limits
    MaxTradesPerDay = 20,
    MaxItemsPerTrade = 10,

    -- Trade status
    Status = {
        Pending = "Pending",
        Accepted = "Accepted",
        Rejected = "Rejected",
        Completed = "Completed",
        Cancelled = "Cancelled"
    },

    -- Trade requirements
    Requirements = {
        MinAccountAge = 7, -- days
        MinLevel = 10,
        FriendsRequired = false,
        VerifiedOnly = false
    },

    -- Restricted items (cannot trade)
    RestrictedItems = {
        "Dragon with Cinnamon",
        "InfiniteEgg",
        "Colossus"
    },

    -- Create trade offer
    CreateTrade = function(senderId, receiverId)
        return {
            Id = os.time(),
            SenderId = senderId,
            ReceiverId = receiverId,
            SenderItems = {},
            ReceiverItems = {},
            SenderCoins = 0,
            ReceiverCoins = 0,
            Status = "Pending",
            CreatedAt = os.time(),
            UpdatedAt = os.time()
        }
    end
}

------------------------------------------------------------------
-- FRIENDS SYSTEM
------------------------------------------------------------------

SocialSystem.Friends = {
    MaxFriends = 200,
    MaxBestFriends = 10,

    -- Friend events
    Events = {
        SendGift = true,
        VisitBase = true,
        CoopPlay = true,
        Chat = true
    },

    -- Relationship levels
    Levels = {
        {
            Name = "Stranger",
            MinInteractions = 0,
            Color = Color3.fromRGB(150, 150, 150)
        },
        {
            Name = "Acquaintance",
            MinInteractions = 10,
            Color = Color3.fromRGB(100, 200, 100)
        },
        {
            Name = "Friend",
            MinInteractions = 50,
            Color = Color3.fromRGB(100, 150, 255)
        },
        {
            Name = "Best Friend",
            MinInteractions = 200,
            Color = Color3.fromRGB(255, 200, 0)
        }
    }
}

-- Create friend data
function SocialSystem.CreateFriendData(userId)
    return {
        UserId = userId,
        Friends = {},
        Blocked = {},
        BestFriends = {},
        FriendRequests = {},
        SentRequests = {},
        Interactions = {},
        LastSeen = os.time()
    }
end

------------------------------------------------------------------
-- GLOBAL CHAT & EMOTES
------------------------------------------------------------------

SocialSystem.Chat = {
    -- Channel types
    Channels = {
        Global = {Name = "Global", Type = "Public"},
        Clan = {Name = "Clan", Type = "Private"},
        Trade = {Name = "Trade", Type = "Marketplace"},
        World = {Name = "World", Type = "Area"}
    },

    -- Chat colors by rank
    RankColors = {
        Admin = Color3.fromRGB(255, 0, 0),
        Moderator = Color3.fromRGB(255, 100, 0),
        VIP = Color3.fromRGB(255, 215, 0),
        Member = Color3.fromRGB(255, 255, 255),
        Guest = Color3.fromRGB(180, 180, 180)
    },

    -- Emote commands
    Emotes = {
        {Command = "/e wave", Name = "Wave", Animation = "Wave"},
        {Command = "/e dance", Name = "Dance", Animation = "Dance"},
        {Command = "/e laugh", Name = "Laugh", Animation = "Laugh"},
        {Command = "/e cry", Name = "Cry", Animation = "Cry"},
        {Command = "/e cheer", Name = "Cheer", Animation = "Cheer"},
        {Command = "/e point", Name = "Point", Animation = "Point"},
        {Command = "/e sleep", Name = "Sleep", Animation = "Sleep"},
        {Command = "/e eat", Name = "Eat", Animation = "Eat"},
        {Command = "/e flex", Name = "Flex", Animation = "Flex"}
    },

    -- Chat filters
    Filters = {
        BlockedWords = {},
        SpamCooldown = 2, -- seconds
        MaxLength = 200
    }
}

------------------------------------------------------------------
-- PLAYER PROFILE
------------------------------------------------------------------

SocialSystem.Profile = {
    -- Profile sections
    Sections = {
        "Stats",
        "Braidrots",
        "Cosmetics",
        "Clan",
        "Achievements",
        "Matches"
    },

    -- Bio limits
    BioMaxLength = 200,

    -- Profile frames
    Frames = {
        {
            Id = "default",
            Name = "Default Frame",
            Price = 0
        },
        {
            Id = "bronze",
            Name = "Bronze Frame",
            Price = 100,
            Currency = "Diamonds"
        },
        {
            Id = "silver",
            Name = "Silver Frame",
            Price = 250,
            Currency = "Diamonds"
        },
        {
            Id = "gold",
            Name = "Gold Frame",
            Price = 500,
            Currency = "Diamonds"
        },
        {
            Id = "diamond",
            Name = "Diamond Frame",
            Price = 1000,
            Currency = "Robux"
        }
    }
}

------------------------------------------------------------------
-- HELPER FUNCTIONS
------------------------------------------------------------------

function SocialSystem.GetClanRankPermissions(rankName)
    for _, rank in ipairs(SocialSystem.Clans.Ranks) do
        if rank.Name == rankName then
            return rank.Permissions
        end
    end
    return {}
end

function SocialSystem.CanTrade(playerData)
    local age = playerData.AccountAgeDays or 0
    local level = playerData.Level or 0

    if age < SocialSystem.Trading.Requirements.MinAccountAge then
        return false, "Account too new"
    end
    if level < SocialSystem.Trading.Requirements.MinLevel then
        return false, "Level too low"
    end
    return true, "Can trade"
end

function SocialSystem.GetFriendLevel(interactions)
    for i = #SocialSystem.Friends.Levels, 1, -1 do
        if interactions >= SocialSystem.Friends.Levels[i].MinInteractions then
            return SocialSystem.Friends.Levels[i]
        end
    end
    return SocialSystem.Friends.Levels[1]
end

function SocialSystem.GetEmoteByCommand(command)
    for _, emote in ipairs(SocialSystem.Chat.Emotes) do
        if emote.Command == command then
            return emote
        end
    end
    return nil
end

return SocialSystem
