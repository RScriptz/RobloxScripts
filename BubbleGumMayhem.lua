--[[
Credits To: https://v3rmillion.net/member.php?action=profile&uid=1289763 For The Remote Bypass!
The Teleporting Is Currently Broken, Ill Be Fixing It If I See Some Small Sctivity Script-Wise Or If Someone Asks Me To.
Feel Free To Modify It As Long As You Dont Obfuscate/Sell/Put It Behind A Key Sys.
Please Suggest New Features In Our Discord: https://dsc.gg/boatblitz
]]


--// Setting Up Tables
local EggsTable  = {}
local PetsTable  = {}
local WorldTable = {
	"Overworld",
	"Fall Carnival",
	"Halloween"
}

--// Setting Up Toggles
getgenv().AutoBlowBubbles     = false
getgenv().AutoPickupPumpkins  = false
getgenv().AutoPickupCandyCorn = false
getgenv().AutoPickupGems      = false
getgenv().AutoPickupExp       = false
getgenv().AutoPickupGold      = false
getgenv().AutoSellBubbles     = false
getgenv().AutoHatch           = false
getgenv().TrickOrTreats       = false
getgenv().AutoCollectChests   = false
getgenv().AutoEquipPets       = false
getgenv().AutoFusePets        = false
getgenv().Float               = false
getgenv().EnableNoclip        = false
getgenv().AntiMod             = true

--// Setting Up Client Locals
local LocalPlayer    = game:GetService("Players").LocalPlayer
local ClientCore     = game:GetService("ReplicatedStorage").Modules.Client.ClientCore
local Character      = LocalPlayer.Character

--// Setting Up Workspace Locals
local ActivationPads = game:GetService("Workspace").Activations -- Auto Sell, Auto Chests, Auto Trick Or Treat, More
local Pickups        = game:GetService("Workspace").Pickups

--// Setting Up Script Locals
local OriginalWalkspeed = Character.Humanoid.WalkSpeed
local OriginalJumpPower = Character.Humanoid.JumpPower
local ModifiedWalkspeed = 50
local ModifiedJumpPower = 100
local SelectedEgg       = {"Common Egg"}
local EquipStats        = "Bubbles"
local SpoofedText       = "999999999"
local SelectedPet       = "None"
local MultiEggs         = false
local ClonedPet         = nil

--// Setting Up Remote Locals
local FireServer
local InvokeServer
local RemoteEvent
local RemoteFunction

--// Remote Encryption Bypass
for i, v in next, getgc(true) do
	if typeof(v) == "table" and rawget(v, "FireServer") and rawget(v, "InvokeServer") and rawget(v, "Call") then
		FireServer = rawget(v, "FireServer")
		InvokeServer = rawget(v, "InvokeServer")
	end
end

--// Setting Up the Main Remotes
RemoteEvent = getupvalue(FireServer, 1)
RemoteFunction = getupvalue(InvokeServer, 1)

--// Grabbing The Current Eggs
for i, v in pairs(game:GetService("Workspace").Eggs:GetChildren()) do
	if not table.find(EggsTable, v.Name) then
		table.insert(EggsTable, v.Name)
	end
end

--// Grabbing The Current Pets
for i, v in pairs(game:GetService("ReplicatedStorage").Assets.Pets:GetChildren()) do
	if not table.find(PetsTable, v.Name) then
		table.insert(PetsTable, v.Name)
	end
end

--// Grabbing The Current Islands
for i, v in pairs(game:GetService("Workspace").Checkpoints:GetChildren()) do
	if not table.find(WorldTable, v.Name) then
		table.insert(WorldTable, v.Name)
	end
end

--// Setting Up The Float Part
local Part = Instance.new("Part")
Part.Size = Vector3.new(5, 1, 5)
Part.Parent = game:GetService("Workspace")
Part.Anchored = true
Part.Transparency = 1


--// Setting Up Functions
local function BlowBubbles()
	RemoteEvent:FireServer("BlowBubble")
end

local function SellBubbles()
	RemoteEvent:FireServer("SellBubble", "TwighlightSell")
end

local function CollectItem(ItemMatch)
	for i, v in pairs(game:GetService("Workspace").Pickups:GetChildren()) do
		if v.Name:match(ItemMatch) and v:FindFirstChild("PickupHitbox") then
			for i = 1, 3 do
				if v:FindFirstChild("PickupHitbox") then
					Character.HumanoidRootPart.CFrame = v.PickupHitbox.CFrame
					task.wait(.25)
				end
			end
			task.wait(.5)
			break
		end
	end
end

local function HatchEgg(EggName)
	for i, v in pairs(EggName) do
		Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Eggs[v].Hotkey.CFrame * CFrame.new(0, 0, 4)
		task.wait(.1)
		if MultiEggs == false then
			RemoteEvent:FireServer("HatchEgg", v)
		else
			RemoteEvent:FireServer("HatchEgg", v, "Multi")
		end
	end
end

local function TeleportToWorld(WorldName)
	if game:GetService("Workspace").Checkpoints:FindFirstChild(WorldName) then
		RemoteEvent:FireServer("TeleportToCheckpoint", WorldName)
	else
		require(ClientCore.WorldService):SetWorld(WorldName)
		task.wait(2)
		RemoteEvent:FireServer("LoadWorld", WorldName)
	end
end

local function TrickOrTreat()
	for i, v in pairs(ActivationPads.TrickOrTreat:GetChildren()) do
		Character.HumanoidRootPart.CFrame = v.Root.CFrame
		break
	end
end

local function CollectChests()
	for i, v in pairs(game:GetService("Workspace").Checkpoints:GetChildren()) do
		RemoteEvent:FireServer("CollectChestReward", tostring(v.Name))
		task.wait(2.5)
	end
end

local function EquipBestPets(PetStat)
	RemoteEvent:FireServer("EquipBest", PetStat)
end

local function FusePets()
	for i, v in pairs(LocalPlayer.PlayerGui.ScreenGui.PetsFrame.Main.Pages.Pets.List.Grid:GetChildren()) do
		if v.Name == "PetItem" and v.Locked.Visible == false then
			RemoteEvent:FireServer("UpgradePetTier", tostring(v.GUID.Value))
		end
	end
end

local function Noclip(State)
	LocalPlayer.Character.HumanoidRootPart.CanCollide = State
	for i, v in pairs(LocalPlayer.Character:GetChildren()) do
		if v:IsA("MeshPart") then
			v.CanCollide = State
		end
	end
end

--// Setting Up Toggles
spawn(function()
	while task.wait() do
		if AutoSellBubbles == true then
			SellBubbles()
		end
	end
end)

spawn(function()
	while task.wait() do
		if AutoBlowBubbles == true then
			BlowBubbles()
		end
	end
end)

spawn(function()
	while task.wait() do
		if AutoPickupPumpkins == true then
			CollectItem("Fall")
		end
	end
end)

spawn(function()
	while task.wait() do
		if AutoPickupCandyCorn == true then
			CollectItem("Halloween")
		end
	end
end)

spawn(function()
	while task.wait() do
		if AutoPickupGems == true then
			CollectItem("Void")
		end
	end
end)

spawn(function()
	while task.wait() do
		if AutoPickupExp == true then
			CollectItem("XP")
		end
	end
end)

spawn(function()
	while task.wait() do
		if AutoPickupGold == true then
			CollectItem("Space")
		end
	end
end)

spawn(function()
	while task.wait() do
		if AutoHatch == true then
			HatchEgg(SelectedEgg)
		end
	end
end)

spawn(function()
	while task.wait(2.5) do
		if TrickOrTreats == true then
			SellBubbles()
		end
	end
end)

spawn(function()
	while task.wait(5) do
		if AutoFusePets == true then
			FusePets()
		end
	end
end)

spawn(function()
	while task.wait(10) do
		if AutoEquipPets == true then
			EquipBestPets(EquipStats)
		end
	end
end)

spawn(function()
	while task.wait() do
		if AutoCollectChests == true then
			CollectChests()
			task.wait(180)
		end
	end
end)

spawn(function()
	game:GetService("Players").PlayerAdded:Connect(function(Moderator)
		if Moderator:IsInGroup(32790260) and AntiMod == true then
			LocalPlayer:Kick("A Moderator/Developer Joined! (" .. tostring(Moderator.Name) .. ")")
		end
	end)
end)

spawn(function()
	while task.wait() do
		if Float == true then
			spawn(function()
				while Float == true do
					Part.CFrame = Character.HumanoidRootPart.CFrame + Vector3.new(0, -4, 0)
					task.wait(.05)
				end
			end)
		end
		if Float == false then
			Part.CFrame = Character.HumanoidRootPart.CFrame + Vector3.new(0, 999, 0)
		end
	end
end)

spawn(function()
	while task.wait() do
		if EnableNoclip == true then
			spawn(function()
				while EnableNoclip == true do
					Noclip(false)
					task.wait(.05)
				end
			end)
		end
		if EnableNoclip == false then
			Noclip(true)
		end
	end
end)

--// Executing The Main Script
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/UI-Interface/CustomFIeld/main/RayField.lua'))()

local Window = Rayfield:CreateWindow({
	Name = "Bubble Blitz",
	LoadingTitle = "Loading Bubble Blitz",
	LoadingSubtitle = "By QuePro, Special Thanks To Shayman For The Remote Bypass!",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "Boat Blitz Community",
		FileName = "BubbleBlitz"
	},
})

local Tab = Window:CreateTab("Automation", 4483362458)

local Main = Tab:CreateSection("Bubbles", true)

local Toggle = Tab:CreateToggle({
	Name = "Auto Blow Bubbles",
	Info = "Automatically Blows Bubbles.",
	CurrentValue = false,
	Flag = "AutoBlowBubbles",
	Callback = function(Value)
		AutoBlowBubbles = Value
	end,
})

local Toggle = Tab:CreateToggle({
	Name = "Auto Sell Bubbles",
	Info = "Automatically Sells Bubbles.",
	CurrentValue = false,
	Flag = "AutoSellBubbles",
	Callback = function(Value)
		AutoSellBubbles = Value
	end,
})

local Main = Tab:CreateSection("Hatch Settings", true)

local Dropdown = Tab:CreateDropdown({
	Name = "Sellect Egg",
	Options = EggsTable,
	CurrentOption = "Common Egg",
	MultiSelection = true,
	Flag = "EggsDropdown",
	Callback = function(Option)
		SelectedEgg = Option
	end,
})

local Dropdown = Tab:CreateDropdown({
	Name = "Hatch Mode",
	Options = {
		"Single Egg",
		"Multiple Eggs"
	},
	CurrentOption = "Single Egg",
	MultiSelection = false,
	Flag = "EggHatchModeDropdown",
	Callback = function(Option)
		if Option == "Single Egg" then
			MultiEggs = false
		else
			MultiEggs = true
		end
	end,
})

local Main = Tab:CreateSection("Hatching", true)
local Toggle = Tab:CreateToggle({
	Name = "Auto Hatch",
	Info = "Automatically Hatches The Selected Egg.",
	CurrentValue = false,
	Flag = "AutoHatch",
	Callback = function(Value)
		AutoHatch = Value
	end,
})

local Button = Tab:CreateButton({
	Name = "Hatch Egg",
	Info = "Hatches The Selected Egg Once.", 
	Interact = 'Changable',
	Callback = function()
		HatchEgg(SelectedEgg)
	end,
})

local Main = Tab:CreateSection("Pets", true)

local Dropdown = Tab:CreateDropdown({
	Name = "Auto Equip Currency",
	Options = {
		"Bubbles",
		"Coins",
		"Gems",
		"Cogwheels",
		"Pumpkins",
		"Candycorn"
	},
	CurrentOption = "Bubbles",
	MultiSelection = false,
	Flag = "AutoEquipCurrency",
	Callback = function(Option)
		EquipStats = tostring(Option)
	end,
})

local Toggle = Tab:CreateToggle({
	Name = "Auto Equip Best Pets",
	Info = "Automatically Equips The Best Pets In The Selected Category.",
	CurrentValue = true,
	Flag = "AutoEquip",
	Callback = function(Value)
		AutoEquipPets = Value
	end,
})

local Toggle = Tab:CreateToggle({
	Name = "Auto Fuse Pets (Must Have Pet UI Open!)",
	Info = "Automatically Fuses Your Pets if The Pet UI Is Open.",
	CurrentValue = true,
	Flag = "AutoFuse",
	Callback = function(Value)
		AutoFusePets = Value
	end,
})

local Tab = Window:CreateTab("Pickups", 4483362458)

local Section = Tab:CreateSection("Fall World", true)

local Toggle = Tab:CreateToggle({
	Name = "Auto Pickup Pumpkins",
	Info = "Automatically Picks Up Pumpkins From The Fall World.",
	CurrentValue = false,
	Flag = "AutoPickPumpkins",
	Callback = function(Value)
		AutoPickupPumpkins = Value
	end,
})

local Section = Tab:CreateSection("Haloween World", true)

local Toggle = Tab:CreateToggle({
	Name = "Auto Pickup CandyCorn",
	Info = "Automatically Picks Up Candy Corn From The Halloween World.",
	CurrentValue = false,
	Flag = "AutoPickCandyCorn",
	Callback = function(Value)
		AutoPickupCandyCorn = Value
	end,
})

local Toggle = Tab:CreateToggle({
	Name = "Auto Trick Or Treat",
	Info = "Automatically Goes Trick Or Treating.",
	CurrentValue = false,
	Flag = "AutoTrickOrTreat",
	Callback = function(Value)
		TrickOrTreats = Value
	end,
})

local Section = Tab:CreateSection("Overworld", true)

local Toggle = Tab:CreateToggle({
	Name = "Auto Pickup Gold",
	Info = "Automatically Picks Up Gold From The Space.",
	CurrentValue = false,
	Flag = "AutoPickGold",
	Callback = function(Value)
		AutoPickupGold = Value
	end,
})

local Toggle = Tab:CreateToggle({
	Name = "Auto Pickup Gems",
	Info = "Automatically Picks Up Gems From The Void.",
	CurrentValue = false,
	Flag = "AutoPickGems",
	Callback = function(Value)
		AutoPickupGems = Value
	end,
})

local Toggle = Tab:CreateToggle({
	Name = "Auto Pickup EXP",
	Info = "Automatically Picks Up Experience From The XP Island.",
	CurrentValue = false,
	Flag = "AutoPickEXP",
	Callback = function(Value)
		AutoPickupExp = Value
	end,
})

local Tab = Window:CreateTab("Spoofing", 4483362458)

local Section = Tab:CreateSection("Spoofing Text", true)

local Input = Tab:CreateInput({
	Name = "Spoofed Text",
	Info = "The Text That Will Be Spoofed",
	PlaceholderText = "999999999",
	NumbersOnly = false,
	OnEnter = false,
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		SpoofedText = Text
	end,
})

local Section = Tab:CreateSection("Spoof", true)
local Button = Tab:CreateButton({
	Name = "Spoof Pity",
	Interact = 'Spoof',
	Callback = function()
		LocalPlayer.PlayerGui.ScreenGui.StatsFrame.PlayerStats.PlayerPity.Text = SpoofedText
	end,
})

local Button = Tab:CreateButton({
	Name = "Spoof Bubbles",
	Interact = 'Spoof',
	Callback = function()
		LocalPlayer.PlayerGui.ScreenGui.StatsFrame.Stats.Bubble.Amount.Text = SpoofedText
	end,
})

local Button = Tab:CreateButton({
	Name = "Spoof Candycorn",
	Interact = 'Spoof',
	Callback = function()
		LocalPlayer.PlayerGui.ScreenGui.StatsFrame.Stats.Candycorn.Amount.Text = SpoofedText
	end,
})

local Button = Tab:CreateButton({
	Name = "Spoof Cogwheels",
	Interact = 'Spoof',
	Callback = function()
		LocalPlayer.PlayerGui.ScreenGui.StatsFrame.Stats.Cogwheels.Amount.Text = SpoofedText
	end,
})

local Button = Tab:CreateButton({
	Name = "Spoof Coins",
	Interact = 'Spoof',
	Callback = function()
		LocalPlayer.PlayerGui.ScreenGui.StatsFrame.Stats.Coins.Amount.Text = SpoofedText
	end,
})

local Button = Tab:CreateButton({
	Name = "Spoof Gems",
	Interact = 'Spoof',
	Callback = function()
		LocalPlayer.PlayerGui.ScreenGui.StatsFrame.Stats.Gems.Amount.Text = SpoofedText
	end,
})

local Button = Tab:CreateButton({
	Name = "Spoof Pumpkins",
	Interact = 'Spoof',
	Callback = function()
		LocalPlayer.PlayerGui.ScreenGui.StatsFrame.Stats.Pumpkins.Amount.Text = SpoofedText
	end,
})

local Button = Tab:CreateButton({
	Name = "Spoof Coins Leaderstat",
	Interact = 'Spoof',
	Callback = function()
		LocalPlayer.leaderstats.Coins.Value = SpoofedText
	end,
})

local Button = Tab:CreateButton({
	Name = "Spoof Gems Leaderstat",
	Interact = 'Spoof',
	Callback = function()
		LocalPlayer.leaderstats.Gems.Value = SpoofedText
	end,
})

local Button = Tab:CreateButton({
	Name = "Spoof Eggs Leaderstat",
	Interact = 'Spoof',
	Callback = function()
		LocalPlayer.leaderstats["Eggs Opened"].Value = SpoofedText
	end,
})

local Button = Tab:CreateButton({
	Name = "Spoof Bubbles Leaderstat",
	Interact = 'Spoof',
	Callback = function()
		LocalPlayer.leaderstats["Bubbles Blown"].Value = SpoofedText
	end,
})

local Button = Tab:CreateButton({
	Name = "Spoof Player Tag",
	Interact = 'Spoof',
	Callback = function()
		LocalPlayer.Character.CustomPlayerTag.Username.Text = SpoofedText
	end,
})

local Button = Tab:CreateButton({
	Name = "Spoof Username",
	Interact = 'Spoof',
	Callback = function()
		LocalPlayer.Name = SpoofedText
	end,
})

local Button = Tab:CreateButton({
	Name = "Spoof User ID",
	Interact = 'Spoof',
	Callback = function()
		LocalPlayer.UserId = SpoofedText
	end,
})

local Button = Tab:CreateButton({
	Name = "Spoof Display Name",
	Interact = 'Spoof',
	Callback = function()
		LocalPlayer.DisplayName = SpoofedText
	end,
})
 
local Tab = Window:CreateTab("Misc", 4483362458)

local Section = Tab:CreateSection("Teleports", true)

local Dropdown = Tab:CreateDropdown({
	Name = "Teleport To",
	Options = WorldTable,
	CurrentOption = "Warning: Currently Buggy!",
	MultiSelection = false,
	Callback = function(Option)
		TeleportToWorld(Option)
	end,
})

local Button = Tab:CreateButton({
	Name = "Unlock All Islands",
	Info = "Unlocks All Islands From The Overworld",
	Interact = 'Unlock',
	Callback = function()
		for i, v in pairs(game:GetService("Workspace").FloatingIslands.Overworld:GetChildren()) do
			Character.HumanoidRootPart.CFrame = v.TeleportPoint.CFrame
			task.wait(1)
		end
	end,
})
local Section = Tab:CreateSection("Humanoid", true)

local Toggle = Tab:CreateToggle({
	Name = "Enable Noclip",
	Info = "Makes Your Character Walk Thru Walls.",
	CurrentValue = false,
	Flag = "AutoNoclip",
	Callback = function(Value)
		EnableNoclip = Value
	end
})

local Toggle = Tab:CreateToggle({
	Name = "Enable Floating",
	Info = "Makes Your Character Float",
	CurrentValue = false,
	Flag = "AutoFloat",
	Callback = function(Value)
		Float = Value
	end
})

local Section = Tab:CreateSection("Visuals", true)

local Dropdown = Tab:CreateDropdown({
	Name = "Selected Pet",
	Options = PetsTable,
	CurrentOption = "None",
	MultiSelection = false,
	Flag = "PetsTBL",
	Callback = function(Option)
		SelectedPet = Option
	end,
})

local Toggle = Tab:CreateToggle({
	Name = "View Pet",
	Info = "Shows the Selected Pet",
	CurrentValue = true,
	Flag = "ShowPet",
	Callback = function(Value)
		if Value == true then
			for i, v in pairs(SelectedPet) do
				ClonedPet = game:GetService("ReplicatedStorage").Assets.Pets[v]:Clone()
				ClonedPet.Parent = game:GetService("Workspace")
				ClonedPet.Name = "DoggyCP"
				ClonedPet:PivotTo(Character.HumanoidRootPart.CFrame)
			end
		else
			if game:GetService("Workspace"):FindFirstChild("DoggyCP") then
				ClonedPet:Destroy()
				ClonedPet = nil
			end
		end
	end,
})

local Section = Tab:CreateSection("Others", true)
local Toggle = Tab:CreateToggle({
	Name = "Auto Collect Chests",
	Info = "Automatically Collects Overworld Chests.",
	CurrentValue = true,
	Flag = "AutoChests",
	Callback = function(Value)
		AutoCollectChests = Value
	end,
})

local Toggle = Tab:CreateToggle({
	Name = "Kick On Mod Join",
	Info = "Kicks LocalPlayer On Mod Join.",
	CurrentValue = true,
	Flag = "KickOnMod",
	Callback = function(Value)
		AntiMod = Value
	end,
})

Rayfield:Notify({
	Title = "Script Loaded!",
	Content = "Please Join Our Discord We Need Feature Suggestions!\nhttps://dsc.gg/boatblitz",
	Duration = 6.5,
	Image = 4483362458,
	Actions = {
		Join = {
			Name = "Copy Discord Link",
			Callback = function()
				setclipboard("https://dsc.gg/boatblitz")
			end
		},
	},
})
