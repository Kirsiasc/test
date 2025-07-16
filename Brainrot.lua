local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "STREE HUB | Steal A Brainrot | 0.15.25",
    HidePremium = true,
    SaveConfig = true,
    ConfigFolder = "STREE HUB",
    Icon = "123032091977400",
    IntroEnabled = true,
    IntroText = "Welcome To Script STREE HUB",
    CloseCallback = function()
        print("UI Closed!")
    end
})

--[[
Name = <string> - The name of the UI.
HidePremium = <bool> - Whether or not the user details shows Premium status or not.
SaveConfig = <bool> - Toggles the config saving in the UI.
ConfigFolder = <string> - The name of the folder where the configs are saved.
IntroEnabled = <bool> - Whether or not to show the intro animation.
IntroText = <string> - Text to show in the intro animation.
IntroIcon = <string> - URL to the image you want to use in the intro animation.
Icon = <string> - URL to the image you want displayed on the window.
CloseCallback = <function> - Function to execute when the window is closed.
]]

local Key = "StreeHubEverbodyInIndonesia" -- Key yang valid
local KeyInput = OrionLib:MakePrompt({
    Name = "Enter Key Here",
    DefaultText = "Input Key Here",
    OnClose = function()
        game.Players.LocalPlayer:Kick("Wrong Key!") -- Kick jika ditutup tanpa input
    end,
})

if KeyInput == Key then
    OrionLib:MakeNotification({
        Name = "Success!",
        Content = "Key Verified. Welcome!",
        Time = 3
    })
    -- Lanjutkan script di sini
else
    game.Players.LocalPlayer:Kick("Invalid Key!") -- Kick jika key salah
end

local HomeTab = Window:MakeTab({
	Name = "Home",
	Icon = "rbxassetid://124242667284964",
	PremiumOnly = false
})

--[[
Name = <string> - The name of the tab.
Icon = <string> - The icon of the tab.
PremiumOnly = <bool> - Makes the tab accessible to Sirus Premium users only.
]]

local UniversalTab = Window:MakeTab({
	Name = "game",
	Icon = "rbxassetid://453473360",
	PremiumOnly = false
})

--[[
Name = <string> - The name of the tab.
Icon = <string> - The icon of the tab.
PremiumOnly = <bool> - Makes the tab accessible to Sirus Premium users only.
]]
