-- Gui to Lua
-- Version: 3.2

-- Instances:

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local TextButton = Instance.new("TextButton")

--Properties:

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.0118445922, 0, 0.0137173682, 0)
Frame.Size = UDim2.new(0, 123, 0, 270)

TextLabel.Parent = Frame
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(3.10137978e-08, 0, 0, 0)
TextLabel.Size = UDim2.new(0, 123, 0, 50)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "P00 ESP"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 20.000

TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(6.20275955e-08, 0, 0.459259272, 0)
TextButton.Size = UDim2.new(0, 123, 0, 50)
TextButton.Font = Enum.Font.SourceSans
TextButton.Text = "ESP"
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextSize = 14.000

-- Scripts:

local function JVLTCE_fake_script() -- Frame.Script 
	local script = Instance.new('Script', Frame)

	print("Hello world!")
	
end
coroutine.wrap(JVLTCE_fake_script)()
local function WXLKQ_fake_script() -- TextButton.LocalScript 
	local script = Instance.new('LocalScript', TextButton)

	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	
	local button = script.Parent -- This is the button the script is attached to
	local isBillboardEnabled = false -- Track if the billboards are enabled or not
	local billboardGuis = {} -- Store references to each player's BillboardGui
	
	-- Function to create a BillboardGui above a player's head
	local function createBillboardGui(player)
		local character = player.Character or player.CharacterAdded:Wait()
		local head = character:WaitForChild("Head")
	
		-- Create BillboardGui
		local billboardGui = Instance.new("BillboardGui")
		billboardGui.Size = UDim2.new(0, 200, 0, 50) -- Size of the GUI
		billboardGui.Adornee = head
		billboardGui.ExtentsOffset = Vector3.new(0, 2, 0) -- Offset above head
		billboardGui.AlwaysOnTop = true
		billboardGui.Enabled = false -- Initially disabled
	
		-- Create TextLabel
		local textLabel = Instance.new("TextLabel")
		textLabel.Size = UDim2.new(1, 0, 1, 0)
		textLabel.BackgroundTransparency = 1 -- Make background transparent
		textLabel.TextColor3 = Color3.new(1, 1, 1) -- Text color
		textLabel.TextScaled = true
		textLabel.Text = "" -- Initially empty text
		textLabel.Parent = billboardGui
	
		billboardGui.Parent = head
	
		return billboardGui, textLabel
	end
	
	-- Function to update the text label with distance and player name
	local function updateDistanceText(textLabel, player)
		local localPlayer = Players.LocalPlayer
		local character = localPlayer.Character
	
		if character then
			local localHead = character:FindFirstChild("Head")
			if localHead and player.Character then
				local playerHead = player.Character:FindFirstChild("Head")
				if playerHead then
					-- Calculate distance
					local distance = (localHead.Position - playerHead.Position).magnitude
					textLabel.Text = string.format("Distance: %.1f meters\nName: %s", distance, player.Name)
				end
			end
		end
	end
	
	-- Function to set up each player
	local function setupPlayer(player)
		local billboardGui, textLabel = createBillboardGui(player)
		billboardGuis[player] = billboardGui -- Store reference to BillboardGui
	
		-- Update text label on each frame if billboard is enabled
		RunService.RenderStepped:Connect(function()
			if isBillboardEnabled and billboardGui.Enabled then
				updateDistanceText(textLabel, player)
			end
		end)
	end
	
	-- Connect to PlayerAdded event to set up new players
	Players.PlayerAdded:Connect(function(player)
		player.CharacterAdded:Connect(function()
			setupPlayer(player) -- Set up the new player's BillboardGui
		end)
	end)
	
	-- Setup existing players
	for _, player in ipairs(Players:GetPlayers()) do
		if player.Character then
			setupPlayer(player)
		end
	end
	
	-- Toggle the BillboardGuis when the button is clicked
	button.MouseButton1Click:Connect(function()
		isBillboardEnabled = not isBillboardEnabled -- Toggle the state
	
		-- Iterate over all BillboardGuis and enable/disable them
		for player, billboardGui in pairs(billboardGuis) do
			if billboardGui and player.Character then
				billboardGui.Enabled = isBillboardEnabled -- Enable/Disable the BillboardGui
			end
		end
	
		-- Print a message for feedback (optional)
		if isBillboardEnabled then
			print("BillboardGui is now ON")
		else
			print("BillboardGui is now OFF")
		end
	end)
	
	
end
coroutine.wrap(WXLKQ_fake_script)()
