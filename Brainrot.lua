local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "STREE HUB | Steal A Brainrot | v0.15.25",
    HidePremium = true,
    SaveConfig = true,
    ConfigFolder = "STREE HUB",
    Icon = "rbxassetid://123032091977400",
    IntroEnabled = true,
    IntroText = "Welcome To Script STREE HUB",
    Theme = "Dark", -- Perlu tanda kutip
    CloseCallback = function()
        print("UI Closed!")
    end, -- Tambahkan koma di sini
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
        Invite = "MFzWcQNA", -- hanya kode invite
        RememberJoins = true
    },

    KeySystem = true,
    KeySettings = {
        Title = "STREE HUB",
        Subtitle = "STREE Key System",
        Note = "Enter key to akses",
        FileName = "Key",
        SaveKey = false,
        GrabKeyFromSite = false,
        Key = {"PASTE_KEY_HERE", "PASTEKEYHERE", "StreeHubScriptInIndonesia"}
    }
})

-- Tab Home
local HomeTab = Window:MakeTab({
    Name = "Home",
    Icon = "rbxassetid://124242667284964",
    PremiumOnly = false
})

-- Tab Game
local UniversalTab = Window:MakeTab({
    Name = "game",
    Icon = "rbxassetid://453473360",
    PremiumOnly = false
})
