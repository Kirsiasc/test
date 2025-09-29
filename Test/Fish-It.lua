local success, WindUI = pcall(function()
    return loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
end)

if not success or not WindUI then
    warn("âš ï¸ UI failed to load!")
    return
else
    print("âœ“ UI loaded successfully!")
end

local Window = WindUI:CreateWindow({
    Title = "AzarineHub",
    Icon = "rbxassetid://125586515064911",
    Author = " Fish It | Version ",
    Folder = "AzarineHub",
    Size = default,
    LiveSearchDropdown = true,
})

Window:Tag({
    Title = "Free",
    Color = Color3.fromRGB(0, 255, 0),
})

Window:Tag({
    Title = "Developer",
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

local Tab3 = Window:Tab({
    Title = "Shop",
    Icon = "badge-dollar-sign",
})

local rodNames = {"Basic Rod", "Old Rod", "Fishing Rod"}
local selectedRod = "Basic Rod"
local rodKeyMap = {
    ["Basic Rod"] = "basic",
    ["Old Rod"] = "old", 
    ["Fishing Rod"] = "fishing"
}
local rods = {
    basic = 1,
    old = 2,
    fishing = 3
}

local baitNames = {"Basic Bait", "Advanced Bait", "Pro Bait"}
local selectedBait = "Basic Bait"
local baitKeyMap = {
    ["Basic Bait"] = "basic",
    ["Advanced Bait"] = "advanced",
    ["Pro Bait"] = "pro"
}
local baits = {
    basic = 10,
    advanced = 20,
    pro = 30
}

local weatherNames = {"Rain", "Storm", "Sunny"}
local selectedWeathers = {}
local weatherKeyMap = {
    ["Rain"] = "rain",
    ["Storm"] = "storm", 
    ["Sunny"] = "sunny"
}
local weathers = {
    rain = 1,
    storm = 2,
    sunny = 3
}

local function NotifyInfo(title, content)
    AzarineUI:Notify({
        Title = title,
        Content = content,
		Icon = "info",
        Duration = 3
    })
end

local function NotifySuccess(title, content)
    AzarineUI:Notify({
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

Tab3:Section({
    Title = "Fishing Rods",
    Icon = "fish"
})

Tab3:Dropdown({
    Title = "Select Rod",
    Values = rodNames,
    Value = selectedRod,
    Callback = function(value)
        selectedRod = value
        NotifyInfo("Rod Selected", value)
    end
})

Tab3:Button({
    Title = "Buy Rod",
    Callback = function()
        local key = rodKeyMap[selectedRod]
        if key and rods[key] then
            local RFPurchaseFishingRod = RepStorage:FindFirstChild("RFPurchaseFishingRod")
            if RFPurchaseFishingRod then
                local success, err = pcall(function()
                    RFPurchaseFishingRod:InvokeServer(rods[key])
                end)
                if success then
                    NotifySuccess("Rod Purchase", "Purchased " .. selectedRod)
                else
                    NotifyError("Rod Purchase Error", tostring(err))
                end
            end
        end
    end
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
            local RFPurchaseBait = RepStorage:FindFirstChild("RFPurchaseBait")
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

Tab3:Section({
    Title = "Weather Events",
    Icon = "cloud"
})

Tab3:Dropdown({
    Title = "Select Weather(s)",
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
                local RFPurchaseWeatherEvent = RepStorage:FindFirstChild("RFPurchaseWeatherEvent")
                if RFPurchaseWeatherEvent then
                    local success, err = pcall(function()
                        RFPurchaseWeatherEvent:InvokeServer(key)
                    end)
                    if success then
                        NotifySuccess("Weather Purchase", "Purchased " .. weatherName)
                    else
                        NotifyError("Weather Purchase Error", tostring(err))
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

Tab4:Section({ 
    Title = "Island",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab4:Dropdown({
    Title = "Select Location",
    Values = {"Esoteric Island", "Konoha", "Coral Refs", "Enchant Room", "Tropical Grove", "Weather Machine", "Treasure Room"},
    Callback = function(Value)
        local Locations = {
            ["Esoteric Island"] = Vector3.new(1990, 5, 1398),
            ["Konoha"] = Vector3.new(-603, 3, 719),
            ["Coral Refs"] = Vector3.new(-2855, 47, 1996),
            ["Enchant Room"] = Vector3.new(3221, -1303, 1406),
            ["Treasure Room"] = Vector3.new(-3600, -267, -1575),
            ["Tropical Grove"] = Vector3.new(-2091, 6, 3703),
            ["Weather Machine"] = Vector3.new(-1508, 6, 1895),
        }

        local location = Locations[Value]
        if location and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(location)
        end
    end
})

Tab4:Section({ 
    Title = "Fishing Spot",
    TextXAlignment = "Left",
    TextSize = 17,
})

Tab4:Dropdown({
    Title = "Select Location",
    Values = {"Spawn", "Konoha", "Coral Refs", "Volcano", "Sysyphus Statue"},
    Callback = function(Value)
        local Locations = {
            ["Spawn"] = Vector3.new(33, 9, 2810),
            ["Konoha"] = Vector3.new(-603, 3, 719),
            ["Coral Refs"] = Vector3.new(-2855, 47, 1996),
            ["Volcano"] = Vector3.new(-632, 55, 197),
            ["Sysyphus Statue"] = Vector3.new(-3693,-136,-1045),
        }

        local location = Locations[Value]
        if location and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(location)
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
                print("âš ï¸ Invalid input, set to default (16)")
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
            warn("âš ï¸ Must be number and minimum 50!")
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
        print("ðŸ”„ Jump Power reset to 50")
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
    Desc = "activate to use infinite jump",
    Type = "Checkbox",
    Default = false,
    Callback = function(state) 
        _G.InfiniteJump = state
        if state then
            print("âœ… Infinite Jump Active")
        else
            print("âŒ Infinite Jump Inactive")
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

Tab6:Button({
    Title = "Infinite Yield",
    Desc = "Other Scripts",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/DarkNetworks/Infinite-Yield/main/latest.lua'))()
    end
})
