local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local function AutoWin()
    local goal = nil
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:lower():find("goal") or obj.Name:lower():find("finish")) then
            goal = obj
            break
        end
    end

    if goal then
        Character:PivotTo(goal.CFrame + Vector3.new(0, 5, 0))
        print("✅ Auto Win berhasil ke:", goal.Name)
    else
        warn("❌ Goal tidak ditemukan.")
    end
end

AutoWin()
