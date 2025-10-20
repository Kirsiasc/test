local success, WindUI = pcall(function()
    return loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
end)

if not success or not WindUI then
    warn("⚠️ UI failed to load!")
    return
else
    print("✓ UI loaded successfully!")
end

local Window = WindUI:CreateWindow({
    Title = "AzarineHub",
    Icon = "rbxassetid://125586515064911",
    Author = "Fish It | V1.0.3",
    Folder = "AzarineHub",
    Size = default,
    LiveSearchDropdown = true,
})

Window:Tag({
    Title = "Free",
    Color = Color3.fromRGB(0, 255, 0),
})

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

_G.CustomJumpPower = 50
_G.InfiniteJump = false

local function getHumanoid()
    local character = Player.Character
    if character then
        return character:FindFirstChildOfClass("Humanoid")
    end
    return nil
end

local Tab1 = Window:Tab({
    Title = "Info",
    Icon = "info",
})

Tab1:Section({ 
    Title = "Script Info",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab1:Button({
    Title = "Discord",
    Desc = "Click to copy link",
    Callback = function()
        if setclipboard then
            setclipboard("https://discord.gg/8XhQ5Jaahp")
        end
    end
})

Tab1:Paragraph({
    Title = "Version",
    Desc = "V1.0.1",
})

Tab1:Paragraph({
    Title = "Developer",
    Desc = "@KirisaBall (under AzarineHub)",
})

Tab1:Paragraph({
    Title = "Want more scripts?",
    Desc = "Join our official discord server.",
})

local Tab2 = Window:Tab({
    Title = "Main",
    Icon = "landmark",
})

Tab2:Section({ 
    Title = "Main",
    TextXAlignment = "Left",
    TextSize = 17,
})

_G.AutoEquipRod = false
_G.AutoFishing = false
_G.AutoSell = false

Tab2:Toggle({
    Title = "Auto Equip Rod",
    Desc = "Always equip your rod automatically",
    Default = false,
    Callback = function(value)
        _G.AutoEquipRod = value
    end
})

spawn(function()
    while task.wait(1) do
        if _G.AutoEquipRod then
            pcall(function()
                local backpack = Player:FindFirstChild("Backpack")
                if backpack then
                    local rod = backpack:FindFirstChild("Rod") 
                        or backpack:FindFirstChild("FishingRod") 
                        or backpack:FindFirstChild("OldRod") 
                        or backpack:FindFirstChild("BasicRod")
                    if rod and Player.Character and not Player.Character:FindFirstChild(rod.Name) then
                        Player.Character.Humanoid:EquipTool(rod)
                    end
                end
            end)
        end
    end
end)

Tab2:Toggle({
    Title = "Auto Fishing",
    Desc = "Automatic Perfect Fishing",
    Default = false,
    Callback = function(value) 
        _G.AutoFishing = value
        WindUI:Notify({
            Title = "Notification",
            Content = "Started AutoFish Thread",
            Icon = "fish",
            Duration = 3,
        })
    end
})

local RepStorage = game:GetService("ReplicatedStorage")

spawn(function()
    while wait() do
        if _G.AutoFishing then
            pcall(function()
                local char = Player.Character or Player.CharacterAdded:Wait()
                if char:FindFirstChild("!!!FISHING_VIEW_MODEL!!!") then
                    RepStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/EquipToolFromHotbar"]:FireServer(1)
                end                    
                local cosmeticFolder = workspace:FindFirstChild("CosmeticFolder")
                if cosmeticFolder and not cosmeticFolder:FindFirstChild(tostring(Player.UserId)) then
                    RepStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/ChargeFishingRod"]:InvokeServer(2)
                    wait(0.5)
                    RepStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/RequestFishingMinigameStarted"]:InvokeServer(1, 1)
                end
            end)
        end
    end
end)

spawn(function()
    while wait() do
        if _G.AutoFishing then
            pcall(function()
                RepStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/FishingCompleted"]:FireServer()
            end)
        end
    end
end)

Tab2:Toggle({
    Title = "Auto Sell",
    Desc = "Always sell your new fish",
    Default = false,
    Callback = function(state)
        _G.AutoSell = state
        task.spawn(function()
            while _G.AutoSell do
                task.wait(0.5)
                local rs = game:GetService("ReplicatedStorage")
                for _, v in pairs(rs:GetDescendants()) do
                    if v:IsA("RemoteEvent") and v.Name:lower():find("sell") then
                        v:FireServer()
                    elseif v:IsA("RemoteFunction") and v.Name:lower():find("sell") then
                        pcall(function()
                            v:InvokeServer()
                        end)
                    end
                end
            end
        end)
    end
})

Tab2:Toggle({    
    Title = "Radar",    
    Desc = "Toggle fishing radar",    
    Icon = false,    
    Type = false,    
    Default = false,    
    Callback = function(state)    
        local ReplicatedStorage = game:GetService("ReplicatedStorage")    
        local Lighting = game:GetService("Lighting")    
        local Replion = require(ReplicatedStorage.Packages.Replion)    
        local Net = require(ReplicatedStorage.Packages.Net)    
        local spr = require(ReplicatedStorage.Packages.spr)    
        local Soundbook = require(ReplicatedStorage.Shared.Soundbook)    
        local ClientTimeController = require(ReplicatedStorage.Controllers.ClientTimeController)    
        local TextNotificationController = require(ReplicatedStorage.Controllers.TextNotificationController)    
        local RemoteRadar = Net:RemoteFunction("UpdateFishingRadar")    
        local Data = Replion.Client:GetReplion("Data")    
        if Data then    
            if RemoteRadar:InvokeServer(state) then    
                Soundbook.Sounds.RadarToggle:Play().PlaybackSpeed = 1 + math.random() * 0.3    
                local effect = Lighting:FindFirstChildWhichIsA("ColorCorrectionEffect")    
                if effect then    
                    spr.stop(effect)    
                    local profile = ClientTimeController:_getLightingProfile()    
                    local cc = (profile and profile.ColorCorrection) and profile.ColorCorrection or {}    
                    if not cc.Brightness then cc.Brightness = 0.04 end    
                    if not cc.TintColor then cc.TintColor = Color3.fromRGB(255, 255, 255) end    
                    effect.TintColor = Color3.fromRGB(42, 226, 118)    
                    effect.Brightness = 0.4    
                    spr.target(effect, 1, 1, cc)    
                end    
                spr.stop(Lighting)    
                Lighting.ExposureCompensation = 1    
                spr.target(Lighting, 1, 2, {    
                    ["ExposureCompensation"] = 0    
                })    
                TextNotificationController:DeliverNotification({    
                    ["Type"] = "Text",    
                    ["Text"] = ("Radar: %s"):format(state and "Enabled" or "Disabled"),    
                    ["TextColor"] = state and {R = 9, G = 255, B = 0} or {R = 255, G = 0, B = 0}    
                })    
            end    
        end    
    end    
})

local Tab3 = Window:Tab({
    Title = "Shop",
    Icon = "badge-dollar-sign",
})

local ReplicatedStorage = game:GetService("ReplicatedStorage")  
local RFPurchaseFishingRod = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/PurchaseFishingRod"]  

local rods = {  
    ["Luck Rod"] = 79,  
    ["Carbon Rod"] = 76,  
    ["Grass Rod"] = 85,  
    ["Demascus Rod"] = 77,  
    ["Ice Rod"] = 78,  
    ["Lucky Rod"] = 4,  
    ["Midnight Rod"] = 80,  
    ["Steampunk Rod"] = 6,  
    ["Chrome Rod"] = 7,  
    ["Astral Rod"] = 5,  
    ["Ares Rod"] = 126,  
    ["Angler Rod"] = 168,
    ["Bamboo Rod"] = 258
}  

local rodNames = {  
    "Luck Rod (350 Coins)", "Carbon Rod (900 Coins)", "Grass Rod (1.5k Coins)", "Demascus Rod (3k Coins)",  
    "Ice Rod (5k Coins)", "Lucky Rod (15k Coins)", "Midnight Rod (50k Coins)", "Steampunk Rod (215k Coins)",  
    "Chrome Rod (437k Coins)", "Astral Rod (1M Coins)", "Ares Rod (3M Coins)", "Angler Rod (8M Coins)",
    "Bamboo Rod (12M Coins)"
}  

local rodKeyMap = {  
    ["Luck Rod (350 Coins)"] = "Luck Rod",  
    ["Carbon Rod (900 Coins)"] = "Carbon Rod",  
    ["Grass Rod (1.5k Coins)"] = "Grass Rod",  
    ["Demascus Rod (3k Coins)"] = "Demascus Rod",  
    ["Ice Rod (5k Coins)"] = "Ice Rod",  
    ["Lucky Rod (15k Coins)"] = "Lucky Rod",  
    ["Midnight Rod (50k Coins)"] = "Midnight Rod",  
    ["Steampunk Rod (215k Coins)"] = "Steampunk Rod",  
    ["Chrome Rod (437k Coins)"] = "Chrome Rod",  
    ["Astral Rod (1M Coins)"] = "Astral Rod",  
    ["Ares Rod (3M Coins)"] = "Ares Rod",  
    ["Angler Rod (8M Coins)"] = "Angler Rod",
    ["Bamboo Rod (12M Coins)"] = "Bamboo Rod"
}  

local selectedRod = rodNames[1]  

Tab3:Dropdown({  
    Title = "Select Rod",  
    Values = rodNames,  
    Value = selectedRod,  
    Callback = function(value)  
        selectedRod = value  
        WindUI:Notify({Title = "Rod Selected", Content = value, Duration = 3})  
    end  
})  

Tab3:Button({  
    Title = "Buy Rod",  
    Callback = function()  
        local key = rodKeyMap[selectedRod]  
        if key and rods[key] then  
            local success, err = pcall(function()  
                RFPurchaseFishingRod:InvokeServer(rods[key])  
            end)  
            if success then  
                WindUI:Notify({Title = "Rod Purchase", Content = "Purchased " .. selectedRod, Duration = 3})  
            else  
                WindUI:Notify({Title = "Rod Purchase Error", Content = tostring(err), Duration = 5})  
            end  
        end  
    end  
})

local baits = {
    ["Common Bait"] = 1,
    ["Uncommon Bait"] = 2,
    ["Rare Bait"] = 3,
    ["Epic Bait"] = 4,
    ["Legendary Bait"] = 5
}

local baitNames = {
    "Common Bait (50 Coins)",
    "Uncommon Bait (100 Coins)",
    "Rare Bait (200 Coins)",
    "Epic Bait (500 Coins)",
    "Legendary Bait (1000 Coins)"
}

local baitKeyMap = {
    ["Common Bait (50 Coins)"] = "Common Bait",
    ["Uncommon Bait (100 Coins)"] = "Uncommon Bait",
    ["Rare Bait (200 Coins)"] = "Rare Bait",
    ["Epic Bait (500 Coins)"] = "Epic Bait",
    ["Legendary Bait (1000 Coins)"] = "Legendary Bait"
}

local selectedBait = baitNames[1]

local function NotifyInfo(title, content)
    WindUI:Notify({
        Title = title,
        Content = content,
        Icon = "info",
        Duration = 3
    })
end

local function NotifySuccess(title, content)
    WindUI:Notify({
        Title = title,
        Content = content,
        Icon = "check",
        Duration = 3
    })
end

local function NotifyError(title, content)
    WindUI:Notify({
        Title = title,
        Content = content,
        Icon = "octagon-x",
        Duration = 3
    })
end

Tab3:Paragraph({
    Title = "Test Feature",
    Desc = "This is still in testing, maybe the next update can be used.",
})

Tab3:Section({
    Title = "Baits",
    Icon = "bug"
})

Tab3:Dropdown({
    Title = "Select Bait",
    Values = baitNames,
    Value = selectedBait,
    Callback = function(value)
        selectedBait = value
        NotifyInfo("Bait Selected", value)
    end
})

Tab3:Button({
    Title = "Buy Bait",
    Callback = function()
        local key = baitKeyMap[selectedBait]
        if key and baits[key] then
            local amount = baits[key]
            local RFPurchaseBait = RepStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/PurchaseBait"]
            if RFPurchaseBait then
                local success, err = pcall(function()
                    RFPurchaseBait:InvokeServer(amount)
                end)
                if success then
                    NotifySuccess("Bait Purchase", "Purchased " .. selectedBait .. " x" .. amount)
                else
                    NotifyError("Bait Purchase Error", tostring(err))
                end
            end
        end
    end
})

local weathers = {
    ["Rain"] = 1,
    ["Fog"] = 2,
    ["Snow"] = 3
}

local weatherNames = {
    "Rain (500 Coins)",
    "Fog (750 Coins)",
    "Snow (1000 Coins)"
}

local weatherKeyMap = {
    ["Rain (500 Coins)"] = "Rain",
    ["Fog (750 Coins)"] = "Fog",
    ["Snow (1000 Coins)"] = "Snow"
}

local selectedWeathers = {}

Tab3:Section({
    Title = "Weather Events",
    Icon = "cloud"
})

Tab3:Dropdown({
    Title = "Select Weathers",
    Values = weatherNames,
    Multi = true,
    Value = selectedWeathers,
    Callback = function(values)
        selectedWeathers = values
        NotifyInfo("Weather Selected", "Selected " .. #values .. " weather(s)")
    end
})

Tab3:Button({
    Title = "Buy Weather",
    Callback = function()
        for _, weatherName in ipairs(selectedWeathers) do
            local key = weatherKeyMap[weatherName]
            if key and weathers[key] then
                local RFPurchaseWeatherEvent = RepStorage.Packages._Index["sleitnick_net@0.2.0"].net["RF/PurchaseWeatherEvent"]
                if RFPurchaseWeatherEvent then
                    local success, err = pcall(function()
                        RFPurchaseWeatherEvent:InvokeServer(key)
                    end)
                    if success then
                        NotifySuccess("Weather Purchase", "Purchased " .. weatherName)
                    else
                        NotifyError("Weather Purchase Error", tostring(err))
)
                    end
                end
            end
        end
    end
})

local Tab4 = Window:Tab({
    Title = "Teleport",
    Icon = "map-pin",
})

local Section = Tab4:Section({ 
    Title = "Island",
    Icon = "tree-palm"
})

local IslandLocations = {
    ["Ancient Jungle"] = Vector3.new(1252, 7, -153),
    ["Coral Reefs"] = Vector3.new(-2855, 47, 1996),
    ["Enchant Room"] = Vector3.new(3221, -1303, 1406),
    ["Esoteric Island"] = Vector3.new(1990, 5, 1398),
    ["Konoha"] = Vector3.new(-603, 3, 719),
    ["Treasure Room"] = Vector3.new(-3600, -267, -1575),
    ["Tropical Grove"] = Vector3.new(-2091, 6, 3703),
    ["Weather Machine"] = Vector3.new(-1508, 6, 1895),
}

local SelectedIsland = nil

local IslandDropdown = Tab4:Dropdown({
    Title = "Select Island",
    Values = (function()
        local keys = {}
        for name in pairs(IslandLocations) do
            table.insert(keys, name)
        end
        table.sort(keys)
        return keys
    end)(),
    Callback = function(Value)
        SelectedIsland = Value
    end
})

Tab4:Button({
    Title = "Teleport to Island",
    Callback = function()
        if SelectedIsland and IslandLocations[SelectedIsland] and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(IslandLocations[SelectedIsland])
        end
    end
})

local Section = Tab4:Section({ 
    Title = "Fishing Spot",
    Icon = "fish"
})

local FishingLocations = {
    ["Coral Reefs"] = Vector3.new(-2855, 47, 1996),
    ["Konoha"] = Vector3.new(-603, 3, 719),
    ["Levers 1"] = Vector3.new(1475, 4, -847),
    ["Levers 2"] = Vector3.new(882, 5, -321),
    ["Levers 3"] = Vector3.new(1425, 6, 126),
    ["Levers 4"] = Vector3.new(1837, 4, -309),
    ["Sacred Temple"] = Vector3.new(1475, -22, -632),
    ["Spawn"] = Vector3.new(33, 9, 2810),
    ["Sisyphus Statue"] = Vector3.new(-3693, -136, -1045),
    ["Underground Cellar"] = Vector3.new(2135, -92, -695),
    ["Volcano"] = Vector3.new(-632, 55, 197),
}

local SelectedFishing = nil

local FishingDropdown = Tab4:Dropdown({
    Title = "Select Spot",
    Values = (function()
        local keys = {}
        for name in pairs(FishingLocations) do
            table.insert(keys, name)
        end
        table.sort(keys)
        return keys
    end)(),
    Callback = function(Value)
        SelectedFishing = Value
    end
})

Tab4:Button({
    Title = "Teleport to Fishing Spot",
    Callback = function()
        if SelectedFishing and FishingLocations[SelectedFishing] and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(FishingLocations[SelectedFishing])
        end
    end
})

local Section = Tab4:Section({
    Title = "Location NPC",
    Icon = "bot"
})

local NPC_Locations = {
    ["Alex"] = Vector3.new(43, 17, 2876),
    ["Aura kid"] = Vector3.new(70, 17, 2835),
    ["Billy Bob"] = Vector3.new(84, 17, 2876),
    ["Boat Expert"] = Vector3.new(32, 9, 2789),
    ["Esoteric Gatekeeper"] = Vector3.new(2101, -30, 1350),
    ["Jeffery"] = Vector3.new(-2771, 4, 2132),
    ["Joe"] = Vector3.new(144, 20, 2856),
    ["Jones"] = Vector3.new(-671, 16, 596),
    ["Lava Fisherman"] = Vector3.new(-593, 59, 130),
    ["McBoatson"] = Vector3.new(-623, 3, 719),
    ["Ram"] = Vector3.new(-2838, 47, 1962),
    ["Ron"] = Vector3.new(-48, 17, 2856),
    ["Scott"] = Vector3.new(-19, 9, 2709),
    ["Scientist"] = Vector3.new(-6, 17, 2881),
    ["Seth"] = Vector3.new(107, 17, 2877),
    ["Silly Fisherman"] = Vector3.new(97, 9, 2694),
    ["Tim"] = Vector3.new(-604, 16, 609),
}

local SelectedNPC = nil

local NPCDropdown = Tab4:Dropdown({
    Title = "Select NPC",
    Values = (function()
        local keys = {}
        for name in pairs(NPC_Locations) do
            table.insert(keys, name)
        end
        table.sort(keys)
        return keys
    end)(),
    Callback = function(Value)
        SelectedNPC = Value
    end
})

Tab4:Button({
    Title = "Teleport to NPC",
    Callback = function()
        if SelectedNPC and NPC_Locations[SelectedNPC] and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(NPC_Locations[SelectedNPC])
        end
    end
})

local Section = Tab4:Section({
    Title = "Event Teleport",
    Icon = "antenna"
})

local Event_Locations = {
    ["Black Hole"] = Vector3.new(883, -1.4, 2542),
    ["Ghost Shark Hunt"] = Vector3.new(489.559, -1.35, 25.406),
    ["Megalodon Hunt"] = Vector3.new(-1076.3, -1.4, 1676.2),
    ["Meteor Rain"] = Vector3.new(383, -1.4, 2452),
    ["Shark Hunt"] = Vector3.new(1.65, -1.35, 2095.725),
    ["Storm Hunt"] = Vector3.new(1735.85, -1.4, -208.425),
    ["Worm Hunt"] = Vector3.new(1591.55, -1.4, -105.925),
}

local ActiveEvent = nil

local EventDropdown = Tab4:Dropdown({
    Title = "Select Event",
    Values = (function()
        local keys = {}
        for name in pairs(Event_Locations) do
            table.insert(keys, name)
        end
        table.sort(keys)
        return keys
    end)(),
    Callback = function(Value)
        ActiveEvent = Value
    end
})

Tab4:Button({
    Title = "Teleport to Event",
    Callback = function()
        local Player = game.Players.LocalPlayer
        local Char = Player.Character or Player.CharacterAdded:Wait()
        local HRP = Char:FindFirstChild("HumanoidRootPart")
        if not HRP then return end
        if ActiveEvent and Event_Locations[ActiveEvent] then
            HRP.CFrame = CFrame.new(Event_Locations[ActiveEvent])
        end
    end
})

local Tab5 = Window:Tab({
    Title = "Players",
    Icon = "user",
})

Tab5:Input({
    Title = "WalkSpeed",
    Desc = "Minimum 16 speed",
    Value = "16",
    Type = "Input",
    Placeholder = "Enter number...",
    Callback = function(input) 
        local speed = tonumber(input)
        local humanoid = getHumanoid()
        if humanoid then
            if speed and speed >= 16 then
                humanoid.WalkSpeed = speed
                print("WalkSpeed set to: " .. speed)
            else
                humanoid.WalkSpeed = 16
                print("⚠️ Invalid input, set to default (16)")
            end
        end
    end
})

Tab5:Input({
    Title = "Jump Power",
    Desc = "Minimum 50 jump",
    Value = "50",
    Type = "Input",
    Placeholder = "Enter number...",
    Callback = function(input) 
        local value = tonumber(input)
        if value and value >= 50 then
            _G.CustomJumpPower = value
            local humanoid = getHumanoid()
            if humanoid then
                humanoid.UseJumpPower = true
                humanoid.JumpPower = value
            end
            print("Jump Power set to: " .. value)
        else
            warn("⚠️ Must be number and minimum 50!")
        end
    end
})

Tab5:Button({
    Title = "Reset Jump Power",
    Desc = "Return Jump Power to normal (50)",
    Callback = function()
        _G.CustomJumpPower = 50
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.UseJumpPower = true
            humanoid.JumpPower = 50
        end
        print("🔄 Jump Power reset to 50")
    end
})

Player.CharacterAdded:Connect(function(char)
    local humanoid = char:WaitForChild("Humanoid")
    humanoid.UseJumpPower = true
    humanoid.JumpPower = _G.CustomJumpPower or 50
end)

Tab5:Button({
    Title = "Reset Speed",
    Desc = "Return speed to normal (16)",
    Callback = function()
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.WalkSpeed = 16
            print("WalkSpeed reset to default (16)")
        end
    end
})

Tab5:Toggle({
    Title = "Infinite Jump",
    Desc = "Activate to use infinite jump",
    Type = "Checkbox",
    Default = false,
    Callback = function(state) 
        _G.InfiniteJump = state
        if state then
            print("✅ Infinite Jump Active")
        else
            print("❌ Infinite Jump Inactive")
        end
    end
})

UserInputService.JumpRequest:Connect(function()
    if _G.InfiniteJump then
        local humanoid = getHumanoid()
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

local Tab6 = Window:Tab({
    Title = "Misc",
    Icon = "settings",
})

_G.AntiAFK = false
_G.AutoReconnect = false

Tab6:Toggle({
    Title = "AntiAFK",
    Desc = "Prevent Roblox from kicking you when idle",
    Default = false,
    Callback = function(state)
        _G.AntiAFK = state
        local VirtualUser = game:GetService("VirtualUser")

        if state then
            task.spawn(function()
                while _G.AntiAFK do
                    task.wait(60)
                    pcall(function()
                        VirtualUser:CaptureController()
                        VirtualUser:ClickButton2(Vector2.new())
                    end)
                end
            end)

            WindUI:Notify({
                Title = "AntiAFK loaded!",
                Content = "Coded By Kirsiasc",
                Duration = 5
            })
        else
            WindUI:Notify({
                Title = "AntiAFK Disabled",
                Content = "Stopped AntiAFK",
                Duration = 3
            })
        end
    end
})

Tab6:Toggle({
    Title = "Auto Reconnect",
    Desc = "Automatic reconnect if disconnected",
    Default = false,
    Callback = function(state)
        _G.AutoReconnect = state
        if state then
            task.spawn(function()
                while _G.AutoReconnect do
                    task.wait(2)
                    local reconnectUI = game:GetService("CoreGui"):FindFirstChild("RobloxPromptGui")
                    if reconnectUI then
                        local prompt = reconnectUI:FindFirstChild("promptOverlay")
                        if prompt then
                            local button = prompt:FindFirstChild("ButtonPrimary")
                            if button and button.Visible then
                                firesignal(button.MouseButton1Click)
                            end
                        end
                    end
                end
            end)
        end
    end
})

local BlackScreenGui = Instance.new("ScreenGui")
BlackScreenGui.Name = "BlackScreenGui"
BlackScreenGui.Parent = game:GetService("CoreGui")
BlackScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
BlackScreenGui.ResetOnSpawn = false
BlackScreenGui.IgnoreGuiInset = true

local BlackFrame = Instance.new("Frame")
BlackFrame.Size = UDim2.new(1, 0, 1, 0)
BlackFrame.Position = UDim2.new(0, 0, 0, 0)
BlackFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BlackFrame.BackgroundTransparency = 1
BlackFrame.ZIndex = 999999
BlackFrame.Parent = BlackScreenGui

local Logo = Instance.new("ImageLabel")
Logo.Size = UDim2.new(0, 200, 0, 200)
Logo.Position = UDim2.new(0.5, -100, 0.3, -100)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://125586515064911"
Logo.ZIndex = 1000000
Logo.Parent = BlackFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 400, 0, 50)
Title.Position = UDim2.new(0.5, -200, 0.5, 0)
Title.BackgroundTransparency = 1
Title.Text = "Azarine Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 48
Title.Font = Enum.Font.SourceSansBold
Title.ZIndex = 1000000
Title.Parent = BlackFrame

local DiscordLink = Instance.new("TextLabel")
DiscordLink.Size = UDim2.new(0, 400, 0, 30)
DiscordLink.Position = UDim2.new(0.5, -200, 0.6, 0)
DiscordLink.BackgroundTransparency = 1
DiscordLink.Text = "discord.gg/8XhQ5Jaahp"
DiscordLink.TextColor3 = Color3.fromRGB(114, 137, 218)
DiscordLink.TextSize = 24
DiscordLink.Font = Enum.Font.SourceSans
DiscordLink.ZIndex = 1000000
DiscordLink.Parent = BlackFrame

_G.BlackScreenEnabled = false

Tab6:Toggle({
    Title = "Black Screen",
    Desc = "Toggles a full black screen with logo and Discord link",
    Default = false,
    Callback = function(state)
        _G.BlackScreenEnabled = state
        if state then
            BlackFrame.BackgroundTransparency = 0
            Logo.Visible = true
            Title.Visible = true
            DiscordLink.Visible = true
            print("Layar hitam DIAKTIFKAN")
        else
            BlackFrame.BackgroundTransparency = 1
            Logo.Visible = false
            Title.Visible = false
            DiscordLink.Visible = false
            print("Layar hitam DINONAKTIFKAN")
        end
    end
})

local Section = Tab6:Section({ 
    Title = "Config",
    Icon = "folder-open"
})

local ConfigFolder = "AzarineHub/Configs"
if not isfolder("AzarineHub") then makefolder("AzarineHub") end
if not isfolder(ConfigFolder) then makefolder(ConfigFolder) end

local ConfigName = "default.json"

local function GetConfig()
    local humanoid = getHumanoid()
    return {
        WalkSpeed = humanoid and humanoid.WalkSpeed or 16,
        JumpPower = _G.CustomJumpPower or 50,
        InfiniteJump = _G.InfiniteJump or false,
        AutoSell = _G.AutoSell or false,
        AutoFishing = _G.AutoFishing or false,
        AntiAFK = _G.AntiAFK or false,
        AutoReconnect = _G.AutoReconnect or false,
    }
end

local function ApplyConfig(data)
    local humanoid = getHumanoid()
    if data.WalkSpeed and humanoid then 
        humanoid.WalkSpeed = data.WalkSpeed 
    end
    if data.JumpPower then
        _G.CustomJumpPower = data.JumpPower
        if humanoid then
            humanoid.UseJumpPower = true
            humanoid.JumpPower = data.JumpPower
        end
    end
    if data.InfiniteJump ~= nil then
        _G.InfiniteJump = data.InfiniteJump
    end
    if data.AutoSell ~= nil then
        _G.AutoSell = data.AutoSell
    end
    if data.AutoFishing ~= nil then
        _G.AutoFishing = data.AutoFishing
    end
    if data.AntiAFK ~= nil then
        _G.AntiAFK = data.AntiAFK
    end
    if data.AutoReconnect ~= nil then
        _G.AutoReconnect = data.AutoReconnect
    end
end

Tab6:Button({
    Title = "Save Config",
    Desc = "Save all settings",
    Callback = function()
        local data = GetConfig()
        writefile(ConfigFolder .. "/" .. ConfigName, game:GetService("HttpService"):JSONEncode(data))
        print("✅ Config saved!")
    end
})

Tab6:Button({
    Title = "Load Config",
    Desc = "Use saved config",
    Callback = function()
        if isfile(ConfigFolder .. "/" .. ConfigName) then
            local data = readfile(ConfigFolder .. "/" .. ConfigName)
            local decoded = game:GetService("HttpService"):JSONDecode(data)
            ApplyConfig(decoded)
            print("✅ Config applied!")
        else
            warn("⚠️ Config not found, please Save first.")
        end
    end
})

Tab6:Button({
    Title = "Delete Config",
    Desc = "Delete saved config",
    Callback = function()
        if isfile(ConfigFolder .. "/" .. ConfigName) then
            delfile(ConfigFolder .. "/" .. ConfigName)
            print("🗑 Config deleted!")
        else
            warn("⚠️ No config to delete.")
        end
    end
})

Tab6:Button({
    Title = "Infinite Yield",
    Desc = "Other Scripts",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/DarkNetworks/Infinite-Yield/main/latest.lua'))()
    end
})
