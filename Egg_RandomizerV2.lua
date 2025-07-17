-- Pet Randomizer + Visual Age Setter v2
-- ✨ Full credit: munkizzz

-- 🚀 Loadstring Button GUI
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "ScriptLoaderGUI"
screenGui.ResetOnSpawn = false

local button = Instance.new("TextButton")
button.Text = "📜 Load Egg_RandomizerV2"
button.Font = Enum.Font.FredokaOne
button.TextSize = 16
button.TextColor3 = Color3.new(1,1,1)
button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
button.Position = UDim2.new(0, 100, 0, 100)
button.Size = UDim2.new(0, 200, 0, 40)
button.Parent = screenGui
Instance.new("UICorner", button)

local dragging = false
local offset
button.MouseButton1Down:Connect(function()
	dragging = true
	offset = Vector2.new(mouse.X - button.Position.X.Offset, mouse.Y - button.Position.Y.Offset)
end)
game:GetService("UserInputService").InputEnded:Connect(function()
	dragging = false
end)
game:GetService("RunService").RenderStepped:Connect(function()
	if dragging then
		button.Position = UDim2.new(0, mouse.X - offset.X, 0, mouse.Y - offset.Y)
	end
end)

button.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/munkizzzz/x/refs/heads/main/Egg_RandomizerV2.lua"))()
end)

-- 🐾 Visual Pet Age Level Button (Set to 50 for equipped pet)
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 350, 0, 160)
frame.Position = UDim2.new(0.5, -175, 0.5, -80)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", frame)

local title = Instance.new("TextLabel", frame)
title.Text = "Set Equipped Pet Age to 50"
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0, 40)

local petInfo = Instance.new("TextLabel", frame)
petInfo.Text = "Equipped Pet: [None]"
petInfo.Font = Enum.Font.Gotham
petInfo.TextSize = 18
petInfo.TextColor3 = Color3.fromRGB(255, 255, 150)
petInfo.BackgroundTransparency = 1
petInfo.Position = UDim2.new(0, 0, 0, 40)
petInfo.Size = UDim2.new(1, 0, 0, 30)

local ageButton = Instance.new("TextButton", frame)
ageButton.Text = "Set Age to 50"
ageButton.Font = Enum.Font.GothamBold
ageButton.TextSize = 18
ageButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ageButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
ageButton.Size = UDim2.new(0, 240, 0, 40)
ageButton.Position = UDim2.new(0.5, -120, 1, -50)
Instance.new("UICorner", ageButton)

-- Draggable Age Button Frame
local dragFrame = Instance.new("TextButton", title)
dragFrame.Size = UDim2.new(1, 0, 1, 0)
dragFrame.Text = ""
dragFrame.BackgroundTransparency = 1
local drag2, offset2
dragFrame.MouseButton1Down:Connect(function()
	drag2 = true
	offset2 = Vector2.new(mouse.X - frame.Position.X.Offset, mouse.Y - frame.Position.Y.Offset)
end)
game:GetService("UserInputService").InputEnded:Connect(function()
	drag2 = false
end)
game:GetService("RunService").RenderStepped:Connect(function()
	if drag2 then
		frame.Position = UDim2.new(0, mouse.X - offset2.X, 0, mouse.Y - offset2.Y)
	end
end)

-- Get Equipped Tool with Age
local function getEquippedPetTool()
	local char = player.Character or player.CharacterAdded:Wait()
	for _, tool in pairs(char:GetChildren()) do
		if tool:IsA("Tool") and tool.Name:find("Age") then
			return tool
		end
	end
	return nil
end

-- Update Display
local function updatePetDisplay()
	local tool = getEquippedPetTool()
	if tool then
		petInfo.Text = "Equipped Pet: " .. tool.Name
	else
		petInfo.Text = "Equipped Pet: [None]"
	end
end

-- Button Logic (Visual only)
local cooldown = false
ageButton.MouseButton1Click:Connect(function()
	if cooldown then return end
	local tool = getEquippedPetTool()
	if tool then
		local newName = tool.Name:gsub("%[Age%s%d+%]", "[Age 50]")
		tool.Name = newName
		petInfo.Text = "Equipped Pet: " .. tool.Name
		cooldown = true
		local t = 20
		while t > 0 do
			ageButton.Text = "Cooldown: " .. t .. "s"
			task.wait(1)
			t -= 1
		end
		ageButton.Text = "Set Age to 50"
		cooldown = false
	end
end)

while true do task.wait(1) updatePetDisplay() end
