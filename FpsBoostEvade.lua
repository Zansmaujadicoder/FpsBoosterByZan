-- 1. NOTIFIKASI AWAL & OPTIMASI GRAFIS
print("[+] FPS Booster Evade dijalankan...")

local Lighting = game:GetService("Lighting")
Lighting.GlobalShadows = false
Lighting.FogEnd = 9e9
Lighting.Brightness = 2

for _, v in pairs(Lighting:GetChildren()) do
    if v:IsA("PostEffect") or v:IsA("Atmosphere") then
        v:Destroy()
    end
end

for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("BasePart") then
        v.Material = Enum.Material.SmoothPlastic
        v.CastShadow = false
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
        v:Destroy()
    end
end

-- 2. MEMBUAT TAMPILAN GUI (UI & FPS COUNTER) OTOMATIS
local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("EvadeFPSBoosterGUI") then
    playerGui.EvadeFPSBoosterGUI:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "EvadeFPSBoosterGUI"
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 220, 0, 90)
mainFrame.Position = UDim2.new(0, 15, 0, 15)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 40)
statusLabel.Position = UDim2.new(0, 0, 0, 5)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
statusLabel.TextSize = 13
statusLabel.Font = Enum.Font.GothamBold
statusLabel.Text = "Status: Script Berhasil Dieksekusi! 🚀"
statusLabel.Parent = mainFrame

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(1, 0, 0, 35)
fpsLabel.Position = UDim2.new(0, 0, 0, 45)
fpsLabel.BackgroundTransparency = 1
fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
fpsLabel.TextSize = 14
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.Text = "FPS: Menghitung..."
fpsLabel.Parent = mainFrame

-- 3. LOOP UNTUK UPDATE ANGKA FPS REAL-TIME
local runService = game:GetService("RunService")
local lastUpdate = tick()
local frameCount = 0

runService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local currentTime = tick()
    
    if currentTime - lastUpdate >= 0.5 then
        local currentFPS = math.floor(frameCount / (currentTime - lastUpdate))
        fpsLabel.Text = "FPS: " .. currentFPS .. " (Optimal)"
        
        if currentFPS < 30 then
            fpsLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        elseif currentFPS < 60 then
            fpsLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
        else
            fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
        end
        
        frameCount = 0
        lastUpdate = currentTime
    end
end)
