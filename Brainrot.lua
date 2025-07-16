local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))()

-- Fungsi untuk menangani error loading Feather Icons
local function SafeLoadIcons()
    local success, err = pcall(function()
        OrionLib:MakeNotification({
            Name = "Loading Assets",
            Content = "Memuat resources...",
            Time = 2
        })
    end)
    
    if not success then
        warn("Icon loading warning:", err)
    end
end

-- Fungsi input key alternatif jika MakePrompt tidak tersedia
local function GetKeyInput()
    -- Coba metode MakePrompt terlebih dahulu
    local success, result = pcall(function()
        return OrionLib:MakePrompt({
            Name = "Key Verification",
            DefaultText = "Masukkan key akses",
            OnClose = function()
                OrionLib:MakeNotification({
                    Name = "Info",
                    Content = "Input key dibutuhkan",
                    Time = 3
                })
            end
        })
    end)
    
    -- Fallback ke input sederhana jika MakePrompt error
    if not success then
        warn("MakePrompt not available, using fallback:", result)
        return game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Key Required",
            Text = "Silakan hubungi developer untuk key akses",
            Duration = 3
        }) or ""
    end
    
    return result
end

-- Fungsi validasi key utama
local function ValidateKey()
    local ValidKey = "StreeHubEverbodyInIndonesia"
    local maxAttempts = 3
    local attempts = 0
    
    SafeLoadIcons() -- Memuat icons dengan penanganan error
    
    while attempts < maxAttempts do
        attempts = attempts + 1
        
        local keyInput = GetKeyInput()
        
        if keyInput == ValidKey then
            OrionLib:MakeNotification({
                Name = "Success",
                Content = "Key valid! Memuat STREE HUB...",
                Time = 3
            })
            return true
        else
            OrionLib:MakeNotification({
                Name = "Key Salah",
                Content = string.format("Percobaan %d/%d", attempts, maxAttempts),
                Time = 3
            })
        end
    end
    
    return false
end

-- Main execution dengan error handling
local success, err = pcall(function()
    if ValidateKey() then
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
                print("UI ditutup")
            end
        })

        -- Tab Home
        local HomeTab = Window:MakeTab({
            Name = "Home",
            Icon = "rbxassetid://124242667284964",
            PremiumOnly = false
        })

        -- Contoh button dengan error handling
        HomeTab:AddButton({
            Name = "Test Button",
            Callback = function()
                pcall(function()
                    OrionLib:MakeNotification({
                        Name = "Test",
                        Content = "Button berfungsi!",
                        Time = 3
                    })
                end)
            end
        })
    end
end)

if not success then
    warn("Main execution error:", err)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "STREE HUB Error",
        Text = "Terjadi kesalahan saat memuat UI",
        Duration = 3
    })
end
