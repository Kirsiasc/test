local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()

-- Fungsi untuk memvalidasi key dengan penanganan error yang lebih baik
local function ValidateKey()
    local ValidKey = "StreeHubEverbodyInIndonesia"
    
    -- Membuat prompt untuk input key dengan penanganan error
    local keyInput
    local promptSuccess, promptError = pcall(function()
        keyInput = OrionLib:MakePrompt({
            Name = "STREE HUB Key Verification",
            DefaultText = "Enter your access key",
            OnClose = function()
                game.Players.LocalPlayer:Kick("Key input was cancelled")
            end,
        })
    end)
    
    if not promptSuccess then
        warn("Prompt error:", promptError)
        game.Players.LocalPlayer:Kick("Key verification system error. Please rejoin.")
        return false
    end
    
    -- Verifikasi key
    if keyInput and keyInput == ValidKey then
        return true
    else
        game.Players.LocalPlayer:Kick("Invalid access key. Please check your key and try again.")
        return false
    end
end

-- Main execution
coroutine.wrap(function()
    -- Tunggu sedikit untuk memastikan game sepenuhnya loaded
    wait(1)
    
    if ValidateKey() then
        -- Buat UI setelah key divalidasi
        local Window = OrionLib:MakeWindow({
            Name = "STREE HUB | Steal A Brainrot | 0.15.25",
            HidePremium = true,
            SaveConfig = true,
            ConfigFolder = "STREE HUB",
            Icon = "rbxassetid://123032091977400",
            IntroEnabled = true,
            IntroText = "Welcome To Script STREE HUB",
            IntroIcon = "rbxassetid://123032091977400",
            CloseCallback = function()
                print("UI Closed!")
            end
        })

        -- Tab Home
        local HomeTab = Window:MakeTab({
            Name = "Home",
            Icon = "rbxassetid://124242667284964",
            PremiumOnly = false
        })

        -- Tab Game
        local GameTab = Window:MakeTab({
            Name = "Game",
            Icon = "rbxassetid://453473360",
            PremiumOnly = false
        })

        -- Contoh elemen UI
        HomeTab:AddButton({
            Name = "Test Button",
            Callback = function()
                OrionLib:MakeNotification({
                    Name = "Test",
                    Content = "Button works!",
                    Time = 3
                })
            end
        })
        
        -- Tambahkan lebih banyak fitur di sini
        
        -- Notifikasi sukses
        OrionLib:MakeNotification({
            Name = "Success",
            Content = "STREE HUB loaded successfully!",
            Time = 5
        })
    end
end)()
