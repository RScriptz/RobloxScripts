--Update 1: Added Visual Value Spoofers (Script Made By GamingResources, discord.gg/bugatti)
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = OrionLib:MakeWindow({
	Name = "Toy Soldierz",
	HidePremium = false,
	SaveConfig = true,
	ConfigFolder = "OrionTest",
	IntroText = "By GamingResources"
})

CratesTable = {
	"Basic Box",
	"Basic Crate",
	"Fragile Crate",
	"Toy Box",
	"Paper Pack",
	"Cardboard Pack",
	"Brick Pack",
	"Plastic Pack"
}
DifficultiesTable = {
	"Easy",
	"Medium",
	"Hard",
	"ToyBreaker"
}
SaveslotsTable = {
	"Slot1",
	"Slot2",
	"Slot3",
	"Slot4",
	"Slot5",
	"Slot6",
	"Slot7",
	"Slot8",
	"Slot9",
	"Slot10",
	"Slot11",
	"Autosave"
}
MergingTable = {
	"Books",
	"Uzi",
	"Revolver",
	"Grenade",
	"Stick Grenade",
	"Cardboard Box",
	"Shotgun",
	"M16",
	"Minigun",
	"Rocket",
	"Homing Rocket",
	"Glass",
	"Armored Concrete",
	"Mortar",
	"M249",
	"Simple Mine",
	"Blast Mine",
	"Direct Mine",
	"Polyglass",
	"Unsolvable",
	"Tankgewehr",
	"Bookshelf",
	"Wooden Crate",
	"Strong Concrete",
	"Newbie",
	"SMG",
	"Auto Rifle",
	"Sniper",
	"Voidium Paper",
	"Voidium Cardboard",
	"Voidium Bricks",
	"Voidium Puzzle",
}

local plr = game.Players.LocalPlayer
local TargetName = plr
local startTime = tick()
local elapsedTime = tick() - startTime
local SpoofBlock = "Polyglass"
local SpoofSoldier = "Luger"
local SpoofValue = 9999999

local Blocks = {}
local Soldiers = {}

local SelectedWave
local SelectedDifficulty
local SelectedSaveslot
local NoRNG
local SelectedCrate
local MergingRecipe
local SpoofBlock
local SpoofSoldier
local SpoofValue

for i, v in pairs(game.Players.LocalPlayer.Stats.Blocks:GetChildren()) do
	if not table.find(Blocks, v.Name) then
		table.insert(Blocks, v.Name)
	end
end

for i, v in pairs(game.Players.LocalPlayer.Stats.Soldiers:GetChildren()) do
	if not table.find(Soldiers, v.Name) then
		table.insert(Soldiers, v.Name)
	end
end

local function autofarm()
	game:GetService("ReplicatedStorage"):WaitForChild("ClientServerRemotes"):WaitForChild("LoadBuild"):FireServer(SelectedSaveslot)
	wait(.5)
	game:GetService("ReplicatedStorage"):WaitForChild("ClientServerRemotes"):WaitForChild("StartWave"):FireServer(SelectedWave, SelectedDifficulty)
end

local function collectbearz()
	for i, v in pairs(game.Workspace:GetDescendants()) do
		if v.name == "teddy" then
			firetouchinterest(v.Main, plr.Character.HumanoidRootPart, 0)
		end
	end
end

local function buycrate()
	game:GetService("ReplicatedStorage"):WaitForChild("ClientServerRemotes"):WaitForChild("UnlockCrate"):InvokeServer(SelectedCrate, NoRNG)
end

local function merging()
	game:GetService("ReplicatedStorage"):WaitForChild("ClientServerRemotes"):WaitForChild("Merge"):InvokeServer(MergingRecipe)
end  

local Tab = Window:MakeTab({
	Name = "Autofarm",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = Tab:AddSection({
	Name = "Settings"
})

Tab:AddSlider({
	Name = "Selected Wave",
	Min = 1,
	Max = 40,
	Default = 1,
	Color = Color3.fromRGB(57, 255, 20),
	Increment = 1,
	ValueName = "Wave",
	Callback = function(Value)
		SelectedWave = Value
	end
})
Tab:AddDropdown({
	Name = "Selected Save Slot",
	Default = "Autosave",
	Options = SaveslotsTable,
	Callback = function(Value)
		SelectedSaveslot = Value
	end    
})
Tab:AddDropdown({
	Name = "Selected Difficulty",
	Default = "Easy",
	Options = DifficultiesTable,
	Callback = function(Value)
		SelectedDifficulty = Value
	end    
})

local Section = Tab:AddSection({
	Name = "Autofarming"
})
Tab:AddToggle({
	Name = "Autofarm",
	Default = false,
	Callback = function(Value)
		getgenv().Autofarming = Value
		while Autofarming and task.wait() do
			autofarm()
		end
	end    
})

Tab:AddToggle({
	Name = "Auto Collect Bearz",
	Default = false,
	Callback = function(Value)
		getgenv().Bearz = Value
		while Bearz and task.wait() do
			collectbearz()
		end
	end    
})


local Tab = Window:MakeTab({
	Name = "Autobuy",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = Tab:AddSection({
	Name = "Settings"
})
Tab:AddDropdown({
	Name = "Selected Crate",
	Default = "Basic Box",
	Options = CratesTable,
	Callback = function(Value)
		if Value == "Basic Box" then
			SelectedCrate = "1"
		elseif Value == "Basic Crate" then
			SelectedCrate = "2"
		elseif Value == "Fragile Crate" then
			SelectedCrate = "3"
		elseif Value == "Toy Box" then
			SelectedCrate = "4"
		elseif Value == "Paper Pack" then
			SelectedCrate = "5"
		elseif Value == "Cardboard Pack" then
			SelectedCrate = "6"
		elseif Value == "Brick Pack" then
			SelectedCrate = "7"
		elseif Value == "Plastic Pack" then
			SelectedCrate = "8"
		end
	end    
})

Tab:AddToggle({
	Name = "No RNG",
	Default = false,
	Callback = function(Value)
		NoRNG = Value
	end    
})

local Section = Tab:AddSection({
	Name = "Autobuying"
})

Tab:AddToggle({
	Name = "Auto Buy Crate",
	Default = false,
	Callback = function(Value)
		getgenv().Autocrate = Value
		while Autocrate and task.wait() do
			buycrate()
		end
	end    
})

Tab:AddButton({
	Name = "Buy Crate",
	Callback = function()
		buycrate()
	end    
})


local Tab = Window:MakeTab({
	Name = "Merging",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local Section = Tab:AddSection({
	Name = "Settings"
})
Tab:AddDropdown({
	Name = "Selected Recipe",
	Default = "Voidium Puzzle",
	Options = MergingTable,
	Callback = function(Value)
		MergingRecipe = Value
	end    
})
Tab:AddToggle({
	Name = "Auto Merge",
	Default = false,
	Callback = function(Value)
		getgenv().Automerge = Value
		while Automerge and task.wait() do
			merging()
		end
	end    
})

Tab:AddButton({
	Name = "Merge",
	Callback = function()
		merging()
	end    
})

local Tab = Window:MakeTab({
	Name = "Visuals",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
local SpoofBlock
local SpoofSoldier
local SpoofValue

local Section = Tab:AddSection({
	Name = "Settings"
})

Tab:AddDropdown({
	Name = "Blocks",
	Default = "Polyglass",
	Options = Blocks,
	Callback = function(Value)
		SpoofBlock = Value
	end    
})

Tab:AddDropdown({
	Name = "Soldiers",
	Default = "Luger",
	Options = Soldiers,
	Callback = function(Value)
		SpoofSoldier = Value
	end    
})

Tab:AddTextbox({
	Name = "Visual Value",
	Default = "9999999",
	TextDisappear = false,
	Callback = function(Value)
		SpoofValue = tonumber(Value)
	end
})

local Section = Tab:AddSection({
	Name = "Building Visuals"
})

Tab:AddButton({
	Name = "Spoof Selected Block",
	Callback = function()
		game:GetService("Players").LocalPlayer.Stats.Blocks[SpoofBlock].Value = SpoofValue
	end
})

Tab:AddButton({
	Name = "Spoof Selected Soldier",
	Callback = function()
		game:GetService("Players").LocalPlayer.Stats.Soldiers[SpoofSoldier].Value = SpoofValue
	end
})

Tab:AddButton({
	Name = "Spoof All Blocks",
	Callback = function()
		for i, v in pairs(game.Players.LocalPlayer.Stats.Blocks:GetChildren()) do
			v.Value = SpoofValue
		end
	end
})

Tab:AddButton({
	Name = "Spoof All Soldiers",
	Callback = function()
		for i, v in pairs(game.Players.LocalPlayer.Stats.Soldiers:GetChildren()) do
			v.Value = SpoofValue
		end
	end
})


local Section = Tab:AddSection({
	Name = "Currency Visuals"
})
Tab:AddButton({
	Name = "Spoof Bearz",
	Callback = function()
		game:GetService("Players").LocalPlayer.Stats.Wealth.Bears.Value = SpoofValue
	end
})

Tab:AddButton({
	Name = "Spoof Event Keys",
	Callback = function()
		game:GetService("Players").LocalPlayer.Stats.Wealth.EventKeys.Value = SpoofValue
	end
})

Tab:AddButton({
	Name = "Spoof Play Points",
	Callback = function()
		for i = 1, 12 do
			game:GetService("Players").LocalPlayer.Stats.Wealth.TotalPlayPoints.Value = SpoofValue
			wait(10)
		end
	end
})
local Tab = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = Tab:AddSection({
	Name = "Player Spy"
})
Tab:AddTextbox({
	Name = "Player Name",
	Default = tostring(game.Players.LocalPlayer),
	TextDisappear = false,
	Callback = function(Value)
		TargetName = Value
	end
})

Tab:AddButton({
	Name = "Get Player Info",
	Callback = function()
		local Window = Rayfield:CreateWindow({
			Name = tostring(TargetName) .. "'s Info",
			LoadingTitle = "Target Info",
			LoadingSubtitle = "By GamingResources",
		})
		local Tab = Window:CreateTab("Player Info ", 4483362458)
		local Label1 = Tab:CreateLabel("Name: " .. tostring(game:GetService("Players")[tostring(TargetName)].Name))
		local Label2 = Tab:CreateLabel("Display Name: " .. tostring(game:GetService("Players")[tostring(TargetName)].DisplayName))
		local Label3 = Tab:CreateLabel("User ID: " .. tostring(game:GetService("Players")[tostring(TargetName)].UserId))
		local Label4 = Tab:CreateLabel("Account Age: " .. tostring(game:GetService("Players")[tostring(TargetName)].AccountAge) .. " Days")
		local Label5 = Tab:CreateLabel("Team: " .. tostring(game:GetService("Players")[tostring(TargetName)].Team))
		local Label6 = Tab:CreateLabel("Health: " .. tostring(game:GetService("Players")[tostring(TargetName)].Character.Humanoid.Health))
		spawn(function()
			while task.wait() do
				Label6:Set("Health: " .. tostring(game:GetService("Players")[tostring(TargetName)].Character.Humanoid.Health))
			end
		end)
		local Label7 = Tab:CreateLabel("Position: " .. tostring(math.floor(game:GetService("Players")[tostring(TargetName)].Character.HumanoidRootPart.Position.X)) .. ", " .. tostring(math.floor(game:GetService("Players")[tostring(TargetName)].Character.HumanoidRootPart.Position.Y)) .. ", " .. tostring(math.floor(game:GetService("Players")[tostring(TargetName)].Character.HumanoidRootPart.Position.Z)))
		spawn(function()
			while task.wait() do
				Label7:Set("Position: " .. tostring(math.floor(game:GetService("Players")[tostring(TargetName)].Character.HumanoidRootPart.Position.X)) .. ", " .. tostring(math.floor(game:GetService("Players")[tostring(TargetName)].Character.HumanoidRootPart.Position.Y)) .. ", " .. tostring(math.floor(game:GetService("Players")[tostring(TargetName)].Character.HumanoidRootPart.Position.Z)))
			end
		end)
		local state = game:GetService("Players")[tostring(TargetName)].Character.Humanoid:GetState()
		local Label8 = Tab:CreateLabel("Humanoid State: Loading...")
		spawn(function()
			while task.wait() do
				local state = game:GetService("Players")[tostring(TargetName)].Character.Humanoid:GetState()
				if state == Enum.HumanoidStateType.Freefall then
					Label8:Set("Humanoid State: Falling")
				elseif state == Enum.HumanoidStateType.Running then
					Label8:Set("Humanoid State: Running")
				elseif state == Enum.HumanoidStateType.RunningNoPhysics then
					Label8:Set("Humanoid State: RunningNoPhysics (deprecated)")
				elseif state == Enum.HumanoidStateType.Climbing then
					Label8:Set("Humanoid State: Climbing")
				elseif state == Enum.HumanoidStateType.StrafingNoPhysics then
					Label8:Set("Humanoid State: StrafingNoPhysics")
				elseif state == Enum.HumanoidStateType.Ragdoll then
					Label8:Set("Humanoid State: Ragdoll")
				elseif state == Enum.HumanoidStateType.GettingUp then
					Label8:Set("Humanoid State: GettingUp")
				elseif state == Enum.HumanoidStateType.Jumping then
					Label8:Set("Humanoid State: Jumping")
				elseif state == Enum.HumanoidStateType.Landed then
					Label8:Set("Humanoid State: Landed")
				elseif state == Enum.HumanoidStateType.Flying then
					Label8:Set("Humanoid State: Flying")
				elseif state == Enum.HumanoidStateType.Freefall then
					Label8:Set("Humanoid State: Freefall")
				elseif state == Enum.HumanoidStateType.Seated then
					Label8:Set("Humanoid State: Seated")
				elseif state == Enum.HumanoidStateType.PlatformStanding then
					Label8:Set("Humanoid State: PlatformStanding")
				elseif state == Enum.HumanoidStateType.Dead then
					Label8:Set("Humanoid State: Dead")
				elseif state == Enum.HumanoidStateType.Swimming then
					Label8:Set("Humanoid State: Swimming")
				elseif state == Enum.HumanoidStateType.Physics then
					Label8:Set("Humanoid State: Physics")
				elseif state == Enum.HumanoidStateType.None then
					Label8:Set("Humanoid State: None")
				elseif state == Enum.HumanoidStateType.Idle then
					Label8:Set("Humanoid State: Idle")
				end
			end
		end)
		local Tab = Window:CreateTab("Placed Items", 4483362458)
		for i, v in pairs(game:GetService("Players")[tostring(TargetName)].PlacedItems:GetDescendants()) do
			Tab:CreateLabel(tostring(v) .. ": " .. tostring(game:GetService("Players")[tostring(TargetName)].PlacedItems[tostring(v)].Value))
		end
		local Tab = Window:CreateTab("Owned Blocks", 4483362458)
		for i, v in pairs(game:GetService("Players")[tostring(TargetName)].Stats.Blocks:GetDescendants()) do
			Tab:CreateLabel(tostring(v) .. ": " .. tostring(game:GetService("Players")[tostring(TargetName)].Stats.Blocks[tostring(v)].Value))
		end
		local Tab = Window:CreateTab("Owned Soldiers", 4483362458)
		for i, v in pairs(game:GetService("Players")[tostring(TargetName)].Stats.Soldiers:GetDescendants()) do
			Tab:CreateLabel(tostring(v) .. ": " .. tostring(game:GetService("Players")[tostring(TargetName)].Stats.Soldiers[tostring(v)].Value))
		end
		local Tab = Window:CreateTab("Crates Unboxed", 4483362458)
		for i, v in pairs(game:GetService("Players")[tostring(TargetName)].Stats.CratesUnboxed:GetDescendants()) do
			Tab:CreateLabel(tostring(v) .. ": " .. tostring(game:GetService("Players")[tostring(TargetName)].Stats.CratesUnboxed[tostring(v)].Value))
		end
		local Tab = Window:CreateTab("Gamepasses", 4483362458)
		for i, v in pairs(game:GetService("Players")[tostring(TargetName)].Stats.Gamepasses:GetDescendants()) do
			Tab:CreateLabel(tostring(v) .. ": " .. tostring(game:GetService("Players")[tostring(TargetName)].Stats.Gamepasses[tostring(v)].Value))
		end
		local Tab = Window:CreateTab("Save Slots", 4483362458)
		for i, v in pairs(game:GetService("Players")[tostring(TargetName)].Stats.SaveSlots:GetDescendants()) do
			local Button = Tab:CreateButton({
				Name = tostring(v.Name),
				Callback = function()
					print(game:GetService("Players")[tostring(TargetName)].Stats.SaveSlots[tostring(v)].Value)
				end,
			})
		end
		local Tab = Window:CreateTab("Settings", 4483362458)
		for i, v in pairs(game:GetService("Players")[tostring(TargetName)].Stats.Settings:GetDescendants()) do
			Tab:CreateLabel(tostring(v) .. ": " .. tostring(game:GetService("Players")[tostring(TargetName)].Stats.Settings[tostring(v)].Value))
		end
		local Tab = Window:CreateTab("Skill", 4483362458)
		for i, v in pairs(game:GetService("Players")[tostring(TargetName)].Stats.Skill:GetDescendants()) do
			Tab:CreateLabel(tostring(v) .. ": " .. tostring(game:GetService("Players")[tostring(TargetName)].Stats.Skill[tostring(v)].Value))
		end
		local Tab = Window:CreateTab("Wealth", 4483362458)
		for i, v in pairs(game:GetService("Players")[tostring(TargetName)].Stats.Wealth:GetDescendants()) do
			Tab:CreateLabel(tostring(v) .. ": " .. tostring(game:GetService("Players")[tostring(TargetName)].Stats.Wealth[tostring(v)].Value))
		end
	end    
})

local Section = Tab:AddSection({
	Name = "Teleports"
})

Tab:AddButton({
	Name = "Blue Team",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Plots.Blue.Map.SpawnLocation.CFrame
	end    
})


Tab:AddButton({
	Name = "Red Team",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Plots.Red.Map.SpawnLocation.CFrame
	end    
})


Tab:AddButton({
	Name = "Green Team",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Plots.Green.Map.SpawnLocation.CFrame
	end    
})


Tab:AddButton({
	Name = "Yellow Team",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Plots.Yellow.Map.SpawnLocation.CFrame
	end    
})


local Section = Tab:AddSection({
	Name = "Info"
})
local Version = Tab:AddLabel("Server Version: " .. tostring(game.PlaceVersion))
local Uptime = Tab:AddLabel("Server Uptime: " .. math.floor(Workspace.DistributedGameTime))
local FramesPerSecond = Tab:AddLabel("FPS: " .. tostring(game:GetService("Workspace"):GetRealPhysicsFPS()))
local Ping = Tab:AddLabel("Ping: " .. tostring(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()))
local TimeElapsed = Tab:AddLabel("Time Elapsed: " .. string.format("%.1f", elapsedTime) .. " Seconds")
spawn(function()
	while task.wait() do
		FramesPerSecond:Set("FPS: " .. tostring(game:GetService("Workspace"):GetRealPhysicsFPS()))
	end
end)
spawn(function()
	while task.wait() do
		Ping:Set("Ping: " .. tostring(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()))
	end
end)
spawn(function()
	while task.wait() do
		Uptime:Set("Server Uptime: " .. math.floor(Workspace.DistributedGameTime))
	end
end)
spawn(function()
	while task.wait() do
		local elapsedTime = tick() - startTime
		TimeElapsed:Set("Time Elapsed: " .. string.format("%.1f", elapsedTime) .. " Seconds")
	end
end)
OrionLib:Init()
