local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({
    Name = "Slap A Friend",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "OrionTest"
})

local Tab = Window:MakeTab({
    Name = "Autofarm",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

Tab:AddToggle({
    Name = "Auto Collect Slaps",
    Default = false,
    Callback = function(Value)
        getgenv().autoslaps = Value
        while autoslaps and wait(2) do
            for i, v in pairs(game.Workspace.Collectables:GetDescendants()) do
                if v.Name == "HitBox" or v.Name == "WiderHitbox" then
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
                end
            end
        end
    end    
})

Tab:AddToggle({
    Name = "Auto Claim Rewards",
    Default = false,
    Callback = function(Value)
        getgenv().autoclaim = Value
        while autoclaim and wait(10) do
            for i = 1, 12 do
                game:GetService("ReplicatedStorage").RequestRewardClaim:InvokeServer(i)
            end
        end
    end    
})


local Tab = Window:MakeTab({
    Name = "Misc",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

Tab:AddButton({
    Name = "Redeem All Codes",
    Callback = function()
        for i, v in pairs(game:GetService("Players").LocalPlayer.Codes:GetChildren()) do
            game:GetService("Players").LocalPlayer.PlayerGui.PermanentUI.Menus.CodesMenu.MainBody.Codes.Template.MainBody.RedeemButton.RedeemScript.Code:FireServer(game:GetService("ReplicatedStorage").Codes, tostring(v.Name))
        end
    end    
})

Tab:AddButton({
    Name = "Unlock VIP Area",
    Callback = function()
        game:GetService("Workspace").World1VIPWall:Destroy()
        game:GetService("Workspace").World2VIPWall:Destroy()
    end    
})

OrionLib:Init()
