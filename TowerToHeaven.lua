local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({
	Name = "Tower To Heaven",
	HidePremium = false,
	SaveConfig = true,
	ConfigFolder = "OrionTest"
})

local Tab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddToggle({
	Name = "Autowin",
	Default = false,
	Callback = function(Value)
		getgenv().win = Value
		while win and wait(30) do
			for i, v in pairs(game:GetService("Workspace").Map.Tower:GetDescendants()) do
				if v.Name == "TpPart" then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
				end
			end
		end
	end    
})

Tab:AddToggle({
	Name = "Autocollect Orbs",
	Default = false,
	Callback = function(Value)
		getgenv().orbs = Value
		while orbs and wait(5) do
			for i, v in pairs(game:GetService("Workspace").Map.Tower:GetDescendants()) do
				if v.Name == "CoreIn" then
					firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
				end
			end
		end
	end    
})

Tab:AddButton({
	Name = "Delete Killbricks",
	Callback = function()
		for i, v in pairs(game.Workspace:GetDescendants()) do
			if v.Name == "KillParts" then
				v:Destroy()
			end
		end
	end    
})

Tab:AddButton({
	Name = "Teleport To The End",
	Callback = function()
		for i, v in pairs(game:GetService("Workspace").Map.Tower:GetDescendants()) do
			if v.Name == "TpPart" then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
			end
		end
	end    
})

OrionLib:Init()
