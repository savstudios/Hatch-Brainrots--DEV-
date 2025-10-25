local ServerScriptService = game:GetService("ServerScriptService")

local services = ServerScriptService.Services

local spawnService = require(services.SpawnService.SpawnServiceServer)

spawnService:Init()

while task.wait(0.5) do
	spawnService:SelectEggRandom()
	
	spawnService:SpawnEgg()
end