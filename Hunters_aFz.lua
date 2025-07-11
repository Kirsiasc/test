-- Native UI + Key System + aFz Detector by STREE HUB

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- UI
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "NativeUI_Key"

local Frame = Instance.new("Frame", ScreenGui)
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Frame.Position = UDim2.new(0.35, 0, 0.3, 0)
Frame.Size = UDim2.new(0, 320, 0, 190)
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", Frame)
Title.Text = "STREE HUB - Key System"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextColor3 = Color3.fromRGB(0, 255, 140)

local TextBox = Instance.new("TextBox", Frame)
TextBox.PlaceholderText = "Masukkan KEY..."
TextBox.Size = UDim2.new(0.8, 0, 0, 35)
TextBox.Position = UDim2.new(0.1, 0, 0.4, 0)
TextBox.BackgroundColor3 = Color3.fromRGB(0, 0, 80)
TextBox.TextColor3 = Color3.fromRGB(0, 255, 150)
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 14
Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 8)

local Verify = Instance.new("TextButton", Frame)
Verify.Text = "Verifikasi Key"
Verify.Size = UDim2.new(0.8, 0, 0, 35)
Verify.Position = UDim2.new(0.1, 0, 0.65, 0)
Verify.BackgroundColor3 = Color3.fromRGB(0, 0, 80)
Verify.TextColor3 = Color3.fromRGB(0, 255, 150)
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
Hint.TextColor3 = Color3.fromRGB(200, 255, 150)

-- Key Valid List
local ValidKeys = {
	["PRRI TETAP JAYA"] = true,
	["TETAP MAJU"] = true,
	["JANGAN MUDAH MENYERAH"] = true,
}

Verify.MouseButton1Click:Connect(function()
	if ValidKeys[TextBox.Text] then
		Title.Text = "Key Benar! Loading..."
		wait(1)
		ScreenGui:Destroy()

		-- 🔍 Deteksi nama pemain mengandung "aFz" (case insensitive)
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
