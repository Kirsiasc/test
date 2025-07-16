local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()

-- Fungsi untuk memvalidasi key
local function ValidateKey()
    local ValidKey = "StreeHubEverbodyInIndonesia"
    
    -- Membuat prompt untuk input key
    local success, keyInput = pcall(function()
        return OrionLib:MakePrompt({
            Name = "STREE HUB - Key System",
            DefaultText = "Enter your key here...",
            OnClose = function()
                game.Players.LocalPlayer:Kick("You must enter a valid key to continue!")
            end
        })
    end)
    
    -- Jika ada error saat mengambil input
    if not success then
        game.Players.LocalPlayer:Kick("Key verification failed. Please try again.")
        return false
    end
    
    -- Validasi key
    if keyInput == ValidKey then
        OrionLib:MakeNotification({
            Name = "Success!",
            Content = "Key verified. Welcome to STREE HUB!",
            Time = 5,
            Image = "rbxassetid://123032091977400"
        })
        return true
    else
        game.Players.LocalPlayer:Kick("Invalid key! Please contact the script owner.")
        return false
    end
end

-- Jalankan validasi key terlebih dahulu
if ValidateKey() then
    -- Buat window utama hanya jika key valid
    local Window = OrionLib:MakeWindow({
        Name = "STREE HUB | Steal A Brainrot | 0.15.25",
        HidePremium = true,
        SaveConfig = true,
        ConfigFolder = "STREE HUB",
        Icon = "rbxassetid://123032091977400",
        IntroEnabled = true,
        IntroText = "Welcome To STREE HUB",
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
    local UniversalTab = Window:MakeTab({
        Name = "Game",
        Icon = "rbxassetid://453473360",
        PremiumOnly = false
    })

    -- Tambahkan elemen UI di sini
    -- Contoh button di tab Home
    HomeTab:AddButton({
        Name = "Test Button",
        Callback = function()
            OrionLib:MakeNotification({
                Name = "Notification",
                Content = "Button clicked!",
                Time = 3
            })
        end
    })
    
    -- Anda bisa menambahkan lebih banyak elemen UI di sini
end
