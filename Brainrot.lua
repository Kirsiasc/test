local OrionLib
local success, err = pcall(function()
    OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()
end)

if not success or not OrionLib then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "STREE HUB Error",
        Text = "Gagal memuat library. Coba lagi nanti.",
        Duration = 5
    })
    return
end

-- Fungsi input key alternatif yang lebih reliable
local function GetKeyInput()
    -- Coba buat prompt dengan Orion terlebih dahulu
    local success, result = pcall(function()
        if OrionLib.MakePrompt then
            return OrionLib:MakePrompt({
                Name = "Verifikasi Key",
                DefaultText = "Masukkan key akses STREE HUB",
                OnClose = function()
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "Key Dibutuhkan",
                        Text = "Anda harus memasukkan key untuk melanjutkan",
                        Duration = 3
                    })
                end
            })
        end
    end)
    
    -- Fallback ke TextBox GUI sederhana
    if not success or not result then
        local textBox = Instance.new("TextBox")
        textBox.PlaceholderText = "Masukkan key akses"
        textBox.Size = UDim2.new(0, 200, 0, 50)
        textBox.Position = UDim2.new(0.5, -100, 0.5, -25)
        textBox.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
        
        local enteredKey
        textBox.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                enteredKey = textBox.Text
                textBox:Destroy()
            end
        end)
        
        repeat wait() until enteredKey ~= nil
        return enteredKey
    end
    
    return result
end

-- Fungsi validasi key utama
local function ValidateKey()
    local ValidKey = "StreeHubEverbodyInIndonesia"
    local maxAttempts = 3
    local attempts = 0
    
    while attempts < maxAttempts do
        attempts = attempts + 1
        
        local keyInput = GetKeyInput()
        
        if keyInput == ValidKey then
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Key Valid",
                Text = "Berhasil memverifikasi key!",
                Duration = 3
            })
            return true
        else
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Key Salah",
                Text = string.format("Percobaan %d/%d", attempts, maxAttempts),
                Duration = 3
            })
        end
    end
    
    return false
end

-- Fungsi untuk membuat UI dengan error handling
local function CreateMainUI()
    local Window = OrionLib:MakeWindow({
        Name = "STREE HUB | Steal A Brainrot | 0.15.25",
        HidePremium = true,
        SaveConfig = true,
        ConfigFolder = "STREE HUB",
        Icon = "rbxassetid://123032091977400",
        IntroEnabled = true,
        IntroText = "Welcome To STREE HUB",
        CloseCallback = function()
            print("UI ditutup")
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

    -- Contoh button sederhana
    HomeTab:AddButton({
        Name = "Test Button",
        Callback = function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Test",
                Text = "Button berfungsi!",
                Duration = 3
            })
        end
    })
end

-- Eksekusi utama dengan semua error handling
coroutine.wrap(function()
    wait(2) -- Beri waktu untuk loading game
    
    -- Coba load Feather Icons
    pcall(function()
        OrionLib:MakeNotification({
            Name = "Memuat",
            Content = "Menyiapkan STREE HUB...",
            Time = 2
        })
    end)
    
    if ValidateKey() then
        local success, err = pcall(CreateMainUI)
        if not success then
            warn("Gagal membuat UI:", err)
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Error",
                Text = "Gagal memuat antarmuka. Coba reconnect.",
                Duration = 5
            })
        end
    end
end)()
