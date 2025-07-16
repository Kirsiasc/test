local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()

-- Fungsi untuk memvalidasi key
local function ValidateKey()
    local ValidKey = "StreeHubEverbodyInIndonesia"
    local KeyInput = OrionLib:MakePrompt({
        Name = "Enter Key",
        DefaultText = "Input Key Here",
        OnClose = function()
            game.Players.LocalPlayer:Kick("You must enter a valid key!")
        end,
    })
    
    if KeyInput == ValidKey then
        OrionLib:MakeNotification({
            Name = "Success!",
            Content = "Key Verified. Welcome!",
            Time = 3
        })
        return true
    else
        game.Players.LocalPlayer:Kick("Invalid Key!")
        return false
    end
end

-- Jalankan validasi key sebelum membuat window
if ValidateKey() then
    local Window = OrionLib:MakeWindow({
        Name = "STREE HUB | Steal A Brainrot | 0.15.25",
        HidePremium = true,
        SaveConfig = true,
        ConfigFolder = "STREE HUB",
        Icon = "123032091977400",
        IntroEnabled = true,
        IntroText = "Welcome To Script STREE HUB",
        CloseCallback = function()
            print("UI Closed!")
        end
    })

    local HomeTab = Window:MakeTab({
        Name = "Home",
        Icon = "rbxassetid://124242667284964",
        PremiumOnly = false
    })

    local UniversalTab = Window:MakeTab({
        Name = "game",
        Icon = "rbxassetid://453473360",
        PremiumOnly = false
    })

    -- Tambahkan elemen UI Anda di sini
    -- Contoh:
    HomeTab:AddButton({
        Name = "Example Button",
        Callback = function()
            print("Button clicked!")
        end    
    })
end
