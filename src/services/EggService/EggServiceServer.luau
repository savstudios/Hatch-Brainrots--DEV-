local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EggInfo = require(script.Parent.Parent.EggInfo)
local audio = ReplicatedStorage.Assets.Audio

local EggServiceServer = {}

function EggServiceServer.Init(self: EggServiceServer)
	
end

function EggServiceServer.SetupEgg(self: EggServiceServer, eggName: string, eggModel: Model)
    self:DisplayStats(eggName, eggModel)
    self:SetupPrompt(eggName, eggModel)
end

function EggServiceServer.DisplayStats(self: EggServiceServer, eggName: string, eggModel: Model)
    local eggData = EggInfo.Info[eggName]
    local eggInfoUI = ReplicatedStorage.Assets.UI.EggInfo:Clone()
    eggInfoUI.Parent = eggModel:FindFirstChild("Root")

    local eggText = eggInfoUI.EggName
    local eggPrice = eggInfoUI.EggPrice

    eggText.Text = eggData.Name
    eggText.TextColor3 = eggData.Color
    eggPrice.Text = '$'..tostring(eggData.Price)

    print(eggData)
end

function EggServiceServer.SetupPrompt(self: EggServiceServer, eggName: string, eggModel: Model)
    local prompt: ProximityPrompt = Instance.new("ProximityPrompt", eggModel:FindFirstChild("Root"))
    local eggData = EggInfo.Info[eggName]

    prompt.HoldDuration = 0.5
    prompt.ActionText = "Purchase Egg"
    prompt.MaxActivationDistance = 10

    prompt.Triggered:Connect(function()
        audio:WaitForChild(eggData.Name):Play()
    end)
end

type EggServiceServer = typeof(EggServiceServer) & {
	
}

return EggServiceServer :: EggServiceServer