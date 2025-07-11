-- Native UI + Key System + aFz Detector by STREE HUB

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")

-- 🎵 Sound klik
local ClickSound = Instance.new("Sound", SoundService)
ClickSound.SoundId = "rbxassetid://9118823107"
ClickSound.Volume = 1

-- UI Key System
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "NativeUI_Key"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.Size = UDim2.new(0, 320, 0, 190)
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.Active = true
Frame.Draggable = true
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", Frame)
Title.Text = "STREE HUB - Key System"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextColor3 = Color3.fromRGB(0, 255, 0)

local TextBox = Instance.new("TextBox", Frame)
TextBox.PlaceholderText = "Masukkan KEY..."
TextBox.Size = UDim2.new(0.8, 0, 0, 35)
TextBox.Position = UDim2.new(0.1, 0, 0.4, 0)
TextBox.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
TextBox.TextColor3 = Color3.fromRGB(0, 255, 0)
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 14
Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 8)

local Verify = Instance.new("TextButton", Frame)
Verify.Text = "Verifikasi Key"
Verify.Size = UDim2.new(0.8, 0, 0, 35)
Verify.Position = UDim2.new(0.1, 0, 0.65, 0)
Verify.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Verify.TextColor3 = Color3.fromRGB(0, 255, 0)
Verify.Font = Enum.Font.GothamBold
Verify.TextSize = 16
Instance.new("UICorner", Verify).CornerRadius = UDim.new(0, 8)

local Hint = Instance.new("TextLabel", Frame)
Hint.Text = "Dapatkan key di: work.ink/STREEHUB_KEY"
Hint.Size = UDim2.new(1, 0, 0, 25)
Hint.Position = UDim2.new(0, 0, 1, -20)
Hint.BackgroundTransparency = 1
Hint.Font = Enum.Font.Gotham
Hint.TextSize = 12
Hint.TextColor3 = Color3.fromRGB(0, 255, 0)

-- 📋 Tombol Salin Key
local CopyKey = Instance.new("TextButton", Frame)
CopyKey.Size = UDim2.new(0.35, 0, 0, 28)
CopyKey.Position = UDim2.new(0.1, 0, 0.83, 0)
CopyKey.Text = "📋 Salin"
CopyKey.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
CopyKey.TextColor3 = Color3.fromRGB(0, 255, 0)
CopyKey.Font = Enum.Font.Gotham
CopyKey.TextSize = 12
Instance.new("UICorner", CopyKey).CornerRadius = UDim.new(0, 6)

CopyKey.MouseButton1Click:Connect(function()
    setclipboard("PRRI TETAP JAYA")
    ClickSound:Play()
end)

-- 🔐 Daftar Key Valid
local ValidKeys = {
    ["PRRI TETAP JAYA"] = true,
    ["TETAP MAJU"] = true,
    ["JANGAN MUDAH MENYERAH"] = true,
}

-- 🧠 GUI Layer Utama STREE HUB
local MainUI = Instance.new("Frame", PlayerGui)
MainUI.Name = "STREE_MAIN"
MainUI.Visible = false
MainUI.Size = UDim2.new(0, 300, 0, 140)
MainUI.Position = UDim2.new(0.05, 0, 0.3, 0)
MainUI.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Instance.new("UICorner", MainUI).CornerRadius = UDim.new(0, 12)

local MainTitle = Instance.new("TextLabel", MainUI)
MainTitle.Size = UDim2.new(1, 0, 0, 40)
MainTitle.Text = "✅ STREE HUB Aktif"
MainTitle.BackgroundTransparency = 1
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextSize = 18
MainTitle.TextColor3 = Color3.fromRGB(0, 255, 0)

-- 🔘 Toggle GUI Key: Tekan K
UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.K then
        MainUI.Visible = not MainUI.Visible
        ClickSound:Play()
    end
end)

-- 🔘 Verifikasi Key
Verify.MouseButton1Click:Connect(function()
    ClickSound:Play()
    if ValidKeys[TextBox.Text] then
        Title.Text = "Key Benar! Loading..."
        wait(1)
        ScreenGui:Destroy()
        MainUI.Visible = true

        -- Deteksi aFz
        for _, player in pairs(Players:GetPlayers()) do
            if string.lower(player.Name):match("afz") then
                warn("🚨 Terdeteksi: " .. player.Name)
            end
        end

        Players.PlayerAdded:Connect(function(player)
            if string.lower(player.Name):match("afz") then
                warn("🚨 Player baru terdeteksi: " .. player.Name)
            end
        end)
    else
        Title.Text = "❌ Key Salah! Dapatkan dulu!"
    end
end)
