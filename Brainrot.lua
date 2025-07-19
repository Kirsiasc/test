local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

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

-- GAME TAB
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

-- VISUAL TAB
local GameTab = Window:MakeTab({
    Name = "Visual",
    Icon = "rbxassetid://139410041229101",
    PremiumOnly = false
})

GameTab:AddToggle({
    Name = "ESP Highlight",
    Default = false,
    Callback = function(Value)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Kirsiasc/STREE-HUB/refs/heads/main/ESPnametag.lua"))()(Value)
    end
})

GameTab:AddToggle({
    Name = "ESP NameTag",
    Default = false,
    Callback = function(Value)
        Loadstring(game:HttpGet("https://raw.githubusercontent.com/Kirsiasc/STREE-HUB/refs/heads/main/ESPnametag.lua")()(Value)
    end
})

-- OPTIONAL: ESP LOOP (Contoh visual ESP loop sederhana)
local RunService = game:GetService("RunService")

RunService.RenderStepped:Connect(function()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if SETTINGS.ESP_NAME then
                if not player.Character:FindFirstChild("NameBillboard") then
                    local bb = Instance.new("BillboardGui", player.Character)
                    bb.Name = "NameBillboard"
                    bb.Size = UDim2.new(0, 200, 0, 50)
                    bb.StudsOffset = Vector3.new(0, 3, 0)
                    bb.Adornee = player.Character:FindFirstChild("Head")
                    bb.AlwaysOnTop = true

                    local label = Instance.new("TextLabel", bb)
                    label.Size = UDim2.new(1, 0, 1, 0)
                    label.BackgroundTransparency = 1
                    label.Text = player.Name
                    label.TextColor3 = Color3.new(1, 1, 1)
                    label.TextScaled = true
                end
            else
                local bb = player.Character:FindFirstChild("NameBillboard")
                if bb then bb:Destroy() end
            end

            if SETTINGS.ESP_HIGHLIGHT then
                if not player.Character:FindFirstChildOfClass("Highlight") then
                    local hl = Instance.new("Highlight", player.Character)
                    hl.FillColor = Color3.new(1, 0, 0)
                    hl.OutlineColor = Color3.new(1, 1, 1)
                    hl.FillTransparency = 0.5
                    hl.OutlineTransparency = 0
                end
            else
                local hl = player.Character:FindFirstChildOfClass("Highlight")
                if hl then hl:Destroy() end
            end
        end
    end
end)

-- JANGAN HAPUS INIT
OrionLib:Init()
