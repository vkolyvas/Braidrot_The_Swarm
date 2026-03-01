--[[
    Cosmetics ModuleScript
    Hats, Skins, Trails, Animations for Braidrots
    Place in ReplicatedStorage > Cosmetics
]]

local Cosmetics = {}

------------------------------------------------------------------
-- HATS
------------------------------------------------------------------

Cosmetics.Hats = {
    -- Common (Easy to get)
    {
        Id = "hat_crown",
        Name = "Tiny Crown",
        Rarity = "Common",
        Price = 500,
        Currency = "Coins",
        Description = "A small golden crown",
        ModelId = "rbxassetid://12345678"
    },
    {
        Id = "hat_glasses",
        Name = "Cool Shades",
        Rarity = "Common",
        Price = 300,
        Currency = "Coins",
        Description = "Stylish sunglasses",
        ModelId = "rbxassetid://12345679"
    },
    {
        Id = "hat_bow",
        Name = "Cute Bow",
        Rarity = "Common",
        Price = 250,
        Currency = "Coins",
        Description = "A adorable pink bow",
        ModelId = "rbxassetid://12345680"
    },

    -- Rare
    {
        Id = "hat_helmet",
        Name = "Knight Helmet",
        Rarity = "Rare",
        Price = 100,
        Currency = "Diamonds",
        Description = "Protective knight helmet",
        ModelId = "rbxassetid://12345681"
    },
    {
        Id = "hat_wizard",
        Name = "Wizard Hat",
        Rarity = "Rare",
        Price = 150,
        Currency = "Diamonds",
        Description = "Magical wizard hat with stars",
        ModelId = "rbxassetid://12345682"
    },

    -- Epic
    {
        Id = "hat_devil",
        Name = "Devil Horns",
        Rarity = "Epic",
        Price = 300,
        Currency = "Diamonds",
        Description = "Spooky devil horns",
        ModelId = "rbxassetid://12345683"
    },
    {
        Id = "hat_angel",
        Name = "Angel Wings",
        Rarity = "Epic",
        Price = 350,
        Currency = "Diamonds",
        Description = "Beautiful angel wings",
        ModelId = "rbxassetid://12345684"
    },

    -- Legendary
    {
        Id = "hat_crystal",
        Name = "Crystal Crown",
        Rarity = "Legendary",
        Price = 1000,
        Currency = "Robux",
        Description = "Shimmering crystal crown",
        ModelId = "rbxassetid://12345685"
    },
    {
        Id = "hat_fire",
        Name = "Flame Halo",
        Rarity = "Legendary",
        Price = 1500,
        Currency = "Robux",
        Description = "Burning flame halo",
        ModelId = "rbxassetid://12345686"
    }
}

------------------------------------------------------------------
-- SKINS (Mother-Knot Variants)
------------------------------------------------------------------

Cosmetics.Skins = {
    {
        Id = "skin_default",
        Name = "Default Roots",
        Rarity = "Default",
        Price = 0,
        Description = "Classic green root appearance"
    },
    {
        Id = "skin_crystal",
        Name = "Crystal Form",
        Rarity = "Epic",
        Price = 500,
        Currency = "Diamonds",
        Description = "Translucent crystal Mother-Knot"
    },
    {
        Id = "skin_shadow",
        Name = "Shadow Form",
        Rarity = "Epic",
        Price = 500,
        Currency = "Diamonds",
        Description = "Dark shadow Mother-Knot"
    },
    {
        Id = "skin_golden",
        Name = "Golden Form",
        Rarity = "Legendary",
        Price = 2000,
        Currency = "Robux",
        Description = "Pure golden Mother-Knot"
    },
    {
        Id = "skin_neon",
        Name = "Neon Form",
        Rarity = "Legendary",
        Price = 2500,
        Currency = "Robux",
        Description = "Glowing neon Mother-Knot"
    },
    {
        Id = "skin_rainbow",
        Name = "Rainbow Form",
        Rarity = "Ultimate",
        Price = 5000,
        Currency = "Robux",
        Description = "Cycles through all colors"
    }
}

------------------------------------------------------------------
-- TRAIL EFFECTS
------------------------------------------------------------------

Cosmetics.Trails = {
    {
        Id = "trail_none",
        Name = "No Trail",
        Rarity = "Default",
        Price = 0
    },
    {
        Id = "trail_sparkles",
        Name = "Sparkles",
        Rarity = "Common",
        Price = 200,
        Currency = "Coins",
        Description = "Little sparkles trailing behind"
    },
    {
        Id = "trail_leaves",
        Name = "Autumn Leaves",
        Rarity = "Common",
        Price = 250,
        Currency = "Coins",
        Description = "Falling leaves"
    },
    {
        Id = "trail_fire",
        Name = "Fire Trail",
        Rarity = "Rare",
        Price = 100,
        Currency = "Diamonds",
        Description = "Burning fire trail"
    },
    {
        Id = "trail_ice",
        Name = "Ice Crystals",
        Rarity = "Rare",
        Price = 100,
        Currency = "Diamonds",
        Description = "Ice crystals floating behind"
    },
    {
        Id = "trail_rainbow",
        Name = "Rainbow Trail",
        Rarity = "Epic",
        Price = 250,
        Currency = "Diamonds",
        Description = "Colorful rainbow trail"
    },
    {
        Id = "trail_void",
        Name = "Void Portal",
        Rarity = "Legendary",
        Price = 500,
        Currency = "Robux",
        Description = "Dark void portal particles"
    }
}

------------------------------------------------------------------
-- ANIMATIONS
------------------------------------------------------------------

Cosmetics.Animations = {
    {
        Id = "anim_idle",
        Name = "Default Idle",
        Rarity = "Default",
        Price = 0,
        Description = "Normal bouncing idle"
    },
    {
        Id = "anim_dance",
        Name = "Happy Dance",
        Rarity = "Common",
        Price = 150,
        Currency = "Coins",
        Description = "Bouncy happy dance"
    },
    {
        Id = "anim_spin",
        Name = "Spinning",
        Rarity = "Common",
        Price = 150,
        Currency = "Coins",
        Description = "Spinning animation"
    },
    {
        Id = "anim_wave",
        Name = "Friendly Wave",
        Rarity = "Rare",
        Price = 50,
        Currency = "Diamonds",
        Description = "Waves at others"
    },
    {
        Id = "anim_attack",
        Name = "Aggressive Stance",
        Rarity = "Rare",
        Price = 75,
        Currency = "Diamonds",
        Description = "Angry attack pose"
    },
    {
        Id = "anim_floating",
        Name = "Levitation",
        Rarity = "Epic",
        Price = 200,
        Currency = "Diamonds",
        Description = "Floats gently in air"
    },
    {
        Id = "anim_glow",
        Name = "Pulsing Glow",
        Rarity = "Legendary",
        Price = 400,
        Currency = "Robux",
        Description = "Pulsing light effect"
    }
}

------------------------------------------------------------------
-- PARTICLE EFFECTS
------------------------------------------------------------------

Cosmetics.Particles = {
    {
        Id = "particle_none",
        Name = "None",
        Price = 0
    },
    {
        Id = "particle_hearts",
        Name = "Hearts",
        Rarity = "Common",
        Price = 100,
        Currency = "Coins",
        Description = "Floating hearts"
    },
    {
        Id = "particle_stars",
        Name = "Stars",
        Rarity = "Common",
        Price = 100,
        Currency = "Coins",
        Description = "Twinkling stars"
    },
    {
        Id = "particle_smoke",
        Name = "Smoke",
        Rarity = "Rare",
        Price = 50,
        Currency = "Diamonds",
        Description = "Mysterious smoke"
    },
    {
        Id = "particle_lightning",
        Name = "Lightning",
        Rarity = "Epic",
        Price = 150,
        Currency = "Diamonds",
        Description = "Crackling lightning"
    },
    {
        Id = "particle_portal",
        Name = "Portal",
        Rarity = "Legendary",
        Price = 300,
        Currency = "Robux",
        Description = "Mysterious portal effect"
    }
}

------------------------------------------------------------------
-- PLAYER AVATAR COSMETICS
------------------------------------------------------------------

Cosmetics.Avatar = {
    Hats = {
        {
            Id = "avatar_crown",
            Name = "Royal Crown",
            Rarity = "Epic",
            Price = 500,
            Currency = "Robux",
            Description = "Crown for your avatar"
        }
    },
    Accessories = {
        {
            Id = "acc_backpack",
            Name = "Backpack",
            Rarity = "Common",
            Price = 100,
            Currency = "Robux",
            Description = "Cute backpack"
        },
        {
            Id = "acc_wings",
            Name = "Angel Wings",
            Rarity = "Legendary",
            Price = 1000,
            Currency = "Robux",
            Description = "Beautiful wings"
        }
    }
}

------------------------------------------------------------------
-- HELPER FUNCTIONS
------------------------------------------------------------------

function Cosmetics.GetHatById(id)
    for _, hat in ipairs(Cosmetics.Hats) do
        if hat.Id == id then return hat end
    end
    return nil
end

function Cosmetics.GetSkins()
    return Cosmetics.Skins
end

function Cosmetics.GetTrails()
    return Cosmetics.Trails
end

function Cosmetics.GetAnimations()
    return Cosmetics.Animations
end

function Cosmetics.GetCosmeticsByRarity(rarity)
    local result = {
        Hats = {},
        Skins = {},
        Trails = {},
        Animations = {}
    }

    for _, hat in ipairs(Cosmetics.Hats) do
        if hat.Rarity == rarity then table.insert(result.Hats, hat) end
    end

    return result
end

function Cosmetics.CreatePlayerCosmeticData()
    return {
        OwnedHats = {"hat_crown"},
        OwnedSkins = {"skin_default"},
        OwnedTrails = {"trail_none"},
        OwnedAnimations = {"anim_idle"},
        EquippedHat = nil,
        EquippedSkin = "skin_default",
        EquippedTrail = "trail_none",
        EquippedAnimation = "anim_idle"
    }
end

return Cosmetics
