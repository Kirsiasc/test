-- == STEP 1: Load Rayfield (Key System) ==
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Key yang valid
local ValidKeys = {
    ["STREE123"] = true,
    ["KIRSIASC"] = true
}

-- Buat window untuk Key System (Rayfield)
local KeyWindow = Rayfield:CreateWindow({
    Name = "🔐 STREE HUB | Key System",
    LoadingTitle = "Memuat...",
    LoadingSubtitle = "Verifikasi Key",
    ConfigurationSaving = {
        Enabled = false
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

-- Buat tab untuk input Key
local KeyTab = KeyWindow:CreateTab("🔑 Masukkan Key", 4483362458)

KeyTab:CreateInput({
    Name = "Key STREE HUB",
    PlaceholderText = "Contoh: STREE123",
    RemoveTextAfterFocusLost = false,
    Callback = function(input)
        if ValidKeys[input] then
            Rayfield:Notify({
                Title = "Sukses!",
                Content = "Key valid. Memuat STREE HUB...",
                Duration = 3
            })
            wait(1)
            KeyWindow:Destroy() -- Tutup jendela Rayfield
            loadMainUI() -- Lanjut ke OrionLib UI
        else
            Rayfield:Notify({
                Title = "Key Salah!",
                Content = "Key tidak valid. Coba lagi.",
                Duration = 4
            })
        end
    end
})

-- == STEP 2: Fungsi Memuat UI Utama OrionLib ==
function loadMainUI()
    local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jensonhirst/Orion/main/source"))()

    local MainWindow = OrionLib:MakeWindow({
        Name = "STREE HUB | Versi OrionLib",
        HidePremium = false,
        SaveConfig = true,
        ConfigFolder = "STREE_HUB",
        IntroText = "Selamat datang di STREE HUB 🎉",
        Theme = {
            Image = "rbxassetid://5553946656", -- Ganti sesuai tema kamu
            Info = "STREE Style",
            Credit = "kirsiasc"
        }
    })

    -- Tab utama
    local MainTab = MainWindow:MakeTab({
        Name = "Main",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })

    MainTab:AddButton({
        Name = "Fling Player",
        Callback = function()
            local lp = game.Players.LocalPlayer
            local char = lp.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.Velocity = Vector3.new(9999, 9999, 9999)
            end
        end
    })

    MainTab:AddSlider({
        Name = "WalkSpeed",
        Min = 16,
        Max = 150,
        Default = 16,
        Increment = 1,
        ValueName = "Speed",
        Callback = function(value)
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChildOfClass("Humanoid") then
                char:FindFirstChildOfClass("Humanoid").WalkSpeed = value
            end
        end
    })

    OrionLib:Init()
end
