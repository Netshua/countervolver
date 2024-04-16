-- ══════════════════════════════════════
--            Principal
-- ══════════════════════════════════════
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local CounterGui = Instance.new("ScreenGui")
CounterGui.Name = "CounterGui"
CounterGui.Parent = game.CoreGui

local CounterLabels = {}
local CounterPositions = {
    "CEsquerda: ",
    "CDireita: ",
    "CRetaguarda: ",
    "CTotal: "
}

for i, position in ipairs(CounterPositions) do
    local CounterLabel = Instance.new("TextLabel")
    CounterLabel.Name = "CounterLabel" .. i
    CounterLabel.Parent = CounterGui
    CounterLabel.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    CounterLabel.BackgroundTransparency = 0.660
    CounterLabel.Position = UDim2.new(0, 0, 0.1 * i, 0)
    CounterLabel.Size = UDim2.new(0.2, 0, 0.1, 0)
    CounterLabel.Font = Enum.Font.SourceSans
    CounterLabel.Text = position .. "0"
    CounterLabel.TextScaled = true
    CounterLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    CounterLabel.TextSize = 24.000
    CounterLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    CounterLabels[i] = CounterLabel
end

local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = CounterGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
ToggleButton.BackgroundTransparency = 0.660
ToggleButton.Position = UDim2.new(0, 0, 0.5, 0)
ToggleButton.Size = UDim2.new(0.1, 0, 0.05, 0)
ToggleButton.Font = Enum.Font.SourceSans
ToggleButton.Text = "x"
ToggleButton.TextScaled = true
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 24.000
ToggleButton.TextXAlignment = Enum.TextXAlignment.Center

local isHidden = false
ToggleButton.MouseButton1Click:Connect(function()
    isHidden = not isHidden
    for _, label in ipairs(CounterLabels) do
        label.Visible = not isHidden
    end
end)

-- ══════════════════════════════════════
--             Função do contador
-- ══════════════════════════════════════
local counters = {0, 0, 0, 0}
local function ToUpdate(message)
    local CMessage = string.gsub(message, "%s", "")

    if CMessage == "DIREITAVOLVER!" then
        counters[2] = counters[2] + 1
        counters[4] = counters[4] + 1
    elseif CMessage == ".talkDIREITAVOLVER!" then
    	counters[2] = counters[2] + 1
    	counters[4] = counters[4] + 1
    elseif CMessage == "ESQUERDAVOLVER!" then
        counters[1] = counters[1] + 1
        counters[4] = counters[4] - 1
    elseif CMessage == ".talkESQUERDAVOLVER!" then
        counters[1] = counters[1] + 1
        counters[4] = counters[4] - 1
    elseif CMessage == "RETAGUARDAVOLVER!" then
        counters[3] = counters[3] + 1
        counters[4] = counters[4] + 2
    elseif CMessage == ".talkRETAGUARDAVOLVER!" then
        counters[3] = counters[3] + 1
        counters[4] = counters[4] + 2
    end

    for i, counter in ipairs(counters) do
        CounterLabels[i].Text = CounterPositions[i] .. counter
    end
end

for _, player in ipairs(game.Players:GetPlayers()) do
    player.Chatted:Connect(function(message)
        ToUpdate(message)
    end)
end
