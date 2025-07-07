local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "STREE HUB",
    Icon = 101447877507131,
    LoadingTitle = "STREE LOADING",
    LoadingSubtitle = "made by community: STREE HUB",
    ShowText = "STREE HUB",
    Theme = "Oc",
    ToggleUIKeybind = "K",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,

    ConfigurationSaving = {
        Enabled = true,
        FolderName = "STREE", -- Diberi tanda kutip agar valid
        FileName = "STREE HUB"
    },

    Discord = {
        Enabled = true,
        Invite = "MFzWcQNA", -- Hanya kode invite, tanpa link
        RememberJoins = true
    },

    KeySystem = true,
    KeySettings = {
        Title = "STREE HUB",
        Subtitle = "STREE Key System",
        Note = "https://discord.gg/tTqtKwnGZz",
        FileName = "Key",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"Free Key", "Free login"}
    }
})

-- Universal Tab
local UniversalTab = Window:CreateTab("Universal script", "globe-lock")
UniversalTab:CreateSection("cheating")

UniversalTab:CreateButton({
    Name = "Farm Bond",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/qE3kiwX4/raw"))()
    end,
})

UniversalTab:CreateButton({
    Name = "Auto Win",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/sBQRgxba/raw"))()
    end,
})

UniversalTab:CreateButton({
    Name = "WalkSpeed",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/QvT5KWcH/raw"))()
    end,
})

UniversalTab:CreateButton({
    Name = "Jump Power",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/mWz3tpuy/raw"))()
    end,
})

-- Tab contoh
Window:CreateTab("Tab Example 1", 4483362458)
Window:CreateTab("Tab Example 2", "rewind")

-- Game Tab
local GameTab = Window:CreateTab("Game", "gamepad-2")
GameTab:CreateSection("Beberapa script Terkenal")

GameTab:CreateButton({
    Name = "Thand Hub",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/thiennrb7/Script/main/autobond'))()
    end,
})

GameTab:CreateButton({
    Name = "Null Fire",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/JonasThePogi/DeadRails/main/newloadstring'))()
    end,
})

-- Notifikasi
Rayfield:Notify({
    Title = "STREE LOADING",
    Content = "Semua script Berhasil Dimuat",
    Duration = 6,
    Image = "Check",
})

-- Load config
Rayfield:LoadConfiguration()
