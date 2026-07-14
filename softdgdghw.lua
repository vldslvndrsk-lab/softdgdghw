-- Delta Executor FE Admin Panel
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Створення інтерфейсу (GUI) через код для Delta
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeltaAdminPanel"
ScreenGui.Parent = game:GetService("CoreGui") or LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 250, 0, 300)
Frame.Position = UDim2.new(0.1, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 2
Frame.Active = true
Frame.Draggable = true -- Можна перетягувати пальцем/мишкою
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.Text = "DELTA ADMIN (DPTB 4)"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold
Title.Parent = Frame

-- Поле введення нікнейму цілі
local PlayerInput = Instance.new("TextBox")
PlayerInput.Size = UDim2.new(0.9, 0, 0, 35)
PlayerInput.Position = UDim2.new(0.05, 0, 0.18, 0)
PlayerInput.PlaceholderText = "Нікнейм гравця..."
PlayerInput.Text = ""
PlayerInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
PlayerInput.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerInput.Parent = Frame

-- Кнопка: Створити килим для себе
local CarpetBtn = Instance.new("TextButton")
CarpetBtn.Size = UDim2.new(0.9, 0, 0, 35)
CarpetBtn.Position = UDim2.new(0.05, 0, 0.35, 0)
CarpetBtn.Text = "Створити килим (Собі)"
CarpetBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
CarpetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CarpetBtn.Parent = Frame

-- Кнопка: Прив'язати килим до цілі (Покатати)
local GiveCarpetBtn = Instance.new("TextButton")
GiveCarpetBtn.Size = UDim2.new(0.9, 0, 0, 35)
GiveCarpetBtn.Position = UDim2.new(0.05, 0, 0.52, 0)
GiveCarpetBtn.Text = "Подарувати килим (Катати)"
GiveCarpetBtn.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
GiveCarpetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GiveCarpetBtn.Parent = Frame

-- Кнопка: Накрутка монет (Auto-Farm Coins)
local FarmBtn = Instance.new("TextButton")
FarmBtn.Size = UDim2.new(0.9, 0, 0, 35)
FarmBtn.Position = UDim2.new(0.05, 0, 0.69, 0)
FarmBtn.Text = "Накрутка монет (Auto-Farm): OFF"
FarmBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 85)
FarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmBtn.Parent = Frame

-- Кнопка закриття панелі
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0.9, 0, 0, 30)
CloseBtn.Position = UDim2.new(0.05, 0, 0.86, 0)
CloseBtn.Text = "Закрити чит"
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Parent = Frame

---------------- LOGIC ----------------

local activeCarpet = nil
local targetPlayer = nil
local farming = false

-- Функція пошуку гравця за частковим ніком
local function getPlayer(name)
	for _, p in ipairs(Players:GetPlayers()) do
		if string.sub(string.lower(p.Name), 1, string.len(name)) == string.lower(name) then
			return p
		end
	end
	return nil
end

-- Створення та логіка килима
local function createCarpet(owner)
	if activeCarpet then activeCarpet:Destroy() end

	local root = owner.Character and owner.Character:FindFirstChild("HumanoidRootPart")
	if not root then return end

	activeCarpet = Instance.new("Part")
	activeCarpet.Size = Vector3.new(7, 0.4, 7)
	activeCarpet.BrickColor = BrickColor.new("Bright red")
	activeCarpet.Material = Enum.Material.Neon
	activeCarpet.CFrame = root.CFrame * CFrame.new(0, -3.2, 0)
	activeCarpet.Parent = workspace

	local bv = Instance.new("BodyVelocity", activeCarpet)
	bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	bv.Velocity = Vector3.new(0,0,0)

	local bg = Instance.new("BodyGyro", activeCarpet)
	bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
	bg.CFrame = activeCarpet.CFrame

	local speed = 60
	local upSpeed = 30
	local keys = {}

	-- Керування на WASD / Space / Shift
	local bConn, eConn, loopConn
	bConn = UserInputService.InputBegan:Connect(function(input, gpe)
		if not gpe then keys[input.KeyCode] = true end
	end)
	eConn = UserInputService.InputEnded:Connect(function(input)
		keys[input.KeyCode] = nil
	end)

	loopConn = RunService.RenderStepped:Connect(function()
		if not activeCarpet or not activeCarpet:Parent() then
			bConn:Disconnect()
			eConn:Disconnect()
			loopConn:Disconnect()
			return
		end

		local cam = workspace.CurrentCamera
		local dir = Vector3.new(0,0,0)

		if keys[Enum.KeyCode.W] then dir = dir + cam.CFrame.LookVector end
		if keys[Enum.KeyCode.S] then dir = dir - cam.CFrame.LookVector end
		if keys[Enum.KeyCode.A] then dir = dir - cam.CFrame.RightVector end
		if keys[Enum.KeyCode.D] then dir = dir + cam.CFrame.RightVector end

		local moveH = Vector3.new(dir.X, 0, dir.Z).Unit
		moveH = moveH.Magnitude > 0 and moveH * speed or Vector3.new(0,0,0)

		local moveV = 0
		if keys[Enum.KeyCode.Space] then moveV = upSpeed end
		if keys[Enum.KeyCode.LeftShift] then moveV = -upSpeed end

		-- Якщо килим прив'язаний до цілі — він автоматично телепортує ціль за собою
		if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
			local tRoot = targetPlayer.Character.HumanoidRootPart
			bv.Velocity = Vector3.new(moveH.X, moveV, moveH.Z)
			tRoot.CFrame = activeCarpet.CFrame * CFrame.new(0, 3, 0)
		else
			-- Керування для себе
			bv.Velocity = Vector3.new(moveH.X, moveV, moveH.Z)
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				LocalPlayer.Character.HumanoidRootPart.CFrame = activeCarpet.CFrame * CFrame.new(0, 2.5, 0)
			end
		end

		bg.CFrame = CFrame.lookAt(activeCarpet.Position, activeCarpet.Position + Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z))
	end)
end

-- Кнопка: Килим собі
CarpetBtn.MouseButton1Click:Connect(function()
	targetPlayer = nil
	createCarpet(LocalPlayer)
end)

-- Кнопка: Килим для іншого гравця (Катати його)
GiveCarpetBtn.MouseButton1Click:Connect(function()
	local found = getPlayer(PlayerInput.Text)
	if found then
		targetPlayer = found
		createCarpet(found)
	else
		PlayerInput.Text = "Гравця не знайдено!"
	end
end)

-- Кнопка: Авто-фарм монет (Накрутка)
FarmBtn.MouseButton1Click:Connect(function()
	farming = not farming
	if farming then
		FarmBtn.Text = "Накрутка монет: ON"
		FarmBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
		
		task.spawn(function()
			while farming do
				task.wait(0.1)
				-- Шукаємо монети на карті в Don't Press The Button 4
				for _, obj in ipairs(workspace:GetDescendants()) do
					if not farming then break end
					if obj:IsA("TouchTransmitter") and (obj.Parent.Name:lower():find("coin") or obj.Parent.Name:lower():find("money")) then
						local coin = obj.Parent
						if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
							-- Телепортуємося до монети, щоб підібрати її
							local oldCF = LocalPlayer.Character.HumanoidRootPart.CFrame
							LocalPlayer.Character.HumanoidRootPart.CFrame = coin.CFrame
							task.wait(0.1)
							LocalPlayer.Character.HumanoidRootPart.CFrame = oldCF
						end
					end
				end
			end
		end)
	else
		FarmBtn.Text = "Накрутка монет: OFF"
		FarmBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 85)
	end
end)

-- Закрити чит
CloseBtn.MouseButton1Click:Connect(function()
	if activeCarpet then activeCarpet:Destroy() end
	farming = false
	ScreenGui:Destroy()
end)
