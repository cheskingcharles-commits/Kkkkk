
-- CHES HUB 1.0
-- Coloque em StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")

local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "ChesHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(260, 300)
main.Position = UDim2.new(0.5, -130, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
main.Parent = gui

Instance.new("UICorner", main).CornerRadius =
    UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 48)
title.BackgroundColor3 = Color3.fromRGB(190, 25, 40)
title.Text = "🔥 CHES HUB"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 22
title.Font = Enum.Font.GothamBold
title.Parent = main

local function createButton(name, position)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -30, 0, 42)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 14
    button.Font = Enum.Font.GothamBold
    button.Text = name
    button.Parent = main

    Instance.new("UICorner", button).CornerRadius =
        UDim.new(0, 8)

    return button
end

-- SPEED BOOST

local speedEnabled = false

local speedButton = createButton(
    "Speed Boost: OFF",
    UDim2.fromOffset(15, 65)
)

local function updateSpeed()
    local character = player.Character
    local humanoid = character and
        character:FindFirstChildOfClass("Humanoid")

    if humanoid then
        humanoid.WalkSpeed = speedEnabled and 24 or 16
    end
end

speedButton.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    speedButton.Text = speedEnabled and
        "Speed Boost: ON" or "Speed Boost: OFF"
    updateSpeed()
end)

player.CharacterAdded:Connect(function()
    task.wait(1)
    updateSpeed()
end)

-- RARE ITEM ESP
-- Marque objetos com a tag "RareItem"
-- no Roblox Studio.

local espEnabled = false
local highlights = {}

local espButton = createButton(
    "Rare Item ESP: OFF",
    UDim2.fromOffset(15, 120)
)

local function clearHighlights()
    for _, highlight in pairs(highlights) do
        highlight:Destroy()
    end
    table.clear(highlights)
end

local function refreshESP()
    clearHighlights()

    if not espEnabled then
        return
    end

    for _, object in ipairs(
        CollectionService:GetTagged("RareItem")
    ) do
        if object:IsDescendantOf(workspace) then
            local highlight = Instance.new("Highlight")
            highlight.FillColor =
                Color3.fromRGB(255, 30, 30)
            highlight.OutlineColor =
                Color3.fromRGB(255, 255, 255)
            highlight.Adornee = object
            highlight.Parent = object

            table.insert(highlights, highlight)
        end
    end
end

espButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled

    espButton.Text = espEnabled and
        "Rare Item ESP: ON" or "Rare Item ESP: OFF"

    refreshESP()
end)

-- CLOSE MENU

local closeButton = createButton(
    "FECHAR HUB",
    UDim2.fromOffset(15, 175)
)

closeButton.MouseButton1Click:Connect(function()
    gui.Enabled = false
end)

local reopen = Instance.new("TextButton")
reopen.Size = UDim2.fromOffset(100, 38)
reopen.Position = UDim2.new(0, 15, 0.5, 0)
reopen.BackgroundColor3 = Color3.fromRGB(190, 25, 40)
reopen.Text = "CHES HUB"
reopen.TextColor3 = Color3.new(1, 1, 1)
reopen.Parent = gui

reopen.MouseButton1Click:Connect(function()
    gui.Enabled = true
end)
