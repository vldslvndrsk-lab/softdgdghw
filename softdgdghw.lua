-- Очікуємо завантаження гри
if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Видалення старої версії
local oldGui = game:GetService("CoreGui"):FindFirstChild("DeltaMobileUI") or LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("DeltaMobileUI")
if oldGui then oldGui:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeltaMobileUI"
ScreenGui.ResetOnSpawn = false

local success = pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
if not success then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

----------------------------------------------------------------
-- КНОПКА ВІДКРИТТЯ ПАНЕЛІ (Кругла)
----------------------------------------------------------------
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.2, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
ToggleBtn.Text = "MENU"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 14
ToggleBtn.Parent = ScreenGui

Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", ToggleBtn).Color = Color3.fromRGB(255, 255, 255)

----------------------------------------------------------------
-- ОСНОВНЕ МЕНЮ
----------------------------------------------------------------
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 240, 0, 300)
Frame.Position = UDim2.new(0.5, -120, 0.5, -150)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.Visible = false
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.Text = "MOBILE ADMIN"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Parent = Frame
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 10)

local PlayerInput = Instance.new("TextBox")
PlayerInput.Size = UDim2.new(0.9, 0, 0, 35)
PlayerInput.Position = UDim2.new(0.05, 0, 0.18, 0)
PlayerInput.PlaceholderText = "Нікнейм гравця..."
PlayerInput.Text = ""
PlayerInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
PlayerInput.TextColor3 = Color3.fromRGB(255, 255, 255)
PlayerInput.Parent = Frame
Instance.new("UICorner", PlayerInput).CornerRadius = UDim.new(0, 8)

local CarpetBtn = Instance.new("TextButton")
CarpetBtn.Size = UDim2.new(0.9, 0, 0, 35)
CarpetBtn.Position = UDim2.new(0.05, 0, 0.35, 0)
CarpetBtn.Text = "🚀 Мій Килим"
CarpetBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
CarpetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CarpetBtn.Parent = Frame
Instance.new("UICorner", CarpetBtn).CornerRadius = UDim.new(0, 8)

local GiveCarpetBtn = Instance.new("TextButton")
GiveCarpetBtn.Size = UDim2.new(0.9, 0, 0, 35)
GiveCarpetBtn.Position = UDim2.new(0.05, 0, 0.52, 0)
GiveCarpetBtn.Text = "🎁 Покатати іншого"
GiveCarpetBtn.BackgroundColor3 = Color3.fromRGB(230, 125, 0)
GiveCarpetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
GiveCarpetBtn.Parent = Frame
Instance.new("UICorner", GiveCarpetBtn).CornerRadius = UDim.new(0, 8)

local FarmBtn = Instance.new("TextButton")
FarmBtn.Size = UDim2.new(0.9, 0, 0, 35)
FarmBtn.Position = UDim2.new(0.05, 0, 0.69, 0)
FarmBtn.Text = "🪙 Автофарм: OFF"
FarmBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 85)
FarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmBtn.Parent = Frame
Instance.new("UICorner", FarmBtn).CornerRadius = UDim.new(0, 8)

local RemoveCarpetBtn = Instance.new("TextButton")
RemoveCarpetBtn.Size = UDim2.new(0.9, 0, 0, 30)
RemoveCarpetBtn.Position = UDim2.new(0.05, 0, 0.86, 0)
RemoveCarpetBtn.Text = "Видалити Килим"
RemoveCarpetBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
RemoveCarpetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RemoveCarpetBtn.Parent = Frame
Instance.new("UICorner", RemoveCarpetBtn).CornerRadius = UDim.new(0, 8)

----------------------------------------------------------------
-- МОБІЛЬНІ КНОПКИ КЕРУВАННЯ ПОЛЬОТОМ
----------------------------------------------------------------
local FlightControls = Instance.new("Frame")
FlightControls.Size = UDim2.new(0, 150, 0, 150)
FlightControls.Position = UDim2.new(0.7, 0, 0.6, 0)
FlightControls.BackgroundTransparency = 1
FlightControls.Visible = false
FlightControls.Parent = ScreenGui

-- Функція створення мобільних кнопок
local function createTouchBtn(name, pos, text)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0, 45, 0, 45)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.BackgroundTransparency = 0.3
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 20
    btn.Parent = FlightControls
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    return btn
end

local BtnUp = createTouchBtn("Up", UDim2.new(0.5, -22, 0, 0), "↑")
local BtnDown = createTouchBtn("Down", UDim2.new(0.5, -22, 0.7, 0), "↓")
local BtnForward = createTouchBtn("Forward", UDim2.new(0.5, -22, 0.35, 0), "W")
local BtnLeft = createTouchBtn("Left", UDim2.new(0.1, -10, 0.35, 0), "A")
local BtnRight = createTouchBtn("Right", UDim2.new(0.9, -10, 0.35, 0), "D")

----------------------------------------------------------------
-- ЛОГІКА
----------------------------------------------------------------
local activeCarpet = nil
local targetPlayer = nil
local farming = false
local moveStates = {Up = false, Down = false, Forward = false, Left = false, Right = false}

ToggleBtn.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
end)

local function getPlayer(name)
    for _, p in ipairs(Players:GetPlayers()) do
        if string.sub(string.lower(p.Name), 1, string.len(name)) == string.lower(name) then return p end
    end
    return nil
end

-- Прив'язка натискань до мобільних кнопок
local function bindBtn(btn, stateName)
    btn.MouseButton1Down:Connect(function() moveStates[stateName] = true end)
    btn.MouseButton1Up:Connect(function() moveStates[stateName] = false end)
    btn.MouseLeave:Connect(function() moveStates[stateName] = false end)
end

bindBtn(BtnUp, "Up")
bindBtn(BtnDown, "Down")
bindBtn(BtnForward, "Forward")
bindBtn(BtnLeft, "Left")
bindBtn(BtnRight, "Right")

local function createCarpet(owner)
    if activeCarpet then activeCarpet:Destroy() end
    local root = owner.Character and owner.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    activeCarpet = Instance.new("Part")
    activeCarpet.Size = Vector3.new(7, 0.4, 7)
    activeCarpet.BrickColor = BrickColor.new("Bright yellow")
    activeCarpet.Material = Enum.Material.Neon
    activeCarpet.CFrame = root.CFrame * CFrame.new(0, -3.2, 0)
    activeCarpet.Parent = workspace

    local bv = Instance.new("BodyVelocity", activeCarpet)
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bv.Velocity = Vector3.new(0,0,0)

    local bg = Instance.new("BodyGyro", activeCarpet)
    bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bg.CFrame = activeCarpet.CFrame

    FlightControls.Visible = true -- Показуємо мобільні кнопки керування

    local speed = 50
    local upSpeed = 25

    local loopConn
    loopConn = RunService.RenderStepped:Connect(function()
        if not activeCarpet or not activeCarpet:Parent() then
            FlightControls.Visible = false
            loopConn:Disconnect()
            return
        end

        local cam = workspace.CurrentCamera
        local dir = Vector3.new(0,0,0)

        if moveStates.Forward then dir = dir + cam.CFrame.LookVector end
        if moveStates.Left then dir = dir - cam.CFrame.RightVector end
        if moveStates.Right then dir = dir + cam.CFrame.RightVector end

        local moveH = Vector3.new(dir.X, 0, dir.Z).Unit
        moveH = moveH.Magnitude > 0 and moveH * speed or Vector3.new(0,0,0)

        local moveV = 0
        if moveStates.Up then moveV = upSpeed end
        if moveStates.Down then moveV = -upSpeed end

        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local tRoot = targetPlayer.Character.HumanoidRootPart
            bv.Velocity = Vector3.new(moveH.X, moveV, moveH.Z)
            tRoot.CFrame = activeCarpet.CFrame * CFrame.new(0, 3, 0)
        else
            bv.Velocity = Vector3.new(moveH.X, moveV, moveH.Z)
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = activeCarpet.CFrame * CFrame.new(0, 2.5, 0)
            end
        end

        bg.CFrame = CFrame.lookAt(activeCarpet.Position, activeCarpet.Position + Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z))
    end)
end

CarpetBtn.MouseButton1Click:Connect(function()
    targetPlayer = nil
    createCarpet(LocalPlayer)
    Frame.Visible = false -- Ховаємо меню після спавну, щоб не заважало
end)

GiveCarpetBtn.MouseButton1Click:Connect(function()
    local found = getPlayer(PlayerInput.Text)
    if found then
        targetPlayer = found
        createCarpet(found)
        Frame.Visible = false
    else
        PlayerInput.Text = "Не знайдено!"
        task.wait(1)
        PlayerInput.Text = ""
    end
end)

RemoveCarpetBtn.MouseButton1Click:Connect(function()
    if activeCarpet then activeCarpet:Destroy() end
    FlightControls.Visible = false
end)

FarmBtn.MouseButton1Click:Connect(function()
    farming = not farming
    if farming then
        FarmBtn.Text = "🪙 Автофарм: ON"
        FarmBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        task.spawn(function()
            while farming do
                task.wait(0.2)
                for _, obj in ipairs(workspace:GetDescendants()) do
                    if not farming then break end
                    if obj:IsA("TouchTransmitter") and (obj.Parent.Name:lower():find("coin") or obj.Parent.Name:lower():find("money")) then
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            local oldCF = LocalPlayer.Character.HumanoidRootPart.CFrame
                            LocalPlayer.Character.HumanoidRootPart.CFrame = obj.Parent.CFrame
                            task.wait(0.1)
                            LocalPlayer.Character.HumanoidRootPart.CFrame = oldCF
                        end
                    end
                end
            end
        end)
    else
        FarmBtn.Text = "🪙 Автофарм: OFF"
        FarmBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 85)
    end
end)
