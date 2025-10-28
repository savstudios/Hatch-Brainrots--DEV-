local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")

local services = ServerScriptService.Services

local spawnService = require(services.SpawnService.SpawnServiceServer)
local plotService = require(services.PlotService.PlotServiceServer)

spawnService:Init()

Players.PlayerAdded:Connect(function(player) 
	plotService:PlayerLoaded(player)
end)

Players.PlayerRemoving:Connect(function(player)
	plotService:PlayerLeft(player)
end)

while task.wait(spawnService.SPAWN_COOLDOWN) do
	spawnService:SelectEggRandom()
	
	spawnService:SpawnEgg()
end