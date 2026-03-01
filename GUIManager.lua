--[[
    GUIManager ModuleScript
    Creates all game UI programmatically
    Place in ReplicatedStorage > GUIManager
]]

local GUIManager = {}

------------------------------------------------------------------
-- COLORS
------------------------------------------------------------------

GUIManager.Colors = {
    Primary = Color3.fromRGB(45, 135, 45),      -- Green
    Secondary = Color3.fromRGB(30, 100, 30),    -- Dark Green
    Accent = Color3.fromRGB(255, 200, 0),       -- Gold
    Background = Color3.fromRGB(40, 40, 40),    -- Dark Gray
    Text = Color3.fromRGB(255, 255, 255),       -- White
    Danger = Color3.fromRGB(200, 50, 50),        -- Red
    Rare = Color3.fromRGB(100, 149, 237),       -- Blue
    Epic = Color3.fromRGB(147, 112, 219),       -- Purple
    Legendary = Color3.fromRGB(255, 215, 0),    -- Gold
    Infinite = Color3.fromRGB(255, 69, 0)        -- Orange
}

------------------------------------------------------------------
-- MAIN MENU
------------------------------------------------------------------

function GUIManager.CreateMainMenu(player)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MainMenu"
    screenGui.IgnoreGuiInset = true
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")

    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(1, 0, 1, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.8, 0, 0.2, 0)
    title.Position = UDim2.new(0.1, 0, 0.1, 0)
    title.BackgroundTransparency = 1
    title.Text = "BRAIDROT THE SWARM"
    title.TextColor3 = GUIManager.Colors.Accent
    title.TextScaled = true
    title.Font = Enum.Font.FredokaOne
    title.Parent = mainFrame

    -- Play Button
    local playBtn = GUIManager.CreateButton("PLAY", UDim2.new(0.3, 0, 0.1, 0), UDim2.new(0.35, 0, 0.4, 0))
    playBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
        GUIManager.CreateHUD(player)
    end)
    playBtn.Parent = mainFrame

    -- Shop Button
    local shopBtn = GUIManager.CreateButton("SHOP", UDim2.new(0.2, 0, 0.1, 0), UDim2.new(0.35, 0, 0.55, 0))
    shopBtn.MouseButton1Click:Connect(function()
        GUIManager.CreateShopUI(player)
    end)
    shopBtn.Parent = mainFrame

    -- Collection Button
    local collectionBtn = GUIManager.CreateButton("COLLECTION", UDim2.new(0.2, 0, 0.1, 0), UDim2.new(0.55, 0, 0.55, 0))
    collectionBtn.MouseButton1Click:Connect(function()
        GUIManager.CreateCollectionUI(player)
    end)
    collectionBtn.Parent = mainFrame

    -- Settings Button
    local settingsBtn = Instance.new("TextButton")
    settingsBtn.Size = UDim2.new(0.1, 0, 0.05, 0)
    settingsBtn.Position = UDim2.new(0.9, 0, 0.02, 0)
    settingsBtn.BackgroundColor3 = GUIManager.Colors.Background
    settingsBtn.Text = "⚙️"
    settingsBtn.TextColor3 = GUIManager.Colors.Text
    settingsBtn.Parent = mainFrame

    return screenGui
end

------------------------------------------------------------------
-- HUD (Heads-Up Display)
------------------------------------------------------------------

function GUIManager.CreateHUD(player)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "GameHUD"
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = player:WaitForChild("PlayerGui")

    -- Top Bar (Coins, Diamonds, Energy)
    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0.08, 0)
    topBar.Position = UDim2.new(0, 0, 0, 0)
    topBar.BackgroundColor3 = GUIManager.Colors.Background
    topBar.BorderSizePixel = 0
    topBar.Parent = screenGui

    -- Coins Display
    local coinsLabel = Instance.new("TextLabel")
    coinsLabel.Size = UDim2.new(0.2, 0, 0.8, 0)
    coinsLabel.Position = UDim2.new(0.02, 0, 0.1, 0)
    coinsLabel.BackgroundTransparency = 1
    coinsLabel.Text = "💰 0"
    coinsLabel.TextColor3 = GUIManager.Colors.Accent
    coinsLabel.TextXAlignment = Enum.TextXAlignment.Left
    coinsLabel.Parent = topBar
    screenGui:SetAttribute("CoinsLabel", coinsLabel)

    -- Diamonds Display
    local diamondsLabel = Instance.new("TextLabel")
    diamondsLabel.Size = UDim2.new(0.2, 0, 0.8, 0)
    diamondsLabel.Position = UDim2.new(0.25, 0, 0.1, 0)
    diamondsLabel.BackgroundTransparency = 1
    diamondsLabel.Text = "💎 0"
    diamondsLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
    diamondsLabel.TextXAlignment = Enum.TextXAlignment.Left
    diamondsLabel.Parent = topBar
    screenGui:SetAttribute("DiamondsLabel", diamondsLabel)

    -- CPS Display
    local cpsLabel = Instance.new("TextLabel")
    cpsLabel.Size = UDim2.new(0.2, 0, 0.8, 0)
    cpsLabel.Position = UDim2.new(0.48, 0, 0.1, 0)
    cpsLabel.BackgroundTransparency = 1
    cpsLabel.Text = "⚡ 0/sec"
    cpsLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
    cpsLabel.TextXAlignment = Enum.TextXAlignment.Left
    cpsLabel.Parent = topBar
    screenGui:SetAttribute("CPSLabel", cpsLabel)

    -- World Button
    local worldBtn = GUIManager.CreateButton("🌍 World", UDim2.new(0.15, 0, 0.6, 0), UDim2.new(0.75, 0, 0.1, 0))
    worldBtn.MouseButton1Click:Connect(function()
        GUIManager.CreateWorldUI(player)
    end)
    worldBtn.Parent = topBar

    -- Menu Button
    local menuBtn = GUIManager.CreateButton("☰", UDim2.new(0.05, 0, 0.6, 0), UDim2.new(0.92, 0, 0.1, 0))
    menuBtn.MouseButton1Click:Connect(function()
        GUIManager.CreatePauseMenu(player, screenGui)
    end)
    menuBtn.Parent = topBar

    -- Bottom Bar (Actions)
    local bottomBar = Instance.new("Frame")
    bottomBar.Size = UDim2.new(1, 0, 0.12, 0)
    bottomBar.Position = UDim2.new(0, 0, 0.88, 0)
    bottomBar.BackgroundColor3 = GUIManager.Colors.Background
    bottomBar.BorderSizePixel = 0
    bottomBar.Parent = screenGui

    -- Hatch Egg Button
    local hatchBtn = GUIManager.CreateButton("🥚 HATCH", UDim2.new(0.2, 0, 0.7, 0), UDim2.new(0.1, 0, 0.15, 0))
    hatchBtn.MouseButton1Click:Connect(function()
        GUIManager.CreateEggUI(player)
    end)
    hatchBtn.Parent = bottomBar

    -- Upgrade Button
    local upgradeBtn = GUIManager.CreateButton("⬆️ UPGRADE", UDim2.new(0.2, 0, 0.7, 0), UDim2.new(0.4, 0, 0.15, 0))
    upgradeBtn.Parent = bottomBar

    -- Rebirth Button
    local rebirthBtn = GUIManager.CreateButton("🔄 REBIRTH", UDim2.new(0.2, 0, 0.7, 0), UDim2.new(0.7, 0, 0.15, 0))
    rebirthBtn.Parent = bottomBar

    return screenGui
end

------------------------------------------------------------------
-- SHOP UI
------------------------------------------------------------------

function GUIManager.CreateShopUI(player)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ShopUI"
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = player:WaitForChild("PlayerGui")

    -- Background
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(0.8, 0, 0.8, 0)
    bg.Position = UDim2.new(0.1, 0, 0.1, 0)
    bg.BackgroundColor3 = GUIManager.Colors.Background
    bg.BorderSizePixel = 0
    bg.Parent = screenGui

    -- Title
    local title = GUIManager.CreateLabel("SHOP", UDim2.new(0.8, 0, 0.1, 0), UDim2.new(0.1, 0, 0.02, 0))
    title.Parent = bg

    -- Close Button
    local closeBtn = GUIManager.CreateButton("✕", UDim2.new(0.08, 0, 0.08, 0), UDim2.new(0.9, 0, 0.02, 0))
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    closeBtn.Parent = bg

    -- Scrollable Frame
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(0.9, 0, 0.75, 0)
    scroll.Position = UDim2.new(0.05, 0, 0.15, 0)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 6
    scroll.Parent = bg

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0.02, 0)
    layout.Parent = scroll

    -- Shop Items (Example)
    local items = {
        {Name = "Basic Egg", Price = 100, Currency = "Coins", Icon = "🥚"},
        {Name = "Rare Egg", Price = 500, Currency = "Coins", Icon = "🥚"},
        {Name = "Epic Egg", Price = 100, Currency = "Diamonds", Icon = "🥚"},
        {Name = "Speed Boost", Price = 500, Currency = "Coins", Icon = "⚡"},
        {Name = "100 Diamonds", Price = 50, Currency = "Robux", Icon = "💎"}
    }

    for i, item in ipairs(items) do
        local itemFrame = GUIManager.CreateShopItem(item)
        itemFrame.Position = UDim2.new(0, 0, 0, (i - 1) * 80)
        itemFrame.Parent = scroll
    end

    scroll.CanvasSize = UDim2.new(0, 0, 0, #items * 80 + 20)

    return screenGui
end

------------------------------------------------------------------
-- COLLECTION UI (Braidrots)
------------------------------------------------------------------

function GUIManager.CreateCollectionUI(player)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CollectionUI"
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = player:WaitForChild("PlayerGui")

    -- Background
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(0.8, 0, 0.8, 0)
    bg.Position = UDim2.new(0.1, 0, 0.1, 0)
    bg.BackgroundColor3 = GUIManager.Colors.Background
    bg.BorderSizePixel = 0
    bg.Parent = screenGui

    -- Title
    local title = GUIManager.CreateLabel("MY BRAIDROTS", UDim2.new(0.8, 0, 0.1, 0), UDim2.new(0.1, 0, 0.02, 0))
    title.Parent = bg

    -- Close Button
    local closeBtn = GUIManager.CreateButton("✕", UDim2.new(0.08, 0, 0.08, 0), UDim2.new(0.9, 0, 0.02, 0))
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    closeBtn.Parent = bg

    -- Grid
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(0.9, 0, 0.75, 0)
    scroll.Position = UDim2.new(0.05, 0, 0.15, 0)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 6
    scroll.Parent = bg

    local grid = Instance.new("UIGridLayout")
    grid.CellSize = UDim2.new(0.25, 0, 0.15, 0)
    grid.CellPadding = UDim2.new(0.02, 0, 0.02, 0)
    grid.Parent = scroll

    -- Placeholder Braidrots
    local placeholderNames = {"Rap-Rap-Rap", "Sagur", "Monkey Banana", "Shark Shoes", "Jerry", "Dragon with Cinnamon"}

    for i, name in ipairs(placeholderNames) do
        local card = GUIManager.CreateBraidrotCard(name)
        card.Parent = scroll
    end

    return screenGui
end

------------------------------------------------------------------
-- EGG UI
------------------------------------------------------------------

function GUIManager.CreateEggUI(player)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "EggUI"
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = player:WaitForChild("PlayerGui")

    -- Background
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(0.6, 0, 0.7, 0)
    bg.Position = UDim2.new(0.2, 0, 0.15, 0)
    bg.BackgroundColor3 = GUIManager.Colors.Background
    bg.BorderSizePixel = 0
    bg.Parent = screenGui

    -- Title
    local title = GUIManager.CreateLabel("HATCH EGGS", UDim2.new(0.8, 0, 0.1, 0), UDim2.new(0.1, 0, 0.02, 0))
    title.Parent = bg

    -- Close Button
    local closeBtn = GUIManager.CreateButton("✕", UDim2.new(0.08, 0, 0.08, 0), UDim2.new(0.9, 0, 0.02, 0))
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    closeBtn.Parent = bg

    -- Egg Options
    local eggs = {
        {Name = "Basic Egg", Price = 100, Color = Color3.fromRGB(144, 238, 144)},
        {Name = "Rare Egg", Price = 500, Color = Color3.fromRGB(100, 149, 237)},
        {Name = "Epic Egg", Price = 100, Color = Color3.fromRGB(147, 112, 219)},
        {Name = "Celestial Egg", Price = 500, Color = Color3.fromRGB(255, 215, 0)}
    }

    local yPos = 0.15
    for _, egg in ipairs(eggs) do
        local eggFrame = Instance.new("Frame")
        eggFrame.Size = UDim2.new(0.8, 0, 0.15, 0)
        eggFrame.Position = UDim2.new(0.1, 0, yPos, 0)
        eggFrame.BackgroundColor3 = egg.Color
        eggFrame.BorderSizePixel = 0
        eggFrame.Parent = bg

        local eggLabel = Instance.new("TextLabel")
        eggLabel.Size = UDim2.new(0.6, 0, 0.8, 0)
        eggLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
        eggLabel.BackgroundTransparency = 1
        eggLabel.Text = egg.Name
        eggLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
        eggLabel.Parent = eggFrame

        local buyBtn = GUIManager.CreateButton("Buy " .. egg.Price, UDim2.new(0.3, 0, 0.6, 0), UDim2.new(0.65, 0, 0.2, 0))
        buyBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        buyBtn.Parent = eggFrame

        yPos = yPos + 0.18
    end

    return screenGui
end

------------------------------------------------------------------
-- WORLD SELECT UI
------------------------------------------------------------------

function GUIManager.CreateWorldUI(player)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "WorldUI"
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = player:WaitForChild("PlayerGui")

    -- Background
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(0.7, 0, 0.8, 0)
    bg.Position = UDim2.new(0.15, 0, 0.1, 0)
    bg.BackgroundColor3 = GUIManager.Colors.Background
    bg.BorderSizePixel = 0
    bg.Parent = screenGui

    -- Title
    local title = GUIManager.CreateLabel("SELECT WORLD", UDim2.new(0.8, 0, 0.1, 0), UDim2.new(0.1, 0, 0.02, 0))
    title.Parent = bg

    -- Close Button
    local closeBtn = GUIManager.CreateButton("✕", UDim2.new(0.08, 0, 0.08, 0), UDim2.new(0.9, 0, 0.02, 0))
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    closeBtn.Parent = bg

    -- World List
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(0.9, 0, 0.75, 0)
    scroll.Position = UDim2.new(0.05, 0, 0.15, 0)
    scroll.BackgroundTransparency = 1
    scroll.ScrollBarThickness = 6
    scroll.Parent = bg

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0.02, 0)
    layout.Parent = scroll

    local worlds = {
        {Name = "🌨️ Ice World", Locked = false, Hazards = "Slippery"},
        {Name = "🌋 Lava World", Locked = true, Hazards = "Lava"},
        {Name = "🧪 Acid World", Locked = true, Hazards = "Acid"},
        {Name = "🔥 Fire World", Locked = true, Hazards = "Fire"},
        {Name = "🌊 Water World", Locked = true, Hazards = "Water"},
        {Name = "💨 Wind World", Locked = true, Hazards = "Wind"},
        {Name = "⚡ Electric World", Locked = true, Hazards = "Electric"},
        {Name = "💎 Diamond Universe", Locked = true, Hazards = "All"}
    }

    for i, world in ipairs(worlds) do
        local worldFrame = GUIManager.CreateWorldCard(world)
        worldFrame.Parent = scroll
    end

    scroll.CanvasSize = UDim2.new(0, 0, 0, #worlds * 80 + 20)

    return screenGui
end

------------------------------------------------------------------
-- PAUSE MENU
------------------------------------------------------------------

function GUIManager.CreatePauseMenu(player, currentGui)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "PauseMenu"
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = player:WaitForChild("PlayerGui")

    -- Background
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(0.4, 0, 0.6, 0)
    bg.Position = UDim2.new(0.3, 0, 0.2, 0)
    bg.BackgroundColor3 = GUIManager.Colors.Background
    bg.BorderSizePixel = 0
    bg.Parent = screenGui

    -- Title
    local title = GUIManager.CreateLabel("MENU", UDim2.new(0.8, 0, 0.1, 0), UDim2.new(0.1, 0, 0.02, 0))
    title.Parent = bg

    -- Resume Button
    local resumeBtn = GUIManager.CreateButton("RESUME", UDim2.new(0.6, 0, 0.1, 0), UDim2.new(0.2, 0, 0.2, 0))
    resumeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    resumeBtn.Parent = bg

    -- Main Menu Button
    local menuBtn = GUIManager.CreateButton("MAIN MENU", UDim2.new(0.6, 0, 0.1, 0), UDim2.new(0.2, 0, 0.35, 0))
    menuBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
        currentGui:Destroy()
        GUIManager.CreateMainMenu(player)
    end)
    menuBtn.Parent = bg

    -- Settings Button
    local settingsBtn = GUIManager.CreateButton("SETTINGS", UDim2.new(0.6, 0, 0.1, 0), UDim2.new(0.2, 0, 0.5, 0))
    settingsBtn.Parent = bg

    -- Quit Button
    local quitBtn = GUIManager.CreateButton("QUIT GAME", UDim2.new(0.6, 0, 0.1, 0), UDim2.new(0.2, 0, 0.65, 0))
    quitBtn.BackgroundColor3 = GUIManager.Colors.Danger
    quitBtn.MouseButton1Click:Connect(function()
        player:Kick("Thanks for playing!")
    end)
    quitBtn.Parent = bg

    return screenGui
end

------------------------------------------------------------------
-- HELPER FUNCTIONS
------------------------------------------------------------------

function GUIManager.CreateButton(text, size, position)
    local button = Instance.new("TextButton")
    button.Size = size
    button.Position = position
    button.BackgroundColor3 = GUIManager.Colors.Primary
    button.Text = text
    button.TextColor3 = GUIManager.Colors.Text
    button.Font = Enum.Font.FredokaOne
    button.TextScaled = true
    button.BorderSizePixel = 0

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.1, 0)
    corner.Parent = button

    return button
end

function GUIManager.CreateLabel(text, size, position)
    local label = Instance.new("TextLabel")
    label.Size = size
    label.Position = position
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = GUIManager.Colors.Accent
    label.TextScaled = true
    label.Font = Enum.Font.FredokaOne

    return label
end

function GUIManager.CreateShopItem(item)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.95, 0, 70, 0)
    frame.BackgroundColor3 = GUIManager.Colors.Secondary
    frame.BorderSizePixel = 0

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.05, 0)
    corner.Parent = frame

    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(0.15, 0, 0.8, 0)
    icon.Position = UDim2.new(0.02, 0, 0.1, 0)
    icon.BackgroundTransparency = 1
    icon.Text = item.Icon
    icon.TextScaled = true
    icon.Parent = frame

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(0.5, 0, 0.4, 0)
    nameLabel.Position = UDim2.new(0.2, 0, 0.1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = item.Name
    nameLabel.TextColor3 = GUIManager.Colors.Text
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = frame

    local priceLabel = Instance.new("TextLabel")
    priceLabel.Size = UDim2.new(0.3, 0, 0.4, 0)
    priceLabel.Position = UDim2.new(0.2, 0, 0.5, 0)
    priceLabel.BackgroundTransparency = 1
    priceLabel.Text = item.Currency .. " " .. item.Price
    priceLabel.TextColor3 = GUIManager.Colors.Accent
    priceLabel.TextXAlignment = Enum.TextXAlignment.Left
    priceLabel.Parent = frame

    local buyBtn = GUIManager.CreateButton("BUY", UDim2.new(0.25, 0, 0.6, 0), UDim2.new(0.72, 0, 0.2, 0))
    buyBtn.Parent = frame

    return frame
end

function GUIManager.CreateBraidrotCard(name)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.95, 0, 100, 0)
    frame.BackgroundColor3 = GUIManager.Colors.Secondary
    frame.BorderSizePixel = 0

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.05, 0)
    corner.Parent = frame

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(0.8, 0, 0.4, 0)
    nameLabel.Position = UDim2.new(0.1, 0, 0.1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.TextColor3 = GUIManager.Colors.Text
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = frame

    local levelLabel = Instance.new("TextLabel")
    levelLabel.Size = UDim2.new(0.3, 0, 0.3, 0)
    levelLabel.Position = UDim2.new(0.1, 0, 0.5, 0)
    levelLabel.BackgroundTransparency = 1
    levelLabel.Text = "Lv. 1"
    levelLabel.TextColor3 = GUIManager.Colors.Accent
    levelLabel.TextXAlignment = Enum.TextXAlignment.Left
    levelLabel.Parent = frame

    return frame
end

function GUIManager.CreateWorldCard(world)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.95, 0, 70, 0)
    frame.BackgroundColor3 = world.Locked and Color3.fromRGB(80, 80, 80) or GUIManager.Colors.Primary
    frame.BorderSizePixel = 0

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0.05, 0)
    corner.Parent = frame

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(0.6, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = world.Locked and "🔒 " .. world.Name or world.Name
    nameLabel.TextColor3 = GUIManager.Colors.Text
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = frame

    local hazardLabel = Instance.new("TextLabel")
    hazardLabel.Size = UDim2.new(0.4, 0, 0.3, 0)
    hazardLabel.Position = UDim2.new(0.05, 0, 0.5, 0)
    hazardLabel.BackgroundTransparency = 1
    hazardLabel.Text = "Hazards: " .. world.Hazards
    hazardLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    hazardLabel.TextXAlignment = Enum.TextXAlignment.Left
    hazardLabel.Parent = frame

    if not world.Locked then
        local playBtn = GUIManager.CreateButton("PLAY", UDim2.new(0.25, 0, 0.6, 0), UDim2.new(0.7, 0, 0.2, 0))
        playBtn.Parent = frame
    end

    return frame
end

------------------------------------------------------------------
-- UPDATE FUNCTIONS
------------------------------------------------------------------

function GUIManager.UpdateCoins(screenGui, amount)
    local label = screenGui:GetAttribute("CoinsLabel")
    if label then
        label.Text = "💰 " .. amount
    end
end

function GUIManager.UpdateDiamonds(screenGui, amount)
    local label = screenGui:GetAttribute("DiamondsLabel")
    if label then
        label.Text = "💎 " .. amount
    end
end

function GUIManager.UpdateCPS(screenGui, amount)
    local label = screenGui:GetAttribute("CPSLabel")
    if label then
        label.Text = "⚡ " .. amount .. "/sec"
    end
end

return GUIManager
