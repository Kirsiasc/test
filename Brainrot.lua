local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

local SETTINGS = {
    ESP_HIGHLIGHT = false,
    ESP_NAME = false,
}

local Window = OrionLib:MakeWindow({
    Name = "STREE HUB | Steal A Brainrot | v0.15.25",
    HidePremium = true,
    SaveConfig = true,
    ConfigFolder = "STREE HUB",
    Icon = "123032091977400",
    IntroEnabled = true,
    IntroText = "Welcome To Script STREE HUB",
    Theme = "Dark",
    CloseCallback = function()
        print("UI Closed!")
    end
})

-- HOME TAB
local HomeTab = Window:MakeTab({
    Name = "Home",
    Icon = "rbxassetid://124242667284964",
    PremiumOnly = false
})

local Section = HomeTab:AddSection({
    Name = "LINK STREE HUB"
})

HomeTab:AddButton({
    Name = "Discord",
    Callback = function()
        setclipboard("https://discord.gg/jdmX43t5mY")
        OrionLib:MakeNotification({
            Name = "Discord",
            Content = "Link Discord berhasil disalin!",
            Image = "rbxassetid://123032091977400",
            Time = 4
        })
    end
})

HomeTab:AddButton({
    Name = "WhatsApp",
    Callback = function()
        setclipboard("https://whatsapp.com/channel/0029VbAwRihKAwEtwyowt62N")
        OrionLib:MakeNotification({
            Name = "WhatsApp",
            Content = "Link WhatsApp berhasil disalin!",
            Image = "rbxassetid://123032091977400",
            Time = 4
        })
    end
})

-- UNIVERSAL TAB
local UniversalTab = Window:MakeTab({
    Name = "Game",
    Icon = "rbxassetid://453473360",
    PremiumOnly = false
})

UniversalTab:AddToggle({
    Name = "Noclip",
    Default = false,
    Callback = function(Value)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Kirsiasc/STREE-HUB/refs/heads/main/Noclip.lua"))()(Value)
    end
})

-- VISUAL TAB + ESP TOGGLE
local GameTab = Window:MakeTab({
    Name = "Visual",
    Icon = "rbxassetid://139410041229101",
    PremiumOnly = false
})

GameTab:AddToggle({
    Name = "ESP Highlight",
    Default = false,
    Callback = function(Value)
        SETTINGS.ESP_HIGHLIGHT = Value
    end
})

GameTab:AddToggle({
    Name = "ESP NameTag",
    Default = false,
    Callback = function(Value)
        SETTINGS.ESP_NAME = Value
    end
})

-- === ESP SYSTEM ===
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

RunService.RenderStepped:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Head") then
                -- ESP Highlight
                local highlight = character:FindFirstChild("STREE_HUB_HIGHLIGHT")
                if SETTINGS.ESP_HIGHLIGHT then
                    if not highlight then
                        local newHighlight = Instance.new("Highlight")
                        newHighlight.Name = "STREE_HUB_HIGHLIGHT"
                        newHighlight.FillColor = Color3.fromRGB(255, 0, 0)
                        newHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        newHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        newHighlight.Parent = character
                    end
                elseif highlight then
                    highlight:Destroy()
                end

                -- ESP NameTag
                local nameTag = character:FindFirstChild("STREE_HUB_NAME")
                if SETTINGS.ESP_NAME then
                    if not nameTag then
                        local billboard = Instance.new("BillboardGui")
                        billboard.Name = "STREE_HUB_NAME"
                        billboard.Size = UDim2.new(0, 200, 0, 50)
                        billboard.Adornee = character.Head
                        billboard.StudsOffset = Vector3.new(0, 2.5, 0)
                        billboard.AlwaysOnTop = true
                        billboard.Parent = character

                        local label = Instance.new("TextLabel")
                        label.Size = UDim2.new(1, 0, 1, 0)
                        label.BackgroundTransparency = 1
                        label.Text = player.DisplayName or player.Name
                        label.TextColor3 = Color3.fromRGB(255, 255, 255)
                        label.TextStrokeTransparency = 0
                        label.TextScaled = true
                        label.Font = Enum.Font.GothamBold
                        label.Parent = billboard
                    end
                elseif nameTag then
                    nameTag:Destroy()
                end
            else
                -- Cleanup jika karakter belum lengkap
                if character then
                    local cleanupHighlight = character:FindFirstChild("STREE_HUB_HIGHLIGHT")
                    if cleanupHighlight then cleanupHighlight:Destroy() end

                    local cleanupName = character:FindFirstChild("STREE_HUB_NAME")
                    if cleanupName then cleanupName:Destroy() end
                end
            end
        end
    end
end)

-- === INIT UI ===
OrionLib:Init()
