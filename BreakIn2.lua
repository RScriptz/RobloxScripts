-- Place Check
if game.PlaceId ~= 13864667823 then
	if game.PlaceId == 14775231477 or game.PlaceId == 13864661000 then
		for i, v in pairs(game:GetService("Workspace"):GetChildren()) do
			if v.Name == "Part" and v:FindFirstChild("TouchInterest") then
				firetouchinterest(v, game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, 0)
			end
		end
	else
		game:GetService("Players").LocalPlayer:Kick("Error! Game Not Supported!")
	end
else
    	-- Floating Part
	local Part = Instance.new("Part")
	Part.Size = Vector3.new(5, 1, 5)
	Part.Parent = game:GetService("Workspace")
	Part.Anchored = true
	Part.Transparency = 1

	-- Locals
	local Events = game:GetService("ReplicatedStorage"):WaitForChild("Events")
	local SelectedItem = "Med Kit"
	local Damange = 5
	local LocalPlayer = game:GetService("Players").LocalPlayer
	local Lighting = game:GetService("Lighting")
	local OriginalWalkspeed = LocalPlayer.Character.Humanoid.WalkSpeed
	local OriginalJumpPower = LocalPlayer.Character.Humanoid.JumpPower
	local ModifiedWalkspeed = 50
	local ModifiedJumpPower = 100
	local OriginalBrightness = Lighting.Brightness
	local OriginalFog = Lighting.FogEnd
	local OriginalShadow = Lighting.GlobalShadows
	
	-- Items Table
	local ItemsTable = {
		"Armor",
		"Med Kit",
		"Key",
		"Gold Key",
		"Louise",
		"Lollipop",
		"Chips",
		"Golden Apple",
		"Pizza",
		"Gold Pizza",
		"Rainbow Pizza",
		"Rainbow Pizza Box",
		"Book",
		"Phone",
		"Cookie",
		"Apple",
		"Bloxy Cola",
		"Expired Bloxy Cola",
		"Bottle",
		"Ladder",
		"Battery"
	}

	-- Functions
	local function UnequipAllTools()
		for i, v in pairs(LocalPlayer.Character:GetChildren()) do
			if v:IsA("Tool") then
				v.Parent = LocalPlayer.Backpack
			end
		end
	end
	local function EquipAllTools()
		for i, v in pairs(LocalPlayer.Backpack:GetChildren()) do
			if v:IsA("Tool") then
				v.Parent = LocalPlayer.Character
			end
		end
	end
	local function GiveItem(Item)
		if Item == "Armor" then
			Events:WaitForChild("Vending"):FireServer(3, "Armor2", "Armor", tostring(LocalPlayer), 1)
		else
			Events:WaitForChild("GiveTool"):FireServer(tostring(Item:gsub(" ", "")))
		end
	end
	local function Train(Ability)
		Events:WaitForChild("RainbowWhatStat"):FireServer(Ability)
	end
	local function TakeDamange(Amount)
		Events:WaitForChild("Energy"):FireServer(-Amount, false, false)
	end
	local function TeleportTo(CFrameArg)
		LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameArg
	end
	local function HealAllPlayers()
		UnequipAllTools()
		task.wait(.2)
		GiveItem("Golden Apple")
		task.wait(.5)
		LocalPlayer.Backpack:WaitForChild("GoldenApple").Parent = LocalPlayer.Character
		task.wait(.5)
		Events:WaitForChild("HealTheNoobs"):FireServer()
	end
	local function HealYourself()
		UnequipAllTools()
		task.wait(.2)
		GiveItem("Gold Pizza")
		task.wait(.5)
		LocalPlayer.Backpack:WaitForChild("GoldPizza").Parent = LocalPlayer.Character
		task.wait(.5)
		Events.CurePlayer:FireServer(game:GetService("Players").LocalPlayer, game:GetService("Players").LocalPlayer)
	end
	local function KillEnemies()
		for i, v in pairs(game:GetService("Workspace").BadGuys:GetChildren()) do
			v:FindFirstChild("Humanoid", true).Health = 0
		end
		for i, v in pairs(game:GetService("Workspace").BadGuysBoss:GetChildren()) do
			v:FindFirstChild("Humanoid", true).Health = 0
		end
		for i, v in pairs(game:GetService("Workspace").BadGuysFront:GetChildren()) do
			v:FindFirstChild("Humanoid", true).Health = 0
		end
	end

	local function GetDog()
		for i, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Assets.Note.Note.Note:GetChildren()) do
			if v.Name:match("Circle") and v.Visible == true then
				GiveItem(tostring(v.Name:gsub("Circle", "")))
				task.wait(.1)
				LocalPlayer.Backpack:WaitForChild(tostring(v.Name:gsub("Circle", ""))).Parent = LocalPlayer.Character
				TeleportTo(CFrame.new(-257.56839, 29.4499969, -910.452637, -0.238445505, 7.71292363e-09, 0.971155882, 1.2913591e-10, 1, -7.91029819e-09, -0.971155882, -1.76076387e-09, -0.238445505))
				task.wait(.5)
				Events:WaitForChild("CatFed"):FireServer(tostring(v.Name:gsub("Circle", "")))
			end
		end
		task.wait(2)
		for i = 1, 3 do
			TeleportTo(CFrame.new(-203.533081, 30.4500484, -790.901428, -0.0148558766, 8.85941187e-09, -0.999889672, 2.65695732e-08, 1, 8.46563175e-09, 0.999889672, -2.64408779e-08, -0.0148558766) + Vector3.new(0, 5, 0))
			task.wait(.1)
		end
	end

	local function GetAgent()
		GiveItem("Louise")
		task.wait(.1)
		LocalPlayer.Backpack:WaitForChild("Louise").Parent = LocalPlayer.Character
		Events:WaitForChild("LouiseGive"):FireServer(2)
	end

	local function GetUncle()
		GiveItem("Key")
		task.wait(.1)
		LocalPlayer.Backpack:WaitForChild("Key").Parent = LocalPlayer.Character
		wait(.5)
		Events.KeyEvent:FireServer()
	end
	local function ClickPete()
		fireclickdetector(game:GetService("Workspace").UnclePete.ClickDetector)
	end
	local function CollectCash()
		for i, v in pairs(game:GetService("Workspace"):GetChildren()) do
			if v.Name == "Part" and v:FindFirstChild("TouchInterest") and v:FindFirstChild("Weld") and v.Transparency == 1 then
				firetouchinterest(v, LocalPlayer.Character.HumanoidRootPart, 0)
			end
		end
	end
	local function GetAllOutsideItems()
		TeleportTo(CFrame.new(-199.240555, 30.0009422, -790.182739, 0.08340507, 2.48169538e-08, 0.996515751, -2.7112752e-09, 1, -2.46767993e-08, -0.996515751, -6.43658127e-10, 0.08340507))
		for i, v in pairs(game:GetService("Workspace").OutsideParts:GetChildren()) do
			fireclickdetector(v.ClickDetector)
		end
		LocalPlayer.Character.Humanoid:MoveTo(LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(-10, 0, 0))
	end
	local function BringAllEnemies()
		pcall(function()
			for i, v in pairs(game:GetService("Workspace").BadGuys:GetChildren()) do
				v.HumanoidRootPart.Anchored = true
				v.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -4)
			end
			for i, v in pairs(game:GetService("Workspace").BadGuysBoss:GetChildren()) do
				v.HumanoidRootPart.Anchored = true
				v.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -4)
			end
			
			for i, v in pairs(game:GetService("Workspace").BadGuysFront:GetChildren()) do
				v.HumanoidRootPart.Anchored = true
				v.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -4)
			end
		end)
	end
	local function Noclip(State)
		LocalPlayer.Character.HumanoidRootPart.CanCollide = State
		for i, v in pairs(LocalPlayer.Character:GetChildren()) do
			if v:IsA("MeshPart") then
				v.CanCollide = State
			end
		end
	end

	-- Main Script / GUI
	local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
	local function Notify(name, content, image, time)
		OrionLib:MakeNotification({
			Name = name,
			Content = content,
			Image = image,
			Time = time
		})
	end
	local Window = OrionLib:MakeWindow({
		Name = "Breaking Blitz",
		HidePremium = false,
		SaveConfig = true,
		ConfigFolder = "OrionTest",
		IntroText = "Loading Script..."
	})
	local Tab = Window:MakeTab({
		Name = "Overpowered",
		Icon = "rbxassetid://4483345998",
		PremiumOnly = false
	})
	local Section = Tab:AddSection({
		Name = "Item Giver"
	})
	Tab:AddParagraph("Note:", "Getting/Spamming Multiple Of 1 Type Of Items May Cause The Item To Break And Be Unuseable/Unequippable.\nIt Is Recommended To Only Grab 1 Item At Once, Especially If Its An Item Everyone Can Use.")

	Tab:AddDropdown({
		Name = "Item",
		Default = "Med Kit",
		Options = ItemsTable,
		Callback = function(Value)
			if Value == 'Book' or Value == 'Phone' then
				Notify('Warning', Value .. " Wont Work Unless You Own The Corresponding Gamepass.", 'rbxassetid://4483345998', 7)
			end
			SelectedItem = Value
		end
	})
	Tab:AddButton({
		Name = "Get Item",
		Callback = function()
			GiveItem(SelectedItem)
		end
	})
	local Section = Tab:AddSection({
		Name = "Training"
	})
	Tab:AddButton({
		Name = "Train Strength",
		Callback = function()
			Train("Strength")
		end
	})
	Tab:AddButton({
		Name = "Train Speed",
		Callback = function()
			Train("Speed")
		end
	})
	local Section = Tab:AddSection({
		Name = "Heal Youself"
	})
	Tab:AddButton({
		Name = "Heal Yourself",
		Callback = function()
			HealYourself()
		end
	})
	Tab:AddToggle({
		Name = "Loop Heal Yourself",
		Default = false,
		Callback = function(Value)
			getgenv().HealAllLoop = Value
			while HealAllLoop do
				HealYourself()
				task.wait(3)
			end
		end
	})
	local Section = Tab:AddSection({
		Name = "Heal All"
	})
	Tab:AddButton({
		Name = "Heal All",
		Callback = function()
			HealAllPlayers()
		end
	})
	Tab:AddToggle({
		Name = "Loop Heal All",
		Default = false,
		Callback = function(Value)
			getgenv().HealAllLoop = Value
			while HealAllLoop do
				HealAllPlayers()
				task.wait(3)
			end
		end
	})
	BringAllEnemies()
	local Section = Tab:AddSection({
		Name = "Others"
	})
	Tab:AddButton({
		Name = "Teleport To Private Lobby",
		Callback = function()
			game:GetService("TeleportService"):Teleport(14775231477, LocalPlayer)
		end
	})
	Tab:AddButton({
		Name = "Remove Hailing",
		Callback = function()
			if game:GetService("Workspace"):FindFirstChild("Hails") then
				game:GetService("Workspace").Hails:Destroy()
			end
		end
	})

	local Tab = Window:MakeTab({
		Name = "Teleports",
		Icon = "rbxassetid://4483345998",
		PremiumOnly = false
	})
	local Section = Tab:AddSection({
		Name = "Main"
	})
	Tab:AddButton({
		Name = "Boss Fight",
		Callback = function()
			TeleportTo(CFrame.new(-1565.78772, -368.711945, -1040.66626, 0.0929690823, -1.97564436e-08, 0.995669007, -1.53269308e-08, 1, 2.1273511e-08, -0.995669007, -1.72383299e-08, 0.0929690823))
		end
	})
	Tab:AddButton({
		Name = "Shop",
		Callback = function()
			TeleportTo(CFrame.new(-246.653229, 30.4500484, -847.319275, 0.999987781, -9.18427645e-08, -0.00494772941, 9.19905787e-08, 1, 2.96483353e-08, 0.00494772941, -3.01031164e-08, 0.999987781))
		end
	})
	Tab:AddButton({
		Name = "Kitchen",
		Callback = function()
			TeleportTo(CFrame.new(-249.753555, 30.4500484, -732.703125, -0.999205947, -1.97705017e-08, 0.0398429185, -2.00601384e-08, 1, -6.86967372e-09, -0.0398429185, -7.66347341e-09, -0.999205947))
		end
	})
	Tab:AddButton({
		Name = "Fighting Arena",
		Callback = function()
			TeleportTo(CFrame.new(-255.521988, 62.7139359, -723.436035, -0.0542500541, 4.28905356e-09, -0.998527408, 1.07862625e-08, 1, 3.70936082e-09, 0.998527408, -1.05691456e-08, -0.0542500541))
		end
	})
	Tab:AddButton({
		Name = "The Gym",
		Callback = function()
			TeleportTo(CFrame.new(-256.477448, 63.4500465, -840.825562, 0.999789953, 2.17116263e-08, 0.020495005, -2.15169358e-08, 1, -9.7199333e-09, -0.020495005, 9.27690191e-09, 0.999789953))
		end
	})
	Tab:AddButton({
		Name = "Golden Apple",
		Callback = function()
			TeleportTo(CFrame.new(61.8781624, 29.4499969, -534.381165, -0.584439218, -1.05103076e-07, 0.811437488, -3.12853778e-08, 1, 1.06993674e-07, -0.811437488, 3.71451705e-08, -0.584439218))
		end
	})
	Tab:AddButton({
		Name = "Feeding Instructions",
		Callback = function()
			TeleportTo(CFrame.new(-207.885056, 60.4500465, -830.583557, 0.118373089, 3.89876789e-08, -0.992969215, 3.47791551e-09, 1, 3.96783406e-08, 0.992969215, -8.15031065e-09, 0.118373089))
		end
	})
	Tab:AddButton({
		Name = "Middle Room",
		Callback = function()
			TeleportTo(CFrame.new(-209.951859, 30.4590473, -789.723877, -0.0485812724, 6.74905039e-08, 0.998819232, 1.19352916e-09, 1, -6.75122394e-08, -0.998819232, -2.08771045e-09, -0.0485812724))
		end
	})
	Tab:AddButton({
		Name = "Scarry Mary Pillar",
		Callback = function()
			CFrame.new(-1501.49597, -325.156891, -1060.63367, -0.691015959, 7.43958628e-09, 0.722839475, -5.03345055e-09, 1, -1.51040194e-08, -0.722839475, -1.40754954e-08, -0.691015959)
		end
	})
	Tab:AddButton({
		Name = "Outside Loot",
		Callback = function()
			TeleportTo(game:GetService("Workspace").OutsideParts:FindFirstChildWhichIsA("Part", true).CFrame + Vector3.new(10, 0, 0))
		end
	})
	Tab:AddButton({
		Name = "Experiment Room",
		Callback = function()
			TeleportTo(game:GetService("Workspace").Final.Factory.RedDesk.Drawer:GetChildren()[2].CFrame + Vector3.new(20, 0, 0))
		end
	})

	Tab:AddButton({
		Name = "Cafeteria",
		Callback = function()
			TeleportTo(game:GetService("Workspace").Final.Factory:FindFirstChild("Legs", true).CFrame)
		end
	})

	Tab:AddButton({
		Name = "Rainbow Pizza Box",
		Callback = function()
			TeleportTo(game:GetService("Workspace").RainbowPizzaBox.CFrame)
		end
	})

	local Section = Tab:AddSection({
		Name = "Npc's"
	})
	Tab:AddButton({
		Name = "Secret Agent Bradley",
		Callback = function()
			TeleportTo(CFrame.new(-281.792053, 95.4500275, -790.556946, -0.116918251, -7.95074726e-08, -0.993141532, -2.79918044e-09, 1, -7.97270019e-08, 0.993141532, -6.54155974e-09, -0.116918251))
		end
	})
	Tab:AddButton({
		Name = "Twando The Dog",
		Callback = function()
			TeleportTo(CFrame.new(-257.56839, 29.4499969, -910.452637, -0.238445505, 7.71292363e-09, 0.971155882, 1.2913591e-10, 1, -7.91029819e-09, -0.971155882, -1.76076387e-09, -0.238445505))
		end
	})
	Tab:AddButton({
		Name = "Uncle Pete",
		Callback = function()
			TeleportTo(CFrame.new(-294.208923, 63.4182587, -737.712036, -0.998669028, -7.34403613e-08, -0.05157727, -7.2258743e-08, 1, -2.47743781e-08, 0.05157727, -2.1014495e-08, -0.998669028))
		end
	})

	local Tab = Window:MakeTab({
		Name = "Humanoid",
		Icon = "rbxassetid://4483345998",
		PremiumOnly = false
	})
	local Section = Tab:AddSection({
		Name = "Settings"
	})

	Tab:AddSlider({
		Name = "Walk Speed",
		Min = 0,
		Max = 500,
		Default = 50,
		Color = Color3.fromRGB(0, 255, 0),
		Increment = 1,
		ValueName = "Speed",
		Callback = function(Value)
			ModifiedWalkspeed = Value
		end    
	})
	Tab:AddSlider({
		Name = "Jump Power",
		Min = 0,
		Max = 500,
		Default = 100,
		Color = Color3.fromRGB(0, 255, 0),
		Increment = 1,
		ValueName = "Power",
		Callback = function(Value)
			ModifiedJumpPower = Value
		end    
	})
	local Section = Tab:AddSection({
		Name = "Humanoid"
	})
	Tab:AddToggle({
		Name = "Enable Walk Speed",
		Default = false,
		Callback = function(Value)
			if Value == true then
				OriginalWalkspeed = LocalPlayer.Character.Humanoid.WalkSpeed
				LocalPlayer.Character.Humanoid.WalkSpeed = ModifiedWalkspeed
			else
				LocalPlayer.Character.Humanoid.WalkSpeed = OriginalWalkspeed
			end
		end    
	})
	Tab:AddToggle({
		Name = "Enable Jump Power",
		Default = false,
		Callback = function(Value)
			if Value == true then
				OriginalJumpPower = LocalPlayer.Character.Humanoid.JumpPower
				LocalPlayer.Character.Humanoid.JumpPower = ModifiedJumpPower
				LocalPlayer.Character.Humanoid.UseJumpPower = Value
			else
				LocalPlayer.Character.Humanoid.JumpPower = OriginalJumpPower
			end
		end    
	})
	Tab:AddToggle({
		Name = "Enable Noclip",
		Default = false,
		Callback = function(Value)
			getgenv().Noclipping = Value
			if Noclipping == true then
				spawn(function()
					while Noclipping == true do
						Noclip(false)
						task.wait(.05)
					end
				end)
			end
			if Noclipping == false then
				Noclip(true)
			end
		end
	})
	Tab:AddToggle({
		Name = "Enable Floating",
		Default = false,
		Callback = function(Value)
			getgenv().Float = Value
			if Float == true then
				spawn(function()
					while Float == true do
						Part.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, -4, 0)
						task.wait(.05)
					end
				end)
			end
			if Float == false then
				Part.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 999, 0)
			end
		end
	})
	local Tab = Window:MakeTab({
		Name = "Misc",
		Icon = "rbxassetid://4483345998",
		PremiumOnly = false
	})
	local Section = Tab:AddSection({
		Name = "Harmful"
	})
	Tab:AddSlider({
		Name = "Damange Amount",
		Min = 0,
		Max = 200,
		Default = 5,
		Color = Color3.fromRGB(0, 255, 0),
		Increment = 1,
		ValueName = "Damange",
		Callback = function(Value)
			Damange = Value
		end
	})
	Tab:AddButton({
		Name = "Damange Yourself",
		Callback = function()
			TakeDamange(Damange)
		end
	})
	Tab:AddButton({
		Name = "Slip",
		Callback = function()
			Events:WaitForChild("IceSlip"):FireServer(Vector3.new(0, 0, 0))
		end
	})
	local Section = Tab:AddSection({
		Name = "Tools"
	})
	Tab:AddButton({
		Name = "Equip All",
		Callback = function()
			EquipAllTools()
		end
	})
	Tab:AddButton({
		Name = "Unequip All",
		Callback = function()
			UnequipAllTools()
		end
	})
	local Section = Tab:AddSection({
		Name = "Bosses"
	})
	Tab:AddButton({
		Name = "Delete Scary Mary",
		Callback = function()
			game:GetService("Workspace").Villainess:Destroy()
		end
	})

	Tab:AddButton({
		Name = "Delete Scary Larry",
		Callback = function()
			game:GetService("Workspace").BigBoss:Destroy()
		end
	})
	local Section = Tab:AddSection({
		Name = "Kill Enemies"
	})

	Tab:AddButton({
		Name = "Kill All Enemies",
		Callback = function()
			KillEnemies()
		end
	})

	Tab:AddToggle({
		Name = "Loop Kill All",
		Default = false,
		Callback = function(Value)
			getgenv().KillAllLoop = Value
			while KillAllLoop do
				KillEnemies()
				task.wait(1)
			end
		end
	})
	local Section = Tab:AddSection({
		Name = "Bring Enemies"
	})
	

	Tab:AddButton({
		Name = "Bring All Enemies",
		Callback = function()
			BringAllEnemies()
		end
	})

	Tab:AddToggle({
		Name = "Loop Bring All",
		Default = false,
		Callback = function(Value)
			getgenv().BringAllLoop = Value
			while BringAllLoop do
				BringAllEnemies()
				task.wait(.1)
			end
		end
	})
	local Section = Tab:AddSection({
		Name = "NPC's"
	})

	Tab:AddButton({
		Name = "Get All NPC's",
		Callback = function()
			GetDog()
			task.wait(5)
			GetAgent()
			task.wait(1)
			GetUncle()
		end
	})

	Tab:AddButton({
		Name = "Get Dog",
		Callback = function()
			GetDog()
		end
	})
	Tab:AddButton({
		Name = "Get Agent Bradley",
		Callback = function()
			GetAgent()
		end
	})

	Tab:AddButton({
		Name = "Get Uncle Pete",
		Callback = function()
			GetUncle()
		end
	})
	local Section = Tab:AddSection({
		Name = "Cash"
	})
	Tab:AddButton({
		Name = "Collect Cash",
		Callback = function()
			CollectCash()
		end    
	})

	Tab:AddToggle({
		Name = "Auto Collect Cash",
		Default = false,
		Callback = function(Value)
			getgenv().CollectAllCash = Value

			while CollectAllCash do
				CollectCash()
				task.wait(1)
			end
		end    
	})

	local Section = Tab:AddSection({
		Name = "Others"
	})

	Tab:AddButton({
		Name = "Get All Items From Outside",
		Callback = function()
			GetAllOutsideItems()
		end    
	})
	
	Tab:AddToggle({
		Name = "Auto Claim Uncle Pete Quests",
		Default = false,
		Callback = function(Value)
			getgenv().AutoPete = Value

			while AutoPete do
				ClickPete()
				task.wait(10)
			end
		end    
	})

	Tab:AddToggle({
		Name = "Hidden Items ESP",
		Default = false,
		Callback = function(Value)
			if Value == true then
				for i, v in pairs(game:GetService("Workspace").Hidden:GetChildren()) do
					local highlight = Instance.new("Highlight")
					highlight.Parent = v
					highlight.FillColor = Color3.fromRGB(255, 0, 255)
					highlight.FillTransparency = 0
					highlight.OutlineTransparency = 0
					highlight.OutlineColor = Color3.fromRGB(0, 0, 255)
				end
			else
				for i, v in pairs(game:GetService("Workspace").Hidden:GetChildren()) do
					if v:FindFirstChild("Highlight") then
						v:FindFirstChild("Highlight"):Destroy()
					end
				end
			end
		end    
	})

	Tab:AddToggle({
		Name = "Full Bright",
		Default = false,
		Callback = function(Value)
			if Value == true then
				Lighting.Brightness = 1
				Lighting.FogEnd = 999999
				Lighting.GlobalShadows = false
			else
				Lighting.Brightness = OriginalBrightness
				Lighting.FogEnd = OriginalFog
				Lighting.GlobalShadows = GlobalShadows
			end
		end    
	})

	Notify('Loaded!', "Script Successfully Loaded!", 'rbxassetid://4483345998', 7)
	OrionLib:Init()
end
