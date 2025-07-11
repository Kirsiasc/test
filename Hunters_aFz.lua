-- Native UI + Key System + aFz Detector by STREE HUB
-- Kompatibel untuk semua platform (PC, Mobile, Console)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Fungsi untuk menyesuaikan UI berdasarkan platform
local function isMobile()
    return UserInputService.TouchEnabled and not UserInputService.MouseEnabled and not UserInputService.KeyboardEnabled
end

-- UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NativeUI_Key"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999  -- Pastikan selalu di depan
ScreenGui.Parent = PlayerGui

local Frame = Instance.new("Frame")
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.Size = isMobile() and UDim2.new(0, 350, 0, 220) or UDim2.new(0, 320, 0, 190)
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = not isMobile()  -- Hanya bisa drag di non-mobile
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Frame

-- Fungsi untuk menyesuaikan ukuran font berdasarkan platform
local function getFontSize()
    return isMobile() and 20 or 18
end

local Title = Instance.new("TextLabel")
Title.Text = "STREE HUB - Key System"
Title.Size = UDim2.new(1, 0, 0, isMobile() and 50 or 40)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = getFontSize() + 2
Title.TextColor3 = Color3.fromRGB(0, 255, 0)
Title.Parent = Frame

local TextBox = Instance.new("TextBox")
TextBox.PlaceholderText = "Masukkan KEY..."
TextBox.Size = UDim2.new(0.8, 0, 0, isMobile() and 40 or 35)
TextBox.Position = UDim2.new(0.1, 0, 0.4, 0)
TextBox.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
TextBox.TextColor3 = Color3.fromRGB(0, 255, 0)
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = getFontSize()
TextBox.ClearTextOnFocus = false
TextBox.Parent = Frame

local TextBoxCorner = Instance.new("UICorner")
TextBoxCorner.CornerRadius = UDim.new(0, 8)
TextBoxCorner.Parent = TextBox

local Verify = Instance.new("TextButton")
Verify.Text = "Verifikasi Key"
Verify.Size = UDim2.new(0.8, 0, 0, isMobile() and 40 or 35)
Verify.Position = UDim2.new(0.1, 0, 0.65, 0)
Verify.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Verify.TextColor3 = Color3.fromRGB(0, 255, 0)
Verify.Font = Enum.Font.GothamBold
Verify.TextSize = getFontSize() + 2
Verify.Parent = Frame

local VerifyCorner = Instance.new("UICorner")
VerifyCorner.CornerRadius = UDim.new(0, 8)
VerifyCorner.Parent = Verify

local Hint = Instance.new("TextLabel")
Hint.Text = "Dapatkan key di: work.ink/STREEHUB_KEY"
Hint.Size = UDim2.new(1, 0, 0, isMobile() and 30 or 25)
Hint.Position = UDim2.new(0, 0, 1, isMobile() and -25 or -20)
Hint.BackgroundTransparency = 1
Hint.Font = Enum.Font.Gotham
Hint.TextSize = getFontSize() - 4
Hint.TextColor3 = Color3.fromRGB(0, 255, 0)
Hint.Parent = Frame

-- Penyesuaian untuk touch device
if isMobile() then
    TextBox.TextWrapped = true
    Verify.TextWrapped = true
    
    -- Tambahan padding untuk touch screen
    TextBox.Position = UDim2.new(0.1, 0, 0.35, 0)
    Verify.Position = UDim2.new(0.1, 0, 0.6, 0)
end

-- 🔐 Daftar Key Valid
local ValidKeys = {
    ["PRRI TETAP JAYA"] = true,
    ["TETAP MAJU"] = true,
    ["JANGAN MUDAH MENYERAH"] = true,
}

-- 🔘 Verifikasi Key
Verify.MouseButton1Click:Connect(function()
    if ValidKeys[TextBox.Text] then
        Title.Text = "Key Benar! Loading..."
        task.wait(1)
        ScreenGui:Destroy()

        -- 🔍 Deteksi nama pemain mengandung "aFz"
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
        task.wait(1.5)
        Title.Text = "STREE HUB - Key System"
    end
end)

-- Fitur tambahan untuk mobile: Tutup keyboard virtual saat selesai
if isMobile() then
    UserInputService.WindowFocusReleased:Connect(function()
        if TextBox:IsFocused() then
            TextBox:ReleaseFocus()
        end
    end)
end
