--[[
    Braidrot Image Mapping
    Maps render image filenames to Braidrot names and classes
]]

local BraidrotImages = {
    -- BASIC (Green)
    ["Rap-Rap-Rap-Sagour.png"] = {
        Rap-Rap-Rap = {
            Class = "Basic",
            Rarity = "Basic",
            Description = "A rhythmic tapping Braidrot"
        },
        Sagur = {
            Class = "Basic",
            Rarity = "Basic",
            Description = "A sleepy happy Braidrot"
        }
    },
    ["Monkey_Banana.png"] = {
        ["Monkey Banana"] = {
            Class = "Basic",
            Rarity = "Basic",
            Description = "A monkey that loves bananas"
        }
    },
    ["Shark_Shoes.png"] = {
        ["Shark Shoes"] = {
            Class = "Basic",
            Rarity = "Basic",
            Description = "Swims through coins like a shark"
        }
    },
    ["Frame_Mouth.png"] = {
        ["Frame Mouth"] = {
            Class = "Basic",
            Rarity = "Basic",
            Description = "Has a picture frame for a mouth"
        }
    },
    ["Light_Eyes.png"] = {
        ["Light Eyes"] = {
            Class = "Basic",
            Rarity = "Basic",
            Description = "Eyes that shine like lightbulbs"
        }
    },
    ["Moon_Teeth.png"] = {
        ["Moon Teeth"] = {
            Class = "Basic",
            Rarity = "Basic",
            Description = "Teeth that glow in the dark"
        }
    },
    ["Table_Eyes.png"] = {
        ["Table Eyes"] = {
            Class = "Basic",
            Rarity = "Basic",
            Description = "Eyes on a tiny table"
        }
    },

    -- RARE (Blue)
    ["Flying_Fish.png"] = {
        ["Flying Fish"] = {
            Class = "Rare",
            Rarity = "Rare",
            Description = "Can fly short distances over hazards"
        }
    },
    ["Burger_Legs.png"] = {
        ["Burger Legs"] = {
            Class = "Rare",
            Rarity = "Rare",
            Description = "Runs fast on burger-shaped legs"
        }
    },
    ["Potato_Tractor.png"] = {
        ["Potato Tractor"] = {
            Class = "Rare",
            Rarity = "Rare",
            Description = "Harvests coins automatically"
        }
    },

    -- EPIC (Purple)
    ["Jerry_claw.png"] = {
        ["Jerry"] = {
            Class = "Epic",
            Rarity = "Epic",
            Description = "Can phase through certain hazards"
        }
    },
    ["bbGun_Cucumber.png"] = {
        ["Gun with Cucumber"] = {
            Class = "Epic",
            Rarity = "Epic",
            Description = "Shoots cucumber shields for protection"
        }
    },
    ["Bear_Macaroni.png"] = {
        ["Bear with Macaroni"] = {
            Class = "Epic",
            Rarity = "Epic",
            Description = "Can grow larger to avoid small hazards"
        }
    },
    ["Shoe_Head.png"] = {
        ["Shoe with Head"] = {
            Class = "Epic",
            Rarity = "Epic",
            Description = "Can teleport to safe platforms"
        }
    },

    -- CELESTIAL (Star)
    ["Family_Braidrots.png"] = {
        ["Family with Brairos"] = {
            Class = "Celestial",
            Rarity = "Celestial",
            Description = "The legendary family that found Brairos"
        }
    },

    -- SECRET (Hidden)
    ["Secret_ghosts.png"] = {
        ["Shadow Braidrot"] = {
            Class = "Secret",
            Rarity = "Secret",
            Description = "A mysterious hidden Braidrot"
        },
        ["Golden Glitch"] = {
            Class = "Secret",
            Rarity = "Secret",
            Description = "Exists outside normal game rules"
        }
    },

    -- INFINITE (Fire)
    ["Dragon_Cinnamon.png"] = {
        ["Dragon with Cinnamon"] = {
            Class = "Infinite",
            Rarity = "Infinite",
            Description = "The ultimate Braidrot - immune to all hazards"
        }
    },

    -- ADDITIONAL / UNMAPPED
    ["Braidrot_the_swarm.png"] = {
        Unknown = {
            Class = "Unknown",
            Rarity = "Unknown",
            Description = "Swarm variant - needs mapping"
        }
    },
    ["Rotlet.png"] = {
        Unknown = {
            Class = "Unknown",
            Rarity = "Unknown",
            Description = "Needs mapping"
        }
    },
    ["Boss_Bulker.png"] = {
        ["Bulker"] = {
            Class = "Swarm",
            Rarity = "Epic",
            Description = "Tank evolution - stone-bark body, protects Rotlets"
        }
    },
    ["Spitter.png"] = {
        Unknown = {
            Class = "Unknown",
            Rarity = "Unknown",
            Description = "Needs mapping"
        }
    },
    ["Braidrots-renders.png"] = {
        Unknown = {
            Class = "Collection",
            Rarity = "Unknown",
            Description = "Group render sheet"
        }
    }
}

-- Get image by Braidrot name
function BraidrotImages.GetImageByName(braidrotName)
    for filename, data in pairs(BraidrotImages) do
        if data[braidrotName] then
            return {
                Filename = filename,
                Data = data[braidrotName]
            }
        end
    end
    return nil
end

-- Get all images
function BraidrotImages.GetAllImages()
    return BraidrotImages
end

return BraidrotImages
