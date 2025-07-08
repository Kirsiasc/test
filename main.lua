local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "STREE HUB",
    Icon = 123032091977400,
    LoadingTitle = "STREE LOADING",
    LoadingSubtitle = "made by community: STREE HUB",
    Theme = "DarkBlue",

    ToggleUIKeybind = "K",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,

    ConfigurationSaving = {
        Enabled = true,
        FolderName = "STREE",
        FileName = "STREE HUB"
    },

    Discord = {
        Enabled = true,
        Invite = "MFzWcQNA", -- hanya code
        RememberJoins = true
    },

    KeySystem = true,
    KeySettings = {
        Title = "STREE HUB",
        Subtitle = "STREE Key System",
        Note = "Enter key to login",
        FileName = "Key",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"Free Key", "Free login"}
    }
})

-- UNIVERSAL TAB
local UniversalTab = Window:CreateTab("Universal script", "globe-lock")
UniversalTab:CreateSection("cheating")

UniversalTab:CreateButton({
    Name = "FlyGuiV3",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
    end,
})

UniversalTab:CreateButton({
    Name = "Farm Bond",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/qE3kiwX4/raw"))()
    end,
})

UniversalTab:CreateButton({
    Name = "Auto Win",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/create-stree/STREE-HUB/main/autowin.lua"))()
    end,
})

-- GAME TAB
local GameTab = Window:CreateTab("Game", "gamepad-2")
GameTab:CreateSection("Beberapa script Terkenal")

GameTab:CreateButton({
    Name = "Thand Hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/thiennrb7/Script/main/autobond"))()
    end,
})

GameTab:CreateButton({
    Name = "Null Fire",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/JonasThePogi/DeadRails/main/newloadstring"))()
    end,
})

-- NOTIFIKASI
Rayfield:Notify({
    Title = "Follow Akun TikTok",
    Content = "Jangan Lupa Follow Akun TikTok @kirsia.sc",
    Duration = 3,
    Image = 0
})

Rayfield:Notify({
    Title = "STREE LOADING",
    Content = "Semua script berhasil dimuat dalam 3 detik",
    Duration = 3,
    Image = "Check"
})

-- LOAD KONFIGURASI
Rayfield:LoadConfiguration()
