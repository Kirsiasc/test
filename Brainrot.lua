local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jensonhirst/Orion/main/source"))()

local validKey = "StreeHubEverbodyInIndonesia"

local KeyWindow = OrionLib:MakeWindow({
    Name = "STREE HUB | Key System",
    HidePremium = true,
    SaveConfig = false,
    IntroText = "Masukkan key untuk melanjutkan"
})

local KeyTab = KeyWindow:MakeTab({
    Name = "🔑 Key Input",
    Icon = "rbxassetid://6031280882",
    PremiumOnly = false
})

KeyTab:AddTextbox({
    Name = "Masukkan Key",
    Default = "...",
    TextDisappear = true,
    Callback = function(input)
        if input == validKey then
            OrionLib:MakeNotification({
                Name = "Sukses!",
                Content = "Key Valid, Selamat Datang!",
                Time = 3
            })
            wait(1)
            -- Lanjutkan ke Main UI di sini
        else
            OrionLib:MakeNotification({
                Name = "Gagal!",
                Content = "Key Salah! Kamu akan dikeluarkan.",
                Time = 3
            })
            wait(2)
            game.Players.LocalPlayer:Kick("Key Invalid!")
        end
    end
})

OrionLib:Init()
