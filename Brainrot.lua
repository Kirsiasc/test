local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()

-- Fungsi untuk memvalidasi key tanpa kick
local function ValidateKey()
    local ValidKey = "StreeHubEverbodyInIndonesia"
    local maxAttempts = 3
    local attempts = 0
    
    while attempts < maxAttempts do
        attempts = attempts + 1
        
        -- Membuat prompt untuk input key
        local keyInput = OrionLib:MakePrompt({
            Name = "STREE HUB - Key System",
            DefaultText = "Masukkan key Anda (Percobaan "..attempts.."/"..maxAttempts..")",
            OnClose = function()
                OrionLib:MakeNotification({
                    Name = "Peringatan",
                    Content = "Anda harus memasukkan key untuk melanjutkan",
                    Time = 3
                })
            end,
        })
        
        -- Verifikasi key
        if keyInput == ValidKey then
            OrionLib:MakeNotification({
                Name = "Sukses",
                Content = "Key valid! Memuat STREE HUB...",
                Time = 3,
                Image = "rbxassetid://123032091977400"
            })
            return true
        else
            OrionLib:MakeNotification({
                Name = "Key Salah",
                Content = "Key tidak valid. Silakan coba lagi",
                Time = 3
            })
        end
    end
    
    -- Jika sudah melebihi maxAttempts
    OrionLib:MakeNotification({
        Name = "Peringatan",
        Content = "Anda telah melebihi batas percobaan",
        Time = 5
    })
    return false
end

-- Main execution
coroutine.wrap(function()
    wait(1) -- Tunggu game loading
    
    if ValidateKey() then
        -- Buat UI utama
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
                OrionLib:MakeNotification({
                    Name = "Info",
                    Content = "Anda bisa membuka kembali UI dengan tombol yang ditentukan",
                    Time = 5
                })
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

        -- Contoh button
        HomeTab:AddButton({
            Name = "Test Button",
            Callback = function()
                OrionLib:MakeNotification({
                    Name = "Test",
                    Content = "Button berfungsi dengan baik!",
                    Time = 3
                })
            end
        })
        
        -- Notifikasi sukses
        OrionLib:MakeNotification({
            Name = "STREE HUB",
            Content = "Berhasil dimuat! Selamat menggunakan",
            Time = 5
        })
    else
        -- Jika key salah setelah beberapa percobaan
        OrionLib:MakeNotification({
            Name = "Akses Ditolak",
            Content = "Anda tidak dapat mengakses STREE HUB",
            Time = 5
        })
    end
end)()
